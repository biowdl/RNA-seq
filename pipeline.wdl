import "expression-quantification/multi-bam-quantify.wdl" as expressionQuantification
import "jointgenotyping/jointgenotyping.wdl" as jointgenotyping
import "sample.wdl" as sampleWorkflow
import "tasks/biopet.wdl" as biopet

workflow pipeline {
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

    #parse sample configs
    call biopet.SampleConfig as config {
        input:
            inputFiles = sampleConfigFiles,
            keyFilePath = outputDir + "/config.keys"
    }

    call biopet.ValidateAnnotation as validateAnnotation {
        input:
            refRefflat = refRefflat,
            gtfFile = refGtf,
            refFasta = refFasta
    }

    call biopet.ValidateVcf as validateVcf {
        input:
            vcfFile = dbsnpVCF,
            refFasta = refFasta
    }

    scatter (sm in read_lines(config.keysFile)){
        call sampleWorkflow.sample  as sample {
            input:
                sampleDir = outputDir + "/samples/" + sm + "/",
                sampleConfigs = sampleConfigFiles,
                sampleId = sm,
                refFasta = refFasta,
                refDict = refDict,
                refFastaIndex = refFastaIndex,
                refRefflat = refRefflat,
                dbsnpVCF = dbsnpVCF,
                dbsnpVCFindex = dbsnpVCFindex,
                strandedness = strandedness
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
        Array[String] samples = read_lines(config.keysFile)
    }
}
