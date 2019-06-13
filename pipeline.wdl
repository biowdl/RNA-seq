version 1.0

import "expression-quantification/multi-bam-quantify.wdl" as expressionQuantification
import "jointgenotyping/jointgenotyping.wdl" as jointgenotyping
import "rna-coding-potential/rna-coding-potential.wdl" as rnacodingpotential
import "sample.wdl" as sampleWorkflow
import "structs.wdl" as structs
import "tasks/biopet/biopet.wdl" as biopet
import "tasks/biopet/sampleconfig.wdl" as sampleconfig
import "tasks/common.wdl" as common
import "tasks/gffcompare.wdl" as gffcompare
import "tasks/multiqc.wdl" as multiqc

workflow pipeline {
    input {
        File sampleConfigFile
        Array[Sample] samples = []
        String outputDir
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
        File dockerTagsFile
    }

    String expressionDir = outputDir + "/expression_measures/"
    String genotypingDir = outputDir + "/multisample_variants/"

    # Parse docker Tags configuration and sample sheet
    call common.YamlToJson as ConvertDockerTagsFile {
        input:
            yaml = dockerTagsFile,
            outputJson = outputDir + "/dockerTags.json"
    }
    Map[String, String] dockerTags = read_json(ConvertDockerTagsFile.json)

    call common.YamlToJson as ConvertSampleConfig {
        input:
            yaml = sampleConfigFile,
            outputJson = outputDir + "/samples.json"
    }
    SampleConfig sampleConfig = read_json(ConvertSampleConfig.json)
    Array[Sample] allSamples = flatten([samples, sampleConfig.samples])

    # validate dnsnp
    if (defined(dbsnp)) {
        IndexedVcfFile definedDBsnp = select_first([dbsnp])
        call biopet.ValidateVcf as validateVcf {
            input:
                vcf = definedDBsnp,
                reference = reference,
                dockerTag = dockerTags["biopet-validatevcf"]
        }
    }

    # validate annotations
    if (defined(referenceGtfFile) && defined(refflatFile)) {
        call biopet.ValidateAnnotation as validateAnnotation {
            input:
                refRefflat = refflatFile,
                gtfFile = referenceGtfFile,
                reference = reference,
                dockerTag = dockerTags["biopet-validateannotation"]
        }
    }

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
                dockerTags = dockerTags
        }
    }

    call expressionQuantification.MultiBamExpressionQuantification as expression {
        input:
            bams = zip(sample.sampleName, sample.bam),
            outputDir = expressionDir,
            strandedness = strandedness,
            referenceGtfFile = referenceGtfFile,
            detectNovelTranscripts = lncRNAdetection || detectNovelTranscipts,
            dockerTags = dockerTags
    }

    if (variantCalling) {
        call jointgenotyping.JointGenotyping as genotyping {
            input:
                reference = reference,
                outputDir = genotypingDir,
                gvcfFiles = select_all(sample.gvcfFile),
                vcfBasename = "multisample",
                dbsnpVCF = select_first([dbsnp]),
                dockerTags = dockerTags
        }

        # TODO: Look for a MultiQC replacement with good performance.
        call biopet.VcfStats as vcfStats {
            input:
                vcf = genotyping.vcfFile,
                reference = reference,
                outputDir = genotypingDir + "/stats",
                dockerTag = dockerTags["biopet-vcfstats"]
        }
        File vcfFile = genotyping.vcfFile.file
    }

    if (lncRNAdetection) {
        call rnacodingpotential.RnaCodingPotential as RnaCodingPotential {
            input:
                outputDir = outputDir + "/lncrna/coding-potential",
                transcriptsGff = select_first([expression.mergedGtfFile]),
                referenceFasta = reference.fasta,
                referenceFastaIndex = reference.fai,
                cpatLogitModel = select_first([cpatLogitModel]),
                cpatHex = select_first([cpatHex]),
                dockerTags = dockerTags
        }

        scatter (database in lncRNAdatabases) {
            call gffcompare.GffCompare as GffCompare {
                input:
                    inputGtfFiles = select_all([expression.mergedGtfFile]),
                    referenceAnnotation = database,
                    outputDir = outputDir + "/lncrna/" + basename(database) + ".d",
                    dockerTag = dockerTags["gffcompare"]
            }
        }
        # These files are created so that multiqc has some dependencies to wait for.
        # In theory this could be done by all sort of flattening array stuff, but
        # this is the simplest way. I could not get the other ways to work.
        File cpatOutputs = write_lines([RnaCodingPotential.cpatOutput])
        File gffComparisons = write_lines(GffCompare.annotated)
    }

    call multiqc.MultiQC as multiqcTask {
        input:
            # Multiqc will only run if these files are created.
            # Need to do some select_all and flatten magic here
            # so only outputs from workflows that are run are taken
            # as dependencies
            # vcfFile
            dependencies = select_all([expression.TPMTable, RnaCodingPotential.cpatOutput, gffComparisons, vcfFile]),
            outDir = outputDir + "/multiqc",
            analysisDirectory = outputDir,
            dockerTag = dockerTags["multiqc"]
    }

    output {
        File report = multiqcTask.multiqcReport
    }
}
