import "QC/AdapterClipping.wdl" as adapterClippingWorkflow
import "QC/QualityReport.wdl" as qualityReportWorkflow
import "tasks/biopet.wdl" as biopet
import "tasks/common.wdl" as common
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

    Map[String,String] configValues = if (defined(config.tsvOutput) && size(config.tsvOutput) > 0)
        then read_map(config.tsvOutput)
        else { "": "" }

    if (configValues["R1_md5"]) {
        call common.CheckFileMD5 as md5CheckR1 {
            input:
                file=configValues["R1"],
                MD5sum=configValues["R1_md5"]
        }
    }

    if (configValues["R2_md5"]) {
        call common.CheckFileMD5 as md5CheckR2 {
            input:
                file=configValues["R2"],
                MD5sum=configValues["R2_md5"]
        }
    }

    #TODO: Change everything below to the QC workflow once imports are fixed.

    # Raw quality report
    call qualityReportWorkflow.QualityReport as rawQualityReportR1 {
        input:
            read = configValues["R1"],
            outputDir = outputDir + "/QC/read1/",
            extractAdapters = true
    }

    if (defined(configValues["R2"])) {
        call qualityReportWorkflow.QualityReport as rawQualityReportR2 {
            input:
                read = configValues["R2"],
                outputDir = outputDir + "/QC/read2",
                extractAdapters = true
        }
    }

    # Adapter clipping
    Boolean runAdapterClipping = defined(rawQualityReportR1.adapters) || defined(rawQualityReportR2.adapters)
    if (runAdapterClipping) {
        call adapterClippingWorkflow.AdapterClipping as adapterClipping {
            input:
                read1 = configValues["R1"],
                read2 = configValues["R2"],
                outputDir = outputDir + "AdapterClipping/",
                adapterListRead1 = rawQualityReportR1.adapters,
                adapterListRead2 = rawQualityReportR2.adapters
        }

        # Post adapter clipping quality report
        call qualityReportWorkflow.QualityReport as cleanQualityReportR1 {
            input:
                read = adapterClipping.read1afterClipping,
                outputDir = outputDir + "/QCafter/read1",
                extractAdapters = false
        }

        if (defined(adapterClipping.read2afterClipping)) {
            call qualityReportWorkflow.QualityReport as cleanQualityReportR2 {
                input:
                    read = select_first([adapterClipping.read2afterClipping]),
                    outputDir = outputDir + "/QCafter/read2",
                    extractAdapters = false
            }
        }
    }

    output {
        File cleanR1 = if runAdapterClipping
            then select_first([adapterClipping.read1afterClipping])
            else configValues["R1"]
        File? cleanR2 = if runAdapterClipping
            then select_first([adapterClipping.read1afterClipping])
            else configValues["R2"]
    }
}
