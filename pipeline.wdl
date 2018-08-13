version 1.0

import "expression-quantification/multi-bam-quantify.wdl" as expressionQuantification
import "jointgenotyping/jointgenotyping.wdl" as jointgenotyping
import "sample.wdl" as sampleWorkflow
import "samplesheet.wdl" as samplesheet
import "tasks/biopet.wdl" as biopet

workflow pipeline {
    input {
        Array[File] sampleConfigFiles
        String outputDir
        File refFasta
        File refDict
        File refFastaIndex
        File refRefflat
        File refGtf
        String strandedness
        File dbsnpVCF
        File dbsnpVCFindex
        String starIndexDir
    }

    # Validation of annotations and dbSNP
    call biopet.ValidateAnnotation as validateAnnotation {
        input:
            refRefflat = refRefflat,
            gtfFile = refGtf,
            refFasta = refFasta,
            refFastaIndex = refFastaIndex,
            refDict = refDict
    }

    call biopet.ValidateVcf as validateVcf {
        input:
            vcfFile = dbsnpVCF,
            vcfIndex = dbsnpVCFindex,
            refFasta = refFasta,
            refFastaIndex = refFastaIndex,
            refDict = refDict
    }

    # Parse sample configs
    scatter (sampleConfigFile in sampleConfigFiles) {
        call samplesheet.SampleConfigFileToStruct as config {
            input:
                sampleConfigFile = sampleConfigFile
        }
    }

    Array[Sample] samples = flatten(config.samples)

    scatter (sample in samples){
        call sampleWorkflow.sample as sample {
            input:
                sampleDir = outputDir + "/samples/" + sample.id + "/",
                sample = sample,
                refFasta = refFasta,
                refDict = refDict,
                refFastaIndex = refFastaIndex,
                refRefflat = refRefflat,
                dbsnpVCF = dbsnpVCF,
                dbsnpVCFindex = dbsnpVCFindex,
                strandedness = strandedness,
                starIndexDir = starIndexDir
        }
    }

    call expressionQuantification.MultiBamExpressionQuantification as expression {
        input:
            bams = zip(sample.sampleName, zip(sample.bam, sample.bai)),
            outputDir = outputDir + "/expression_measures/",
            strandedness = strandedness,
            refGtf = refGtf,
            refRefflat = refRefflat
    }

    call jointgenotyping.JointGenotyping {
        input:
            refFasta = refFasta,
            refDict = refDict,
            refFastaIndex = refFastaIndex,
            outputDir = outputDir,
            gvcfFiles = sample.gvcfFile,
            gvcfIndexes = sample.gvcfFileIndex,
            vcfBasename = "multisample",
            dbsnpVCF = dbsnpVCF,
            dbsnpVCFindex = dbsnpVCFindex
    }

    output {
    }
}
