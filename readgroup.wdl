import "QC/QC.wdl" as qcWorkflow
import "tasks/biopet.wdl" as biopet


workflow readgroup {
    Array[File] sampleConfigs
    String readgroupId
    String libraryId
    String sampleId
    String? platform
    String outputDir

    call biopet.SampleConfig as config {
        input:
             inputFiles = sampleConfigs,
             sample = sampleId,
             library = libraryId,
             readgroup = readgroupId,
             tsvOutputPath = outputDir + "/" + readgroupId + ".config.tsv"
    }

    # make the readgroup line for STAR
    call makeStarRGline as rgLine {
        input:
            sample = sampleId,
            library = libraryId,
            platform = platform,
            readgroup = readgroupId
    }

    call qcWorkflow.QC as qc {
        input:
            read1 = config.values.R1,
            read2 = config.values.R2,
            outputDir = outputDir + "QC/"
    }

    output {
        File cleanR1 = qc.read1afterQC
        File? cleanR2 = qc.read2afterQC
        String starRGline = rgLine.rgLine
    }
}


task makeStarRGline {
    String sample
    String library
    String? platform
    String readgroup

    command {
        printf '"ID:${readgroup}" "LB:${library}" "PL:${default="ILLUMINA" platform}" "SM:${sample}"'
    }

    output {
        String rgLine = read_string(stdout())
    }
}
