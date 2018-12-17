version 1.0

import "compare-gff/comparegff.wdl" as comparegff
import "expression-quantification/multi-bam-quantify.wdl" as expressionQuantification
import "jointgenotyping/jointgenotyping.wdl" as jointgenotyping
import "rna-coding-potential/rna-coding-potential.wdl" as rnacodingpotential
import "sample.wdl" as sampleWorkflow
import "structs.wdl" as structs
import "tasks/biopet/biopet.wdl" as biopet
import "tasks/biopet/sampleconfig.wdl" as sampleconfig
import "tasks/common.wdl" as common
import "tasks/multiqc.wdl" as multiqc

workflow pipeline {
    input {
        File sampleConfigFile
        Array[Sample] samples = []
        String outputDir
        Reference reference
        IndexedVcfFile? dbsnp
        String starIndexDir
        String strandedness
        File? refflatFile
        File? referenceGtfFile
        Array[File] lncRNAdatabases = []
        Boolean variantCalling = false
        Boolean lncRNAdetection = false
        File? cpatLogitModel
        File? cpatHex
    }

    String expressionDir = outputDir + "/expression_measures/"
    String genotypingDir = outputDir + "/multisample_variants/"

    # Validation of annotations
    # If these are given.
    if (defined(referenceGtfFile) && defined(refflatFile)) {
        call biopet.ValidateAnnotation as validateAnnotation {
            input:
                refRefflat = select_first([refflatFile]),
                gtfFile = select_first([referenceGtfFile]),
                reference = reference
        }
    }

    # Validation of dbsnp
    if (defined(dbsnp)) {
        call biopet.ValidateVcf as validateVcf {
            input:
                vcf = select_first([dbsnp]),
                reference = reference
        }
    }

    call common.YamlToJson {
        input:
            yaml = sampleConfigFile,
            # Put the output json in a fixed directory for call-caching reasons
            outputJson = outputDir + "/samples.json"
    }
    SampleConfig sampleConfig = read_json(YamlToJson.json)

    # Adding with `+` does not seem to work. But it works with flatten.
    Array[Sample] allSamples = flatten([samples, sampleConfig.samples])

    scatter (sm in allSamples) {
        call sampleWorkflow.Sample as sample {
            input:
                sample = sm,
                outputDir = outputDir + "/samples/" + sm.id,
                reference = reference,
                dbsnp = dbsnp,
                starIndexDir = starIndexDir,
                strandedness = strandedness,
                refflatFile = refflatFile,
                variantCalling = variantCalling
        }
    }

    call expressionQuantification.MultiBamExpressionQuantification as expression {
        input:
            bams = zip(sample.sampleName, sample.bam),
            outputDir = expressionDir,
            strandedness = strandedness,
            #refflatFile = refflatFile,
            referenceGtfFile = referenceGtfFile
    }

    if (variantCalling) {
        call jointgenotyping.JointGenotyping as genotyping {
            input:
                reference = reference,
                outputDir = genotypingDir,
                gvcfFiles = select_all(sample.gvcfFile),
                vcfBasename = "multisample",
                dbsnpVCF = select_first([dbsnp])
        }

        call biopet.VcfStats as vcfStats {
            input:
                vcf = genotyping.vcfFile,
                reference = reference,
                outputDir = genotypingDir + "/stats"
        }
        File vcfFile = genotyping.vcfFile.file
    }

    if (lncRNAdetection) {
        scatter (sampleGtfFile in expression.sampleGtfFiles) {
            File sampleGtf = sampleGtfFile.right
            String sampleId = sampleGtfFile.left
            call rnacodingpotential.RnaCodingPotential {
                input:
                    outputDir = outputDir + "/samples/" + sampleId + "/coding-potential",
                    transcriptsGff = sampleGtf,
                    reference = reference,
                    cpatLogitModel = select_first([cpatLogitModel]),
                    cpatHex = select_first([cpatHex])
            }

            call comparegff.CompareGff {
                input:
                    outputDir = outputDir + "/samples/" +sampleId + "/compare-gff",
                    sampleGtf = sampleGtf,
                    databases = lncRNAdatabases
            }
        }
        # These files are created so that multiqc has some dependencies to wait for.
        # In theory this could be done by all sort of flattening array stuff, but
        # this is the simplest way. I could not get the other ways to work.
        File cpatOutputs = write_lines(RnaCodingPotential.cpatOutput)
        File gffComparisons = write_lines(flatten(CompareGff.annotatedGtfs))
    }

    call multiqc.MultiQC as multiqcTask {
        input:
            # Multiqc will only run if these files are created.
            # Need to do some select_all and flatten magic here
            # so only outputs from workflows that are run are taken
            # as dependencies
            # vcfFile
            dependencies = select_all([expression.TPMTable, cpatOutputs, gffComparisons, vcfFile]),
            outDir = outputDir + "/multiqc",
            analysisDirectory = outputDir
    }

    output {
        File report = multiqcTask.multiqcReport
    }
}
