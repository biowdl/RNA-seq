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
        Map[String, String] dockerImages
    }

    FastqPair reads = readgroup.reads
    #reads.R1 reads.R1_md5 reads.R2 reads.R2_md5

    # QC
    call qcWorkflow.QC as qc {
        input:
            outputDir = outputDir,
            read1 = reads.R1,
            read2 = reads.R2,
            dockerImages = dockerImages
    }

    output {
        File cleanR1 = qc.qcRead1
        File? cleanR2 = qc.qcRead2
    }
}
