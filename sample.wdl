version 1.0

import "BamMetrics/bammetrics.wdl" as metrics
import "QC/QC.wdl" as qcWorkflow
import "structs.wdl" as structs
import "tasks/biopet/biopet.wdl" as biopet
import "tasks/common.wdl" as common
import "tasks/samtools.wdl" as samtools
import "tasks/star.wdl" as starTask
import "tasks/hisat2.wdl" as hisat2Task
import "tasks/picard.wdl" as picard
import "tasks/umi-tools.wdl" as umiTools

workflow Sample {
    input {
        Sample sample
        String outputDir
        Reference reference
        Array[File]+? starIndex
        Array[File]+? hisat2Index
        String strandedness
        File? refflatFile
        String? bcPattern
        Boolean umiDeduplication = false
        String platform = "illumina"

        Map[String, String] dockerImages
    }

    scatter (readgroup in sample.readgroups) {
        String libDir = outputDir + "/lib_" + readgroup.lib_id
        String readgroupDir = libDir + "/rg_" + readgroup.id
        String rgLine ='"ID:${readgroup.id}" "LB:${readgroup.lib_id}" "PL:${platform}" "SM:${sample.id}"'

        if (defined(bcPattern)) {
            call umiTools.Extract as umiExtraction {
                input:
                    read1 = readgroup.R1,
                    read2 = readgroup.R2,
                    bcPattern = select_first([bcPattern]),
                    dockerImage = dockerImages["umi-tools"]
            }
        }

        call qcWorkflow.QC as qc {
            input:
                outputDir = readgroupDir,
                read1 = select_first([umiExtraction.extractedRead1, readgroup.R1]),
                read2 = if defined(umiExtraction.extractedRead2)
                    then umiExtraction.extractedRead2
                    else readgroup.R2,
                dockerImages = dockerImages
        }

        if (defined(starIndex)) {
            call starTask.Star as star {
                input:
                    inputR1 = [qc.qcRead1],
                    inputR2 = select_all([qc.qcRead2]),
                    outFileNamePrefix = outputDir + "/star/" + sample.id + "-" + readgroup.lib_id + "-" + readgroup.id + ".",
                    outSAMattrRGline = [rgLine],
                    indexFiles = select_first([starIndex]),
                    dockerImage = dockerImages["star"]
            }

            # This creates the index only in the cromwell-executions directory
            # this is the least headache-inducing way of doing this.
            call samtools.Index as indexStarBam {
                input:
                    bamFile = star.bamFile
            }
        }

        if (defined(hisat2Index)) {
            call hisat2Task.Hisat2 as hisat2 {
                 input:
                    indexFiles = select_first([hisat2Index]),
                    inputR1 = qc.qcRead1,
                    inputR2 = qc.qcRead2,
                    outputBam = outputDir + "/hisat2/" + sample.id + "-" + readgroup.lib_id + "-" + readgroup.id + ".bam",
                    sample = sample.id,
                    library = readgroup.lib_id,
                    readgroup = readgroup.id,
                    platform = platform,
                    dockerImage = dockerImages["hisat2"]
            }
        }
        # Choose whether to use the STAR or HISAT2 bamfiles for downstream analyses,
        # star is taken over hisat2.
        File continuationBam = select_first([indexStarBam.indexedBam, hisat2.bamFile])
        File continuationBamIndex = select_first([indexStarBam.index, hisat2.bamIndex])

        # Determine if the sample is paired-end
        Boolean paired = defined(readgroup.R2)
    }

    call picard.MarkDuplicates as markDuplicates {
        input:
            inputBams = continuationBam,
            inputBamIndexes = continuationBamIndex,
            outputBamPath = outputDir + "/" + sample.id + ".markdup.bam",
            metricsPath = outputDir + "/" + sample.id + ".markdup.metrics",
            dockerImage = dockerImages["picard"]
    }

    if (umiDeduplication) {
        call umiTools.Dedup as umiDeduplication {
            input:
                inputBam = markDuplicates.outputBam,
                inputBamIndex = markDuplicates.outputBamIndex,
                outputBamPath = outputDir + "/" + sample.id + ".dedup.bam",
                paired = paired[0], # Assumes that if one readgroup is paired, all are
                dockerImage = dockerImages["umi-tools"]
        }
    }

    IndexedBamFile outputBam = {
                "file": select_first([umiDeduplication.deduppedBam, markDuplicates.outputBam]),
                "index": select_first([umiDeduplication.deduppedBamIndex, markDuplicates.outputBamIndex])
            }

    # Gather BAM Metrics
    call metrics.BamMetrics as bamMetrics {
        input:
            bam = outputBam,
            outputDir = outputDir + "/metrics",
            reference = reference,
            strandedness = strandedness,
            refRefflat = refflatFile,
            dockerImages = dockerImages
    }

    output {
        String sampleName = sample.id
        IndexedBamFile bam = outputBam
    }

    parameter_meta {
        sample: {description: "The sample data.", category: "required"}
        outputDir: {description: "The output directory.", category: "required"}
        reference: {description: "The reference files: a fasta, its index and the associated sequence dictionary.", category: "required"}
        starIndex: {description: "The star index files. Defining this will cause the star aligner to run and be used for downstream analyses.",
                    category: "common"}
        hisat2Index: {description: "The hisat2 index files. Defining this will cause the hisat2 aligner to run. Note that is starIndex is also defined the star results will be used for downstream analyses.",
                      category: "common"}
        strandedness: {description: "The strandedness of the RNA sequencing library preparation. One of \"None\" (unstranded), \"FR\" (forward-reverse: first read equal transcript) or \"RF\" (reverse-forward: second read equals transcript).",
                       category: "required"}
        refflatFile: {description: "A refflat files describing the genes. If this is defined RNAseq metrics will be collected.",
                      category: "common"}
        bcPattern: {description: "The pattern to be used for UMI extraction. See the umi_tools docs for more information.", category: "common"}
        umiDeduplication: {description: "Whether or not UMI based deduplication should be performed.", category: "common"}
        platform: {description: "The platform used for sequencing.", category: "advanced"}
        dockerImages: {description: "The docker images used.", category: "advanced"}

    }

    meta {
        WDL_AID: {
            exclude: ["star.outSAMtype", "star.readFilesCommand"]
        }
    }
}
