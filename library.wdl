version 1.0

import "aligning/align-star.wdl" as star
import "BamMetrics/bammetrics.wdl" as metrics
import "gatk-preprocess/gatk-preprocess.wdl" as preprocess
import "readgroup.wdl" as readgroupWorkflow
import "tasks/biopet.wdl" as biopet
import "tasks/picard.wdl" as picard
import "samplesheet.wdl" as samplesheet

workflow library {
    input {
        Library library
        String sampleId
        String libraryDir
        File refFasta
        File refDict
        File refFastaIndex
        File refRefflat
        File dbsnpVCF
        File dbsnpVCFindex
        String strandedness
        String starIndexDir
    }

    String libraryId = library.id

    scatter (rg in library.readgroups) {
        call readgroupWorkflow.readgroup as readgroup {
            input:
                readgroupDir = libraryDir + "/rg_" + rg.id + "/",
                sampleId = sampleId,
                libraryId = library.id,
                readgroup = rg
        }

        String readgroups = rg.id
    }

    call star.AlignStar as starAlignment {
        input:
            inputR1 = readgroup.cleanR1,
            inputR2 = select_all(readgroup.cleanR2),
            outputDir = libraryDir + "/star/",
            sample = sampleId,
            library = library.id,
            readgroups = readgroups,
            starIndexDir = starIndexDir
    }

    # Preprocess BAM for variant calling
    call picard.MarkDuplicates as markDuplicates {
        input:
            input_bams = [starAlignment.bamFile],
            output_bam_path = libraryDir + "/" + sampleId + "-" + libraryId + ".markdup.bam",
            metrics_path = libraryDir + "/" + sampleId + "-" + libraryId + ".markdup.metrics"
    }

    # Gather BAM Metrics
    call metrics.BamMetrics {
        input:
            bamFile = markDuplicates.output_bam,
            bamIndex = markDuplicates.output_bam_index,
            outputDir = libraryDir + "/metrics",
            refFasta = refFasta,
            refDict = refDict,
            refFastaIndex = refFastaIndex,
            strandedness = strandedness,
            refRefflat = refRefflat
    }

    call preprocess.GatkPreprocess as preprocessing {
            input:
                bamFile = markDuplicates.output_bam,
                bamIndex = markDuplicates.output_bam_index,
                outputBamPath = libraryDir + "/" + sampleId + "-" + libraryId + ".markdup.bqsr.bam",
                refFasta = refFasta,
                refDict = refDict,
                refFastaIndex = refFastaIndex,
                splitSplicedReads = true,
                dbsnpVCF = dbsnpVCF,
                dbsnpVCFindex = dbsnpVCFindex
    }

    output {
        File bamFile = markDuplicates.output_bam
        File bamIndexFile = markDuplicates.output_bam_index
        File preprocessBamFile = preprocessing.outputBamFile
        File preprocessBamIndexFile = preprocessing.outputBamIndex
    }
}
