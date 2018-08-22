version 1.0

import "tasks/bwa.wdl" as bwa
import "tasks/common.wdl" as common

struct Readgroup {
    String id
    File R1
    String? R1_md5
    File? R2
    String? R2_md5
}

struct Library {
    String id
    Array[Readgroup] readgroups
}

struct Sample {
    String id
    Array[Library] libraries
}

struct Root {
    Array[Sample] samples
}

struct RnaSeqInput {
    Reference reference
    IndexedVcfFile dbsnp
    String starIndexDir
    String strandedness
    File refflatFile
    File gtfFile
}
