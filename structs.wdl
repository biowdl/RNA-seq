version 1.0

struct Readgroup {
    String id
    String lib_id
    File R1
    File? R2
}

struct Sample {
    String id
    Array[Readgroup] readgroups
    String? gender
}

struct SampleConfig {
    Array[Sample] samples
}
