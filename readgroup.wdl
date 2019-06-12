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
    #reads.R1 reads.R1_md5 reads.R2 reads.R2_md5

    # Check md5sums
    if (defined(reads.R1_md5)) {
        call common.CheckFileMD5 as md5CheckR1 {
            input:
                file = reads.R1,
                md5 = select_first([reads.R1_md5])
        }
    }
    
    if (defined(reads.R2_md5) && defined(reads.R2)) {
        call common.CheckFileMD5 as md5CheckR2 {
            input:
                file = select_first([reads.R2]),
                md5 = select_first([reads.R2_md5])
        }
    }

    # QC
    call qcWorkflow.QC as qc {
        input:
            outputDir = outputDir,
            read1 = reads.R1,
            read2 = reads.R2,
            dockerTags = dockerTags
    }

    output {
        FastqPair cleanReads = object { R1: qc.qcRead1, R2: qc.qcRead2 }
    }
}
