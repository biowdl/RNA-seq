version 1.0

import "expression-quantification/multi-bam-quantify.wdl" as expressionQuantification
import "jointgenotyping/jointgenotyping.wdl" as jointgenotyping
import "rna-coding-potential/rna-coding-potential.wdl" as rnacodingpotential
import "compare-gff/comparegff.wdl" as comparegff
import "sample.wdl" as sampleWorkflow
import "tasks/biopet/biopet.wdl" as biopet
import "tasks/biopet/sampleconfig.wdl" as sampleconfig
import "structs.wdl" as structs
import "tasks/common.wdl" as common

workflow pipeline {
    input {
        Array[File] sampleConfigFiles
        String outputDir
        Reference reference
        IndexedVcfFile? dbsnp
        String starIndexDir
        String strandedness
        File? refflatFile
        File? referenceGtfFile
        Array[File] lncRNAdatabases
        Boolean variantCalling = false
        Boolean lncRNAdetection = false
        File? cpatLogitModel
        File? cpatHex
    }

    String expressionDir = outputDir + "/expression_measures/"
    String genotypingDir = outputDir + "/multisample_variants/"

    # Validation of annotations and dbSNP
    # If these are given.
    # TODO: Discuss: Do we need this?
    if (variantCalling && defined(referenceGtfFile) && defined(dbsnp) && defined(refflatFile)) {
        call biopet.ValidateAnnotation as validateAnnotation {
            input:
                refRefflat = select_first([refflatFile]),
                gtfFile = select_first([referenceGtfFile]),
                reference = reference
        }

        call biopet.ValidateVcf as validateVcf {
            input:
                vcf = select_first([dbsnp]),
                reference = reference
        }
    }

    call sampleconfig.SampleConfigCromwellArrays as configFile {
      input:
        inputFiles = sampleConfigFiles,
        outputPath = "samples.json"
    }

    Root config = read_json(configFile.outputFile)

    scatter (sm in config.samples) {
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
                gvcfFiles = sample.gvcfFile,
                vcfBasename = "multisample",
                dbsnpVCF = dbsnp
        }

        call biopet.VcfStats as vcfStats {
            input:
                vcf = genotyping.vcfFile,
                reference = reference,
                outputDir = genotypingDir + "/stats"
        }
    }

    if (lncRNAdetection) {
        scatter (sampleGffFile in expression.gffFiles) {
            call rnacodingpotential.RnaCodingPotential {
                input:
                    outputDir = outputDir + "/coding-potential",
                    transcriptsGff = sampleGffFile,
                    reference = reference,
                    cpatLogitModel = select_first([cpatLogitModel]),
                    cpatHex = select_first([cpatHex])
            }

            call comparegff.CompareGff {
                input:
                    outputDir = outputDir + "/compare-gff",
                    sampleGtf = sampleGffFile,
                    databases = lncRNAdatabases
            }
        }
    }

    output {
    }
}
