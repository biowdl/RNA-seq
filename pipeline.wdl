version 1.0

import "expression-quantification/multi-bam-quantify.wdl" as expressionQuantification
import "jointgenotyping/jointgenotyping.wdl" as jointgenotyping
import "sample.wdl" as sampleWorkflow
import "structs.wdl" as structs
import "tasks/biopet/biopet.wdl" as biopet
import "tasks/biopet/sampleconfig.wdl" as sampleconfig
import "tasks/common.wdl" as common
import "tasks/gffcompare.wdl" as gffcompare
import "tasks/multiqc.wdl" as multiqc
import "tasks/CPAT.wdl" as cpat
import "tasks/gffread.wdl" as gffread

workflow pipeline {
    input {
        File sampleConfigFile
        Array[Sample] samples = []
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
        Boolean detectNovelTranscipts = false
        File? cpatLogitModel
        File? cpatHex
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

    call common.YamlToJson as ConvertSampleConfig {
        input:
            yaml = sampleConfigFile,
            outputJson = outputDir + "/samples.json"
    }
    SampleConfig sampleConfig = read_json(ConvertSampleConfig.json)
    Array[Sample] allSamples = flatten([samples, sampleConfig.samples])

    # Start processing of data
    scatter (sm in allSamples) {
        call sampleWorkflow.Sample as sample {
            input:
                sample = sm,
                outputDir = outputDir + "/samples/" + sm.id,
                reference = reference,
                dbsnp = dbsnp,
                starIndex = starIndex,
                hisat2Index = hisat2Index,
                strandedness = strandedness,
                refflatFile = refflatFile,
                variantCalling = variantCalling,
                dockerImages = dockerImages
        }
    }

    call expressionQuantification.MultiBamExpressionQuantification as expression {
        input:
            bams = zip(sample.sampleName, sample.bam),
            outputDir = expressionDir,
            strandedness = strandedness,
            referenceGtfFile = referenceGtfFile,
            detectNovelTranscripts = lncRNAdetection || detectNovelTranscipts,
            dockerImages = dockerImages
    }

    if (variantCalling) {
        call jointgenotyping.JointGenotyping as genotyping {
            input:
                reference = reference,
                outputDir = genotypingDir,
                gvcfFiles = select_all(sample.gvcfFile),
                vcfBasename = "multisample",
                dbsnpVCF = select_first([dbsnp]),
                dockerImages = dockerImages
        }
        File vcfFile = genotyping.vcfFile.file
        # TODO: Look for a MultiQC VCF-stats tool with good performance.
    }


    if (lncRNAdetection) {
        call gffread.GffRead as gffread {
            input:
                inputGff = select_first([expression.mergedGtfFile]),
                genomicSequence = reference.fasta,
                genomicIndex = reference.fai,
                exonsFastaPath = outputDir + "/lncrna/coding-potential"+ "/transcripts.fasta",
                dockerImage = dockerImages["gffread"]
        }

        call cpat.CPAT as CPAT {
            input:
                gene = select_first([gffread.exonsFasta]),
                referenceGenome = reference.fasta,
                referenceGenomeIndex = reference.fai,
                hex = select_first([cpatHex]),
                logitModel = select_first([cpatLogitModel]),
                outFilePath = outputDir + "/lncrna/coding-potential" + "/cpat.tsv",
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
                dependencies = select_all([expression.TPMTable, cpatOutputs, gffComparisons, vcfFile]),
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
        IndexedVcfFile? variants = genotyping.vcfFile
        File? cpatOutput = CPAT.outFile
        Array[File]? annotatedGtf = GffCompare.annotated
        Array[IndexedBamFile] bamFiles = sample.bam
    }
}
