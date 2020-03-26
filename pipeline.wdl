version 1.0

# Copyright (c) 2018 Leiden University Medical Center
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

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
        File referenceFasta
        File referenceFastaFai
        File referenceFastaDict
        File? dbsnpVCF
        File? dbsnpVCFIndex
        Array[File]+? starIndex
        Array[File]+? hisat2Index
        String? adapterForward = "AGATCGGAAGAG"  # Illumina universal adapter
        String? adapterReverse = "AGATCGGAAGAG"  # Illumina universal adapter
        String platform = "illumina"
        String strandedness
        File? refflatFile
        File? referenceGtfFile
        Array[File] lncRNAdatabases = []
        Boolean jointgenotyping = false
        Boolean variantCalling = false
        Boolean lncRNAdetection = false
        Boolean detectNovelTranscripts = false
        File? cpatLogitModel
        File? cpatHex
        Boolean umiDeduplication = false
        Boolean collectUmiStats = false
        File dockerImagesFile
        Int scatterSizeMillions = 1000
        Int scatterSize = scatterSizeMillions * 1000000
        # Only run multiQC if the user specified an outputDir
        Boolean runMultiQC = outputDir != "."

        File? XNonParRegions
        File? YNonParRegions
        File? variantCallingRegions

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
                referenceFasta = referenceFasta,
                referenceFastaFai = referenceFastaFai,
                referenceFastaDict = referenceFastaDict,
                starIndex = starIndex,
                hisat2Index = hisat2Index,
                strandedness = strandedness,
                refflatFile = refflatFile,
                umiDeduplication = umiDeduplication,
                collectUmiStats = collectUmiStats,
                adapterForward = adapterForward,
                adapterReverse = adapterReverse,
                platform = platform,
                dockerImages = dockerImages
        }
        IndexedBamFile markdupBams = {"file": sampleJobs.outputBam, "index": sampleJobs.outputBamIndex}
        if (variantCalling) {
        # Preprocess BAM for variant calling
            call preprocess.GatkPreprocess as preprocessing {
                input:
                    bam = sampleJobs.outputBam,
                    bamIndex = sampleJobs.outputBamIndex,
                    outputDir = outputDir + "/samples/" + sample.id + "/",
                    bamName = sample.id + ".markdup.bqsr",
                    splitSplicedReads = true,
                    dbsnpVCF = select_first([dbsnpVCF]),
                    dbsnpVCFIndex = select_first([dbsnpVCFIndex]),
                    referenceFasta = referenceFasta,
                    referenceFastaFai = referenceFastaFai,
                    referenceFastaDict = referenceFastaDict,
                    dockerImages = dockerImages,
                    scatterSize = scatterSize
            }
            BamAndGender bamGenders = object {file: preprocessing.recalibratedBam, index: preprocessing.recalibratedBamIndex, gender: sample.gender }
        }
    }

    if (variantCalling) {
        call variantCallingWorkflow.GatkVariantCalling as variantcalling {
            input:
                bamFilesAndGenders = select_all(bamGenders),
                outputDir = outputDir + "/multisample_variants/",
                dbsnpVCF = select_first([dbsnpVCF]),
                dbsnpVCFIndex = select_first([dbsnpVCFIndex]),
                referenceFasta = referenceFasta,
                referenceFastaFai = referenceFastaFai,
                referenceFastaDict = referenceFastaDict,
                dockerImages = dockerImages,
                regions = variantCallingRegions,
                XNonParRegions = XNonParRegions,
                YNonParRegions = YNonParRegions,
                jointgenotyping=jointgenotyping,
                dockerImages = dockerImages,
                scatterSize = scatterSize
        }
    }

    call expressionQuantification.MultiBamExpressionQuantification as expression {
        input:
            bams = zip(sampleJobs.sampleName, markdupBams),
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
                genomicSequence = referenceFasta,
                genomicIndex = referenceFastaFai,
                exonsFastaPath = outputDir + "/lncrna/coding-potential/transcripts.fasta",
                dockerImage = dockerImages["gffread"]
        }

        call cpat.CPAT as CPAT {
            input:
                gene = select_first([gffread.exonsFasta]),
                referenceGenome = referenceFasta,
                referenceGenomeIndex = referenceFastaFai,
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
        File? outputGVcf = variantcalling.outputGVcf
        File? outputGVcfIndex = variantcalling.outputGVcfIndex
        Array[File]? singleSampleVcfs = variantcalling.singleSampleVcfs
        Array[File]? singleSampleVcfsIndex = variantcalling.singleSampleVcfsIndex
        Array[File]? singleSampleGvcfs = variantcalling.singleSampleGvcfs
        Array[File]? singleSampleGvcfsIndex = variantcalling.singleSampleGvcfsIndex
        File? cpatOutput = CPAT.outFile
        Array[File]? annotatedGtf = GffCompare.annotated
        Array[File] bamFiles = sampleJobs.outputBam
        Array[File] bamFilesIndex = sampleJobs.outputBamIndex
        Array[File?] umiEditDistance = sampleJobs.umiEditDistance
        Array[File?] umiStats = sampleJobs.umiStats
        Array[File?] umiPositionStats = sampleJobs.umiPositionStats
    }

    parameter_meta {
        sampleConfigFile: {description: "The samplesheet, including sample ids, library ids, readgroup ids and fastq file locations.",
                           category: "required"}
        outputDir: {description: "The output directory.", category: "required"}
        referenceFasta: { description: "The reference fasta file", category: "required" }
        referenceFastaFai: { description: "Fasta index (.fai) file of the reference", category: "required" }
        referenceFastaDict: { description: "Sequence dictionary (.dict) file of the reference", category: "required" }
        dbsnpVCF: { description: "dbsnp VCF file used for checking known sites", category: "common"}
        dbsnpVCFIndex: { description: "Index (.tbi) file for the dbsnp VCF", category: "common"}
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
        jointgenotyping: {description: "Whether joint genotyping should be performed when Variant Calling. Default: false. Warning: joint genotyping is not part of GATK best practices", category: "advanced"}
        lncRNAdetection: {description: "Whether or not lncRNA detection should be run. This will enable detectNovelTranscript (this cannot be disabled by setting detectNovelTranscript to false). This will require cpatLogitModel and cpatHex to be defined.",
                          category: "common"}
        detectNovelTranscripts: {description: "Whether or not a transcripts assembly should be used. If set to true Stringtie will be used to create a new GTF file based on the BAM files. This generated GTF file will be used for expression quantification. If `referenceGtfFile` is also provided this reference GTF will be used to guide the assembly.",
                                 category: "common"}
        cpatLogitModel: {description: "A logit model for CPAT. Required if lncRNAdetection is `true`.", category: "common"}
        cpatHex: {description: "A hexamer frequency table for CPAT. Required if lncRNAdetection is `true`.", category: "common"}
        umiDeduplication: {description: "Whether or not UMI based deduplication should be performed.", category: "common"}
        collectUmiStats: {description: "Whether or not UMI deduplication stats should be collected. This will potentially cause a massive increase in memory usage of the deduplication step.",
          category: "advanced"}
        variantCallingRegions: {description: "A bed file describing the regions to operate on for variant calling.", category: "common"}
        XNonParRegions: {description: "Bed file with the non-PAR regions of X for variant calling", category: "advanced"}
        YNonParRegions: {description: "Bed file with the non-PAR regions of Y for variant calling", category: "advanced"}
        adapterForward: {description: "The adapter to be removed from the reads first or single end reads.", category: "common"}
        adapterReverse: {description: "The adapter to be removed from the reads second end reads.", category: "common"}
        platform: {description: "The platform used for sequencing.", category: "advanced"}
        dockerImagesFile: {description: "A YAML file describing the docker image used for the tasks. The dockerImages.yml provided with the pipeline is recommended.",
                           category: "advanced"}
        runMultiQC: {description: "Whether or not MultiQC should be run.", category: "advanced"}
        scatterSize: {description: "The size of the scattered regions in bases for the GATK subworkflows. Scattering is used to speed up certain processes. The genome will be seperated into multiple chunks (scatters) which will be processed in their own job, allowing for parallel processing. Higher values will result in a lower number of jobs. The optimal value here will depend on the available resources.",
              category: "advanced"}
        scatterSizeMillions:{ description: "Same as scatterSize, but is multiplied by 1000000 to get scatterSize. This allows for setting larger values more easily.",
                              category: "advanced"}

    }
}
