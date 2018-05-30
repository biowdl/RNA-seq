import "tasks/biopet.wdl" as biopet
import "readgroup.wdl" as readgroupWorkflow
import "aligning/align-star.wdl" as star
import "tasks/picard.wdl" as picard
import "gatk-preprocess/gatk-preprocess.wdl" as preprocess

workflow library {
    Array[File] sampleConfigs
    String sampleId
    String libraryId
    String outputDir
    File ref_fasta
    File ref_dict
    File ref_fasta_index

    call biopet.SampleConfig as config {
        input:
            inputFiles = sampleConfigs,
            sample = sampleId,
            library = libraryId,
            tsvOutputPath = outputDir + "/" + libraryId + ".config.tsv",
            keyFilePath = outputDir + "/" + libraryId + ".config.keys"
    }

    scatter (rg in read_lines(config.keysFile)) {
        if (rg != "") {
            call readgroupWorkflow.readgroup as readgroup {
                input:
                    outputDir = outputDir + "/rg_" + rg + "/",
                    sampleConfigs = sampleConfigs,
                    sampleId = sampleId,
                    libraryId = libraryId,
                    readgroupId = rg
            }
        }
    }

    call star.AlignStar as starAlignment {
        input:
            inputR1 = select_all(readgroup.cleanR1),
            inputR2 = select_all(readgroup.cleanR2),
            outputDir = outputDir + "/star/",
            sample = sampleId,
            library = libraryId,
            rgLine = select_all(readgroup.starRGline)
    }

    # Preprocess BAM for variant calling
    call picard.MarkDuplicates as markDuplicates {
        input:
            input_bams = starAlignment.bamFile,
            output_bam_path = outputDir + "/" + sampleId + "-" + libraryId + ".markdup.bam",
            metrics_path = outputDir + "/" + sampleId + "-" + libraryId + ".markdup.metrics"
    }

    call preprocess.GatkPreprocess as preprocessing {
            input:
                bamFile = markDuplicates.output_bam,
                bamIndex = markDuplicates.output_bam_index,
                outputBamPath = sub(markDuplicates.output_bam, ".bam$", ".bqsr.bam"),
                ref_fasta = ref_fasta,
                ref_dict = ref_dict,
                ref_fasta_index = ref_fasta_index,
                splitSplicedReads = true
    }

    output {
        File bamFile = markDuplicates.output_bam
        File bamIndexFile = markDuplicates.output_bam_index
        File preprocessBamFile = preprocessing.outputBamFile
        File preprocessBamIndexFile = preprocessing.outputBamIndex
    }
}
