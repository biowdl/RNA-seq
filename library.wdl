version 1.0

import "aligning/align-star.wdl" as star
import "BamMetrics/bammetrics.wdl" as metrics
import "gatk-preprocess/gatk-preprocess.wdl" as preprocess
import "readgroup.wdl" as readgroupWorkflow
import "tasks/biopet.wdl" as biopet
import "tasks/picard.wdl" as picard
import "structs.wdl" as structs

workflow Library {
    input {
        Library library
        Sample sample
        String outputDir
        RnaSeqInput rnaSeqInput
    }

    String sampleId = sample.id
    String libraryId = library.id

    scatter (rg in library.readgroups) {
        String readgroupId = rg.id

        call readgroupWorkflow.Readgroup as readgroupWorkflow {
            input:
                rnaSeqInput = rnaSeqInput,
                outputDir = outputDir + "/rg_" + readgroupId,
                sample = sample,
                library = library,
                readgroup = rg
        }
    }

    call star.AlignStar as starAlignment {
        input:
            inputR1 = readgroupWorkflow.cleanR1,
            inputR2 = select_all(readgroupWorkflow.cleanR2),
            outputDir = outputDir + "/star/",
            sample = sample.id,
            library = library.id,
            readgroups = readgroupId,
            starIndexDir = rnaSeqInput.starIndexDir
    }

    # Preprocess BAM for variant calling
    call picard.MarkDuplicates as markDuplicates {
        input:
            input_bams = [starAlignment.bamFile],
            output_bam_path = outputDir + "/" + sampleId + "-" + sampleId + ".markdup.bam",
            metrics_path = outputDir + "/" + sampleId + "-" + sampleId + ".markdup.metrics"
    }

    # Gather BAM Metrics
    call metrics.BamMetrics as bamMetrics {
        input:
            bamFile = markDuplicates.output_bam,
            bamIndex = markDuplicates.output_bam_index,
            outputDir = outputDir + "/metrics",
            refFasta = rnaSeqInput.reference.fasta,
            refFastaIndex = rnaSeqInput.reference.fai,
            refDict = rnaSeqInput.reference.dict,
            strandedness = rnaSeqInput.strandedness,
            refRefflat = rnaSeqInput.refflatFile
    }

    call preprocess.GatkPreprocess as preprocessing {
            input:
                bamFile = markDuplicates.output_bam,
                bamIndex = markDuplicates.output_bam_index,
                outputBamPath = outputDir + "/" + sampleId + "-" + sampleId + ".markdup.bqsr.bam",
                splitSplicedReads = true,
                dbsnpVCF = rnaSeqInput.dbsnp.file,
                dbsnpVCFindex = rnaSeqInput.dbsnp.index,
                refFasta = rnaSeqInput.reference.fasta,
                refFastaIndex = rnaSeqInput.reference.fai,
                refDict = rnaSeqInput.reference.dict
    }

    output {
        File bamFile = markDuplicates.output_bam
        File bamIndexFile = markDuplicates.output_bam_index
        File preprocessBamFile = preprocessing.outputBamFile
        File preprocessBamIndexFile = preprocessing.outputBamIndex
    }
}
