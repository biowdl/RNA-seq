version 1.0

import "aligning/align-star.wdl" as star
import "BamMetrics/bammetrics.wdl" as metrics
import "gatk-preprocess/gatk-preprocess.wdl" as preprocess
import "readgroup.wdl" as readgroupWorkflow
import "tasks/biopet/biopet.wdl" as biopet
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

        File cleanR1 = readgroupWorkflow.cleanReads.R1
        File? cleanR2 = readgroupWorkflow.cleanReads.R2
    }

    call star.AlignStar as starAlignment {
        input:
            inputR1 = cleanR1,
            inputR2 = select_all(cleanR2),
            outputDir = outputDir + "/star/",
            sample = sample.id,
            library = library.id,
            readgroups = readgroupId,
            starIndexDir = rnaSeqInput.starIndexDir
    }

    # Preprocess BAM for variant calling
    call picard.MarkDuplicates as markDuplicates {
        input:
            inputBams = [starAlignment.bamFile.file],
            inputBamIndexes = [starAlignment.bamFile.index],
            outputBamPath = outputDir + "/" + sampleId + "-" + sampleId + ".markdup.bam",
            metricsPath = outputDir + "/" + sampleId + "-" + sampleId + ".markdup.metrics"
    }

    # Gather BAM Metrics
    call metrics.BamMetrics as bamMetrics {
        input:
            bam = markDuplicates.outputBam,
            outputDir = outputDir + "/metrics",
            reference = rnaSeqInput.reference,
            strandedness = rnaSeqInput.strandedness,
            refRefflat = rnaSeqInput.refflatFile
    }

    call preprocess.GatkPreprocess as preprocessing {
            input:
                bamFile = markDuplicates.outputBam,
                basePath = outputDir + "/" + sampleId + "-" + sampleId + ".markdup.bqsr",
                outputRecalibratedBam = true,
                splitSplicedReads = true,
                dbsnpVCF = rnaSeqInput.dbsnp,
                reference = rnaSeqInput.reference
    }

    output {
        IndexedBamFile bamFile = markDuplicates.outputBam
        IndexedBamFile preprocessBamFile = select_first([preprocessing.outputBamFile])
    }
}
