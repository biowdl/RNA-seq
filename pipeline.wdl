import "expression-quantification/multi-bam-quantify.wdl" as expressionQuantification
import "jointgenotyping/jointgenotyping.wdl" as jointgenotyping
import "sample.wdl" as sampleWorkflow
import "tasks/biopet.wdl" as biopet

workflow pipeline {
    Array[File] sampleConfigs
    String outputDir
    File refFasta
    File refDict
    File refFastaIndex
    File refRefflat
    File refGtf
    String strandedness

    #parse sample configs
    call biopet.SampleConfig as config {
        input:
            inputFiles = sampleConfigs,
            keyFilePath = outputDir + "/config.keys"
    }

    scatter (sm in read_lines(config.keysFile)){
        call sampleWorkflow.sample  as sample {
            input:
                sampleDir = outputDir + "/samples/" + sm + "/",
                sampleConfigs = sampleConfigs,
                sampleId = sm,
                refFasta = refFasta,
                refDict = refDict,
                refFastaIndex = refFastaIndex
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
            vcfBasename = "multisample"
    }

    output {
        Array[String] samples = read_lines(config.keysFile)
    }
}
