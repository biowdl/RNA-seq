import "QC/QC.wdl" as qcWorkflow
import "tasks/biopet.wdl" as biopet
import "tasks/star.wdl" as star


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
             tsvOutputPath = outputDir + "/" + readgroupId + ".config.tsv",
             keyFilePath = outputDir + "/" + readgroupId + ".config.keys"
    }

    Object configValues = if (defined(config.tsvOutput) && size(config.tsvOutput) > 0)
        then read_map(config.tsvOutput)
        else { "": "" }

    # make the readgroup line for STAR
    call star.makeStarRGline as rgLine {
        input:
            sample = sampleId,
            library = libraryId,
            platform = platform,
            readgroup = readgroupId
    }

    call qcWorkflow.QC as qc {
        input:
            read1 = configValues.R1,
            read2 = configValues.R2,
            outputDir = outputDir + "QC/"
    }

    output {
        File cleanR1 = qc.read1afterQC
        File? cleanR2 = qc.read2afterQC
        String starRGline = rgLine.rgLine
    }
}
