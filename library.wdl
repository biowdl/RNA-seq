version 1.0

import "aligning/align-star.wdl" as star
import "aligning/align-hisat2.wdl" as hisat2
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
        IndexedVcfFile? dbsnp
        File? starIndexDir
        Hisat2Index? hisat2Index
        String strandedness
        File? refflatFile
        Boolean variantCalling = false
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

    if (defined(starIndexDir)) {
        call star.AlignStar as starAlignment {
            input:
                inputR1 = cleanR1,
                inputR2 = select_all(cleanR2),
                outputDir = outputDir + "/star/",
                sample = sample.id,
                library = library.id,
                readgroups = readgroupId,
                starIndexDir = select_first([starIndexDir])
        }
    }

    if (defined(hisat2Index)) {
        Hisat2Index innerHisat2Index = select_first([hisat2Index])
        call hisat2.AlignHisat2 as hisat2Alignment {
            input:
                inputReads = readgroupWorkflow.cleanReads,
                outputDir = outputDir + "/hisat2/",
                sample = sample.id,
                library = library.id,
                readgroups = readgroupId,
                indexDirectory = innerHisat2Index.directory,
                indexBasename = innerHisat2Index.basename
        }
    }

    # Choose whether to use the STAR or HISAT2 bamfile for downstream analyses,
    # star is taken over hisat2.
    IndexedBamFile continuationBamFile = select_first([starAlignment.bamFile,
        hisat2Alignment.bamFile])

    call picard.MarkDuplicates as markDuplicates {
        input:
            inputBams = [continuationBamFile.file],
            inputBamIndexes = [continuationBamFile.index],
            outputBamPath = outputDir + "/" + sampleId + "-" + libraryId + ".markdup.bam",
            metricsPath = outputDir + "/" + sampleId + "-" + libraryId + ".markdup.metrics"
    }

    if (variantCalling) {
        # Preprocess BAM for variant calling
        call preprocess.GatkPreprocess as preprocessing {
            input:
                bamFile = markDuplicates.outputBam,
                basePath = outputDir + "/" + sampleId + "-" + libraryId + ".markdup.bqsr",
                outputRecalibratedBam = true,
                splitSplicedReads = true,
                dbsnpVCF = select_first([dbsnp]),
                reference = reference
        }
    }

    # Gather BAM Metrics
    call metrics.BamMetrics as bamMetrics {
        input:
            bam = markDuplicates.outputBam,
            outputDir = outputDir + "/metrics",
            reference = reference,
            strandedness = strandedness,
            refRefflat = refflatFile
    }

    output {
        IndexedBamFile bamFile = markDuplicates.outputBam
        IndexedBamFile? preprocessBamFile = preprocessing.outputBamFile
    }
}
