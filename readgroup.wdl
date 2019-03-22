version 1.0

import "QC/QC.wdl" as qcWorkflow
import "tasks/biopet/biopet.wdl" as biopet
import "tasks/common.wdl" as common
import "tasks/star.wdl" as star
import "structs.wdl" as structs

workflow Readgroup {
    input {
        Readgroup readgroup
        Library library
        Sample sample
        String outputDir
        Map[String, String] dockerTags
    }

    FastqPair reads = readgroup.reads

    # Copy raw data to output direcotry
    #FIXME See comment on Copy calls in pipeline.wdl
    call common.Copy as copyR1 {
        input:
            inputFile = reads.R1,
            outputPath = outputDir + "/" + basename(reads.R1)
    }

    if (defined(reads.R2)) {
         call common.Copy as copyR2 {
             input:
                 inputFile = select_first([reads.R2]),
                 outputPath = outputDir + "/" + basename(select_first([reads.R2]))
         }
    }

    # Check md5sums
    if (defined(reads.R1_md5)) {
        call common.CheckFileMD5 as md5CheckR1 {
            input:
                file = copyR1.outputFile,
                md5 = select_first([reads.R1_md5])
        }
    }
    
    if (defined(reads.R2_md5) && defined(reads.R2)) {
        call common.CheckFileMD5 as md5CheckR2 {
            input:
                file = select_first([copyR2.outputFile]),
                md5 = select_first([reads.R2_md5])
        }
    }

    # QC
    call qcWorkflow.QC as qc {
        input:
            outputDir = outputDir,
            read1 = copyR1.outputFile,
            read2 = copyR2.outputFile,
            dockerTags = dockerTags
    }

    output {
        FastqPair cleanReads = object { R1: qc.qcRead1, R2: qc.qcRead2 }
    }
}
