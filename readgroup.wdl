version 1.0

import "QC/QC.wdl" as qcWorkflow
import "tasks/biopet.wdl" as biopet
import "tasks/common.wdl" as common
import "tasks/star.wdl" as star
import "structs.wdl" as structs

workflow Readgroup {
    input {
        Readgroup readgroup
        Library library
        Sample sample
        String outputDir
        RnaSeqInput rnaSeqInput
    }

    # FIXME: workaround for namepace issue in cromwell
    String sampleId = sample.id
    String libraryId = library.id
    String readgroupId = readgroup.id

    if (defined(readgroup.R1_md5)) {
        call common.CheckFileMD5 as md5CheckR1 {
            input:
                file = readgroup.R1,
                MD5sum = select_first([readgroup.R1_md5])
        }
    }

    if (defined(readgroup.R2)) {
        call common.CheckFileMD5 as md5CheckR2 {
            input:
                file = select_first([readgroup.R2]),
                MD5sum = select_first([readgroup.R2_md5])
        }
    }

    call qcWorkflow.QC as qc {
        input:
            outputDir = outputDir,
            read1 = readgroup.R1,
            read2 = readgroup.R2,
            sample = sampleId,
            library = libraryId,
            readgroup = readgroupId
    }

    output {
        File cleanR1 = qc.read1afterQC
        File? cleanR2 = qc.read2afterQC
    }
}
