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
    }
    
    if (defined(readgroup.R1_md5)) {
        call common.CheckFileMD5 as md5CheckR1 {
            input:
                file = readgroup.R1,
                md5 = select_first([readgroup.R1_md5])
        }
    }
    
    if (defined(readgroup.R2_md5) && defined(readgroup.R2)) {
        call common.CheckFileMD5 as md5CheckR2 {
            input:
                file = select_first([readgroup.R2]),
                md5 = select_first([readgroup.R2_md5])
        }
    }

    call qcWorkflow.QC as qc {
        input:
            outputDir = outputDir,
            read1 = readgroup.readgroup.R1,
            read2 = readgroup.readgroup.R2
    }

    output {
        FastqPair cleanReads = object { R1: qc.qcRead1, R2: qc.qcRead2 }
    }
}
