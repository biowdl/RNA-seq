version 1.0

import "QC/AdapterClipping.wdl" as adapterClippingWorkflow
import "QC/QualityReport.wdl" as qualityReportWorkflow
import "tasks/biopet.wdl" as biopet
import "tasks/common.wdl" as common
import "samplesheet.wdl" as samplesheet
import "tasks/star.wdl" as star


workflow readgroup {
    input {
        Readgroup readgroup
        String libraryId
        String sampleId
        String outputDir
    }

    call common.CheckFileMD5 as md5CheckR1 {
        input:
            file = readgroup.R1,
            MD5sum = readgroup.R1_md5
    }

    if (defined(readgroup.R2)) {
        call common.CheckFileMD5 as md5CheckR2 {
            input:
                file = select_first([readgroup.R2]),
                MD5sum = select_first([readgroup.R2_md5])
        }
    }

    call biopet.ValidateFastq {
        input:
            fastq1 = readgroup.R1,
            fastq2 = readgroup.R2
    }


    #TODO: Change everything below to the QC workflow once imports are fixed.

    # Raw quality report
    call qualityReportWorkflow.QualityReport as rawQualityReportR1 {
        input:
            read = readgroup.R1,
            outputDir = outputDir + "/QC/read1/",
            extractAdapters = true
    }

    if (defined(readgroup.R2)) {
        call qualityReportWorkflow.QualityReport as rawQualityReportR2 {
            input:
                read = select_first([readgroup.R2]),
                outputDir = outputDir + "/QC/read2",
                extractAdapters = true
        }
    }

    # Adapter clipping
    Boolean runAdapterClipping = defined(rawQualityReportR1.adapters) ||
        defined(rawQualityReportR2.adapters)

    if (runAdapterClipping) {
        call adapterClippingWorkflow.AdapterClipping as adapterClipping {
            input:
                read1 = readgroup.R1,
                read2 = readgroup.R2,
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
            else readgroup.R1
        File? cleanR2 = if runAdapterClipping
            then select_first([adapterClipping.read1afterClipping])
            else readgroup.R2
    }
}
