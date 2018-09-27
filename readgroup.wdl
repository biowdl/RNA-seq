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
        RnaSeqInput rnaSeqInput
    }

    # FIXME: workaround for namepace issue in cromwell
    String sampleId = sample.id
    String libraryId = library.id
    String readgroupId = readgroup.id

    call qcWorkflow.QC as qc {
        input:
            outputDir = outputDir,
            reads = readgroup.reads,
            sample = sampleId,
            library = libraryId,
            readgroup = readgroupId
    }

    output {
        FastqPair cleanReads = qc.readsAfterQC
    }
}
