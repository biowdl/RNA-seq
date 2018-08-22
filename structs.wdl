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
    String strandedness
    Array[Readgroup] readgroups
}

struct Sample {
    String id
    Array[Library] libraries
}

struct Root {
    Array[Sample] samples
}

struct Annotation {
    File refflatFile
    File gtfFile
}

struct VcfFile {
    File file
    File? index
}

struct RnaSeqInput {
    Reference reference
    Annotation annotation
    VcfFile dbsnp
    String starIndexDir
    String strandedness
}
