version 1.0

import "expression-quantification/multi-bam-quantify.wdl" as expressionQuantification
import "gatk-variantcalling/gatk-variantcalling.wdl" as variantCallingWorkflow
import "gatk-preprocess/gatk-preprocess.wdl" as preprocess
import "sample.wdl" as sampleWorkflow
import "structs.wdl" as structs
import "tasks/biopet/biopet.wdl" as biopet
import "tasks/biopet/sampleconfig.wdl" as sampleconfig
import "tasks/common.wdl" as common
import "tasks/gffcompare.wdl" as gffcompare
import "tasks/multiqc.wdl" as multiqc
import "tasks/CPAT.wdl" as cpat
import "tasks/gffread.wdl" as gffread
import "tasks/biowdl.wdl" as biowdl

workflow pipeline {
    input {
        File sampleConfigFile
        String outputDir = "."
        Reference reference
        IndexedVcfFile? dbsnp
        Array[File]+? starIndex
        Array[File]+? hisat2Index
        String strandedness
        File? refflatFile
        File? referenceGtfFile
        Array[File] lncRNAdatabases = []
        Boolean variantCalling = false
        Boolean lncRNAdetection = false
        Boolean detectNovelTranscripts = false
        File? cpatLogitModel
        File? cpatHex
        Boolean umiDeduplication = false
        File dockerImagesFile
        # Only run multiQC if the user specified an outputDir
        Boolean runMultiQC = outputDir != "."
    }

    String expressionDir = outputDir + "/expression_measures/"
    String genotypingDir = outputDir + "/multisample_variants/"

    # Parse docker Tags configuration and sample sheet
    call common.YamlToJson as ConvertDockerTagsFile {
        input:
            yaml = dockerImagesFile,
            outputJson = outputDir + "/dockerImages.json"
    }
    Map[String, String] dockerImages = read_json(ConvertDockerTagsFile.json)

    call biowdl.InputConverter as ConvertSampleConfig {
        input:
            samplesheet = sampleConfigFile,
            outputFile = outputDir + "/samples.json"
    }
    SampleConfig sampleConfig = read_json(ConvertSampleConfig.json)

    # Start processing of data
    scatter (sample in sampleConfig.samples) {
        call sampleWorkflow.Sample as sampleJobs {
            input:
                sample = sample,
                outputDir = outputDir + "/samples/" + sample.id,
                reference = reference,
                starIndex = starIndex,
                hisat2Index = hisat2Index,
                strandedness = strandedness,
                refflatFile = refflatFile,
                bcPattern = bcPattern,
                umiDeduplication = umiDeduplication,
                dockerImages = dockerImages
        }

        if (variantCalling) {
        # Preprocess BAM for variant calling
            call preprocess.GatkPreprocess as preprocessing {
                input:
                    bamFile = sampleJobs.bam,
                    outputDir = outputDir + "/samples/" + sample.id + "/",
                    bamName = sample.id + ".markdup.bqsr",
                    outputRecalibratedBam = true,
                    splitSplicedReads = true,
                    dbsnpVCF = select_first([dbsnp]),
                    reference = reference,
                    dockerImages = dockerImages
            }
        }
    }

    if (variantCalling) {
        call variantCallingWorkflow.GatkVariantCalling as variantcalling {
            input:

                bamFiles = select_all(preprocessing.outputBamFile),
                outputDir = outputDir + "/multisample_variants/",
                dbsnpVCF = select_first([dbsnp]).file,
                dbsnpVCFIndex = select_first([dbsnp]).index,
                referenceFasta = reference.fasta,
                referenceFastaFai = reference.fai,
                referenceFastaDict = reference.dict,
                dockerImages = dockerImages
        }
    }

    call expressionQuantification.MultiBamExpressionQuantification as expression {
        input:
            bams = zip(sampleJobs.sampleName, sampleJobs.bam),
            outputDir = expressionDir,
            strandedness = strandedness,
            referenceGtfFile = referenceGtfFile,
            detectNovelTranscripts = lncRNAdetection || detectNovelTranscripts,
            dockerImages = dockerImages
    }

    if (lncRNAdetection) {
        call gffread.GffRead as gffread {
            input:
                inputGff = select_first([expression.mergedGtfFile]),
                genomicSequence = reference.fasta,
                genomicIndex = reference.fai,
                exonsFastaPath = outputDir + "/lncrna/coding-potential/transcripts.fasta",
                dockerImage = dockerImages["gffread"]
        }

        call cpat.CPAT as CPAT {
            input:
                gene = select_first([gffread.exonsFasta]),
                referenceGenome = reference.fasta,
                referenceGenomeIndex = reference.fai,
                hex = select_first([cpatHex]),
                logitModel = select_first([cpatLogitModel]),
                outFilePath = outputDir + "/lncrna/coding-potential/cpat.tsv",
                dockerImage = dockerImages["cpat"]
        }

        scatter (database in lncRNAdatabases) {
            call gffcompare.GffCompare as GffCompare {
                input:
                    inputGtfFiles = select_all([expression.mergedGtfFile]),
                    referenceAnnotation = database,
                    outputDir = outputDir + "/lncrna/" + basename(database) + ".d",
                    dockerImage = dockerImages["gffcompare"]
            }
        }
        # These files are created so that multiqc has some dependencies to wait for.
        # In theory this could be done by all sort of flattening array stuff, but
        # this is the simplest way. I could not get the other ways to work.
        File cpatOutputs = write_lines([CPAT.outFile])
        File gffComparisons = write_lines(GffCompare.annotated)
    }

    if (runMultiQC) {
        call multiqc.MultiQC as multiqcTask {
            input:
                # Multiqc will only run if these files are created.
                # Need to do some select_all and flatten magic here
                # so only outputs from workflows that are run are taken
                # as dependencies
                # vcfFile
                dependencies = select_all([expression.TPMTable, cpatOutputs, gffComparisons, variantcalling.outputVcfIndex]),
                outDir = outputDir + "/multiqc",
                analysisDirectory = outputDir,
                dockerImage = dockerImages["multiqc"]
        }
    }

    output {
        File? report = multiqcTask.multiqcReport
        File fragmentsPerGeneTable = expression.fragmentsPerGeneTable
        File FPKMTable = expression.FPKMTable
        File TMPTable = expression.TPMTable
        File? mergedGtfFile = expression.mergedGtfFile
        File? outputVcf = variantcalling.outputVcf
        File? outputVcfIndex = variantcalling.outputVcfIndex
        File? cpatOutput = CPAT.outFile
        Array[File]? annotatedGtf = GffCompare.annotated
        Array[IndexedBamFile] bamFiles = sampleJobs.bam
        Array[File?] umiEditDistance = sampleJobs.umiEditDistance
        Array[File?] umiStats = sampleJobs.umiStats
        Array[File?] umiPositionStats = sampleJobs.umiPositionStats
    }

    parameter_meta {
        sampleConfigFile: {description: "The samplesheet, including sample ids, library ids, readgroup ids and fastq file locations.",
                           category: "required"}
        outputDir: {description: "The output directory.", category: "required"}
        reference: {description: "The reference files: a fasta, its index and the associated sequence dictionary.", category: "required"}
        dbsnp: {description: "A dbSNP VCF file and its index.", category: "common"}
        starIndex: {description: "The star index files. Defining this will cause the star aligner to run and be used for downstream analyses. May be ommited if hisat2Index is defined.",
                    category: "required"}
        hisat2Index: {description: "The hisat2 index files. Defining this will cause the hisat2 aligner to run. Note that is starIndex is also defined the star results will be used for downstream analyses. May be omitted in starIndex is defined.",
                      category: "required"}
        strandedness: {description: "The strandedness of the RNA sequencing library preparation. One of \"None\" (unstranded), \"FR\" (forward-reverse: first read equal transcript) or \"RF\" (reverse-forward: second read equals transcript).",
                       category: "required"}
        refflatFile: {description: "A refflat files describing the genes. If this is defined RNAseq metrics will be collected.",
                      category: "common"}
        referenceGtfFile: {description: "A reference GTF file. Used for expression quantification or to guide the transcriptome assembly if detectNovelTranscripts is set to `true` (this GTF won't be be used directly for the expression quantification in that case.",
                           category: "common"}
        lncRNAdatabases: {description: "A set of GTF files the assembled GTF file should be compared with. Only used if lncRNAdetection is set to `true`.", category: "common"}
        variantCalling: {description: "Whether or not variantcalling should be performed.", category: "common"}
        lncRNAdetection: {description: "Whether or not lncRNA detection should be run. This will enable detectNovelTranscript (this cannot be disabled by setting detectNovelTranscript to false). This will require cpatLogitModel and cpatHex to be defined.",
                          category: "common"}
        detectNovelTranscripts: {description: "Whether or not a transcripts assembly should be used. If set to true Stringtie will be used to create a new GTF file based on the BAM files. This generated GTF file will be used for expression quantification. If `referenceGtfFile` is also provided this reference GTF will be used to guide the assembly.",
                                 category: "common"}
        cpatLogitModel: {description: "A logit model for CPAT. Required if lncRNAdetection is `true`.", category: "common"}
        cpatHex: {description: "A hexamer frequency table for CPAT. Required if lncRNAdetection is `true`.", category: "common"}
        umiDeduplication: {description: "Whether or not UMI based deduplication should be performed.", category: "common"}
        dockerImagesFile: {description: "A YAML file describing the docker image used for the tasks. The dockerImages.yml provided with the pipeline is recommended.",
                           category: "advanced"}
        runMultiQC: {description: "Whether or not MultiQC should be run.", category: "advanced"}
    }
}
