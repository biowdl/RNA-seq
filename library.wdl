import "tasks/biopet.wdl" as biopet
import "readgroup.wdl" as readgroupWorkflow
import "aligning/align-star.wdl" as star
import "tasks/picard.wdl" as picard
import "bqsr/bqsr.wdl" as bqsr

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
            tsvOutputPath = libraryId + ".config.tsv"
    }

    scatter (rg in config.keys) {
        if (rg != "") {
            call readgroupWorkflow.readgroup as readgroup {
                input:
                    outputDir = outputDir + "rg_" + rg + "/",
                    sampleConfigs = sampleConfigs,
                    sampleId = sampleId,
                    libraryId = libraryId,
                    readgroupId = rg
            }
        }
    }

    call star.AlignStar as starAlignment {
        input:
            inputR1 = readgroup.cleanR1,
            inputR2 = readgroup.cleanR2,
            outputDir = outputDir + "star/",
            sample = sampleId,
            library = libraryId,
            rgLine = readgroup.starRGline
    }

    # Preprocess BAM for variant calling
    call picard.MarkDuplicates as markDuplicates {
        input:
            input_bams = starAlignment.bamFile,
            output_bam_path = outputDir + "/" + sampleId + "-" + libraryId + ".markdup.bam",
            metrics_path = outputDir + "/" + sampleId + "-" + libraryId + ".markdup.metrics"
    }

    call bqsr.BaseRecalibration as baseRecalibration {
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
        File bqsrBamFile = baseRecalibration.outputBamFile
        File bqsrBamIndexFile = baseRecalibration.outputBamIndex
    }
}
