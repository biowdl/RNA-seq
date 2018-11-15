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
        Reference reference
        IndexedVcfFile dbsnp
        String starIndexDir
        String strandedness
        File refflatFile
        Boolean variantCalling = true
    }

    String sampleId = sample.id
    String libraryId = library.id

    scatter (rg in library.readgroups) {
        String readgroupId = rg.id

        call readgroupWorkflow.Readgroup as readgroupWorkflow {
            input:
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
            starIndexDir = starIndexDir
    }

    if (variantCalling) {
    # Preprocess BAM for variant calling
        call picard.MarkDuplicates as markDuplicates {
            input:
                inputBams = [starAlignment.bamFile.file],
                inputBamIndexes = [starAlignment.bamFile.index],
                outputBamPath = outputDir + "/" + sampleId + "-" + libraryId + ".markdup.bam",
                metricsPath = outputDir + "/" + sampleId + "-" + libraryId + ".markdup.metrics"
        }
        call preprocess.GatkPreprocess as preprocessing {
                input:
                    bamFile = markDuplicates.outputBam,
                    basePath = outputDir + "/" + sampleId + "-" + libraryId + ".markdup.bqsr",
                    outputRecalibratedBam = true,
                    splitSplicedReads = true,
                    dbsnpVCF = dbsnp,
                    reference = reference
        }
    }

    # Gather BAM Metrics
    call metrics.BamMetrics as bamMetrics {
        input:
            bam = select_first([markDuplicates.outputBam, starAlignment.bamFile]),
            outputDir = outputDir + "/metrics",
            reference = reference,
            strandedness = strandedness,
            refRefflat = refflatFile
    }




    output {
        IndexedBamFile bamFile = select_first([markDuplicates.outputBam, starAlignment.bamFile]),
        IndexedBamFile? preprocessBamFile = preprocessing.outputBamFile
    }
}
