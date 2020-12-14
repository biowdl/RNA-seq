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
import "gatk-preprocess/gatk-preprocess.wdl" as preprocess
import "gatk-variantcalling/calculate-regions.wdl" as calcRegions
import "gatk-variantcalling/single-sample-variantcalling.wdl" as variantCallingWorkflow
import "sample.wdl" as sampleWorkflow
import "structs.wdl" as structs
import "tasks/biowdl.wdl" as biowdl
import "tasks/chunked-scatter.wdl" as chunkedScatter
import "tasks/common.wdl" as common
import "tasks/CPAT.wdl" as cpat
import "tasks/gffcompare.wdl" as gffcompare
import "tasks/gffread.wdl" as gffread
import "tasks/multiqc.wdl" as multiqc
import "tasks/star.wdl" as star

workflow RNAseq {
    input {
        File sampleConfigFile
        String outputDir = "."
        File referenceFasta
        File referenceFastaFai
        File referenceFastaDict
        String platform = "illumina"
        String strandedness
        Array[File] lncRNAdatabases = []
        Boolean variantCalling = false
        Boolean lncRNAdetection = false
        Boolean detectNovelTranscripts = false
        Boolean umiDeduplication = false
        Boolean collectUmiStats = false
        Int scatterSizeMillions = 1000
        Boolean runStringtieQuantification = true

        File? dbsnpVCF
        File? dbsnpVCFIndex
        Array[File]+? starIndex
        Array[File]+? hisat2Index
        String? adapterForward = "AGATCGGAAGAG" # Illumina universal adapter.
        String? adapterReverse = "AGATCGGAAGAG" # Illumina universal adapter.
        File? refflatFile
        File? referenceGtfFile
        File? cpatLogitModel
        File? cpatHex
        Int? scatterSize
        File? XNonParRegions
        File? YNonParRegions
        File? variantCallingRegions

        File dockerImagesFile
    }

    meta {allowNestedInputs: true}

    String expressionDir = outputDir + "/expression_measures/"
    String genotypingDir = outputDir + "/multisample_variants/"

    # Parse docker Tags configuration and sample sheet.
    call common.YamlToJson as convertDockerTagsFile {
        input:
            yaml = dockerImagesFile,
            outputJson = outputDir + "/dockerImages.json"
    }

    Map[String, String] dockerImages = read_json(convertDockerTagsFile.json)

    call biowdl.InputConverter as convertSampleConfig {
        input:
            samplesheet = sampleConfigFile,
            outputFile = outputDir + "/samples.json"
    }

    SampleConfig sampleConfig = read_json(convertSampleConfig.json)

    # Generate STAR index of no indexes are given.
    if (!defined(starIndex) && !defined(hisat2Index)) {
        call star.GenomeGenerate as makeStarIndex {
            input:
                referenceFasta = referenceFasta,
                referenceGtf = referenceGtfFile,
                dockerImage = dockerImages["star"]
        }
    }

    if (variantCalling) {
        # Prepare variantcalling scatters.
        call calcRegions.CalculateRegions as calculateRegions {
            input:
                referenceFasta = referenceFasta,
                referenceFastaFai = referenceFastaFai,
                referenceFastaDict = referenceFastaDict,
                XNonParRegions = XNonParRegions,
                YNonParRegions = YNonParRegions,
                regions = variantCallingRegions,
                scatterSize = scatterSize,
                scatterSizeMillions = scatterSizeMillions,
                dockerImages = dockerImages
        }

        # Prepare GATK preprocessing scatters.
        call chunkedScatter.ScatterRegions as scatterList {
            input:
                inputFile = select_first([variantCallingRegions, referenceFastaFai]),
                scatterSize = scatterSize,
                scatterSizeMillions = scatterSizeMillions,
                dockerImage = dockerImages["chunked-scatter"]
        }
    }

    # Start processing of data.
    scatter (sample in sampleConfig.samples) {
        call sampleWorkflow.SampleWorkflow as sampleJobs {
            input:
                sample = sample,
                outputDir = outputDir + "/samples/" + sample.id,
                referenceFasta = referenceFasta,
                referenceFastaFai = referenceFastaFai,
                referenceFastaDict = referenceFastaDict,
                starIndex = if defined(starIndex) then starIndex else makeStarIndex.starIndex,
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
                    scatters = select_first([scatterList.scatters])
            }

            call variantCallingWorkflow.SingleSampleCalling as variantcalling {
                input:
                    bam = preprocessing.recalibratedBam,
                    bamIndex = preprocessing.recalibratedBamIndex,
                    gender = select_first([sample.gender, "unknown"]),
                    sampleName = sample.id,
                    outputDir = outputDir + "/samples/" + sample.id,
                    referenceFasta = referenceFasta,
                    referenceFastaFai = referenceFastaFai,
                    referenceFastaDict = referenceFastaDict,
                    dbsnpVCF = select_first([dbsnpVCF]),
                    dbsnpVCFIndex = select_first([dbsnpVCFIndex]),
                    XNonParRegions = calculateRegions.Xregions,
                    YNonParRegions = calculateRegions.Yregions,
                    dontUseSoftClippedBases = true,  # This is necessary for RNA
                    standardMinConfidenceThresholdForCalling = 20.0,  # GATK best practice
                    autosomalRegionScatters = select_first([calculateRegions.autosomalRegionScatters]),
                    dockerImages = dockerImages
            }
        }
    }

    call expressionQuantification.MultiBamExpressionQuantification as expression {
        input:
            bams = zip(sampleJobs.sampleName, markdupBams),
            outputDir = expressionDir,
            strandedness = strandedness,
            referenceGtfFile = referenceGtfFile,
            detectNovelTranscripts = lncRNAdetection || detectNovelTranscripts,
            runStringtieQuantification = runStringtieQuantification,
            dockerImages = dockerImages
    }

    if (lncRNAdetection) {
        call gffread.GffRead as gffreadTask {
            input:
                inputGff = select_first([expression.mergedGtfFile]),
                genomicSequence = referenceFasta,
                genomicIndex = referenceFastaFai,
                exonsFastaPath = outputDir + "/lncrna/coding-potential/transcripts.fasta",
                dockerImage = dockerImages["gffread"]
        }

        call cpat.CPAT as CPAT {
            input:
                gene = select_first([gffreadTask.exonsFasta]),
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

        Array[File] gffComparisonFiles = flatten(GffCompare.allFiles)
    }
    
    Array[File] sampleJobReports = flatten(sampleJobs.reports)
    Array[File] baseRecalibrationReports = select_all(flatten([preprocessing.BQSRreport]))
    Array[File] quantificationReports = flatten([expression.sampleFragmentsPerGeneTables, [expression.fragmentsPerGeneTable]])
    Array[File] variantCallingReports = flatten(select_all(variantcalling.reports))
    Array[File] allReports = flatten([sampleJobReports, baseRecalibrationReports, quantificationReports, variantCallingReports])

    call multiqc.MultiQC as multiqcTask {
        input:
            reports = allReports,
            outDir = outputDir,
            dockerImage = dockerImages["multiqc"]
    }

    output {
        File report = multiqcTask.multiqcReport
        File dockerImagesList = convertDockerTagsFile.json
        File fragmentsPerGeneTable = expression.fragmentsPerGeneTable
        File? FPKMTable = expression.FPKMTable
        File? TPMTable = expression.TPMTable
        File? mergedGtfFile = expression.mergedGtfFile
        Array[File] singleSampleVcfs = select_all(variantcalling.outputVcf)
        Array[File] singleSampleVcfsIndex = select_all(variantcalling.outputVcfIndex)
        File? cpatOutput = CPAT.outFile
        Array[File]? annotatedGtf = GffCompare.annotated
        Array[File] bamFiles = sampleJobs.outputBam
        Array[File] bamFilesIndex = sampleJobs.outputBamIndex
        Array[File] recalibratedBamFiles = select_all(preprocessing.recalibratedBam)
        Array[File] recalibratedBamFilesIndex = select_all(preprocessing.recalibratedBamIndex)
        Array[File?] umiEditDistance = sampleJobs.umiEditDistance
        Array[File?] umiStats = sampleJobs.umiStats
        Array[File?] umiPositionStats = sampleJobs.umiPositionStats
        Array[File]? generatedStarIndex = makeStarIndex.starIndex
        Array[File] reports = allReports
        Array[File]? gffCompareFiles = gffComparisonFiles
    }

    parameter_meta {
        # inputs
        sampleConfigFile: {description: "The samplesheet, including sample ids, library ids, readgroup ids and fastq file locations.", category: "required"}
        outputDir: {description: "The output directory.", category: "required"}
        referenceFasta: {description: "The reference fasta file.", category: "required"}
        referenceFastaFai: {description: "Fasta index (.fai) file of the reference.", category: "required"}
        referenceFastaDict: {description: "Sequence dictionary (.dict) file of the reference.", category: "required"}
        platform: {description: "The platform used for sequencing.", category: "advanced"}
        strandedness: {description: "The strandedness of the RNA sequencing library preparation. One of \"None\" (unstranded), \"FR\" (forward-reverse: first read equal transcript) or \"RF\" (reverse-forward: second read equals transcript).", category: "required"}
        lncRNAdatabases: {description: "A set of GTF files the assembled GTF file should be compared with. Only used if lncRNAdetection is set to `true`.", category: "common"}
        variantCalling: {description: "Whether or not variantcalling should be performed.", category: "common"}
        lncRNAdetection: {description: "Whether or not lncRNA detection should be run. This will enable detectNovelTranscript (this cannot be disabled by setting detectNovelTranscript to false). This will require cpatLogitModel and cpatHex to be defined.", category: "common"}
        detectNovelTranscripts: {description: "Whether or not a transcripts assembly should be used. If set to true Stringtie will be used to create a new GTF file based on the BAM files. This generated GTF file will be used for expression quantification. If `referenceGtfFile` is also provided this reference GTF will be used to guide the assembly.", category: "common"}
        umiDeduplication: {description: "Whether or not UMI based deduplication should be performed.", category: "common"}
        collectUmiStats: {description: "Whether or not UMI deduplication stats should be collected. This will potentially cause a massive increase in memory usage of the deduplication step.", category: "advanced"}
        scatterSizeMillions: {description: "Same as scatterSize, but is multiplied by 1000000 to get scatterSize. This allows for setting larger values more easily.", category: "advanced"}
        runStringtieQuantification: {description: "Option to disable running stringtie for quantification. This does not affect the usage of stringtie for novel transcript detection.", category: "common"}
        dbsnpVCF: {description: "dbsnp VCF file used for checking known sites.", category: "common"}
        dbsnpVCFIndex: {description: "Index (.tbi) file for the dbsnp VCF.", category: "common"}
        starIndex: {description: "The star index files. Defining this will cause the star aligner to run and be used for downstream analyses. May be ommited if hisat2Index is defined.", category: "required"}
        hisat2Index: {description: "The hisat2 index files. Defining this will cause the hisat2 aligner to run. Note that is starIndex is also defined the star results will be used for downstream analyses. May be omitted in starIndex is defined.", category: "required"}
        adapterForward: {description: "The adapter to be removed from the reads first or single end reads.", category: "common"}
        adapterReverse: {description: "The adapter to be removed from the reads second end reads.", category: "common"}
        refflatFile: {description: "A refflat files describing the genes. If this is defined RNAseq metrics will be collected.", category: "common"}
        referenceGtfFile: {description: "A reference GTF file. Used for expression quantification or to guide the transcriptome assembly if detectNovelTranscripts is set to `true` (this GTF won't be be used directly for the expression quantification in that case.", category: "common"}
        cpatLogitModel: {description: "A logit model for CPAT. Required if lncRNAdetection is `true`.", category: "common"}
        cpatHex: {description: "A hexamer frequency table for CPAT. Required if lncRNAdetection is `true`.", category: "common"}
        scatterSize: {description: "The size of the scattered regions in bases for the GATK subworkflows. Scattering is used to speed up certain processes. The genome will be seperated into multiple chunks (scatters) which will be processed in their own job, allowing for parallel processing. Higher values will result in a lower number of jobs. The optimal value here will depend on the available resources.", category: "advanced"}
        XNonParRegions: {description: "Bed file with the non-PAR regions of X for variant calling.", category: "advanced"}
        YNonParRegions: {description: "Bed file with the non-PAR regions of Y for variant calling.", category: "advanced"}
        variantCallingRegions: {description: "A bed file describing the regions to operate on for variant calling.", category: "common"}
        dockerImagesFile: {description: "A YAML file describing the docker image used for the tasks. The dockerImages.yml provided with the pipeline is recommended.", category: "advanced"}


        # outputs
        report: {description: ""}
        dockerImagesList: {description: "Json file describing the docker images used by the pipeline."}
        fragmentsPerGeneTable: {description: ""}
        FPKMTable: {description: ""}
        TMPTable: {description: ""}
        mergedGtfFile: {description: ""}
        singleSampleVcfs: {description: ""}
        singleSampleVcfsIndex: {description: ""}
        cpatOutput: {description: ""}
        annotatedGtf: {description: ""}
        bamFiles: {description: ""}
        bamFilesIndex: {description: ""}
        recalibratedBamFiles: {description: ""}
        recalibratedBamFilesIndex: {description: ""}
        umiEditDistance: {description: ""}
        umiStats: {description: ""}
        umiPositionStats: {description: ""}
        generatedStarIndex: {description: ""}
        reports: {description: ""}
        gffCompareFiles: {description: ""}
    }
}
