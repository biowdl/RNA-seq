version 1.0

import "BamMetrics/bammetrics.wdl" as metrics
import "QC/QC.wdl" as qcWorkflow
import "tasks/biopet/biopet.wdl" as biopet
import "tasks/samtools.wdl" as samtools
import "structs.wdl" as structs
import "tasks/star.wdl" as star_task
import "tasks/hisat2.wdl" as hisat2Task
import "tasks/picard.wdl" as picard

workflow Sample {
    input {
        Sample sample
        String outputDir
        File referenceFasta
        File referenceFastaFai
        File referenceFastaDict
        Array[File]+? starIndex
        Array[File]+? hisat2Index
        String strandedness
        File? refflatFile
        Map[String, String] dockerImages
        String platform = "illumina"
    }

    scatter (readgroup in sample.readgroups) {
        String libDir = outputDir + "/lib_" + readgroup.lib_id
        String readgroupDir = libDir + "/rg_" + readgroup.id
        String rgLine ='"ID:${readgroup.id}" "LB:${readgroup.lib_id}" "PL:${platform}" "SM:${sample.id}"'
        call qcWorkflow.QC as qc {
            input:
                outputDir = readgroupDir,
                read1 = readgroup.R1,
                read2 = readgroup.R2,
                dockerImages = dockerImages
        }

        if (defined(starIndex)) {
            call star_task.Star as star {
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
    }

    call picard.MarkDuplicates as markDuplicates {
        input:
            inputBams = continuationBam,
            inputBamIndexes = continuationBamIndex,
            outputBamPath = outputDir + "/" + sample.id + ".markdup.bam",
            metricsPath = outputDir + "/" + sample.id + ".markdup.metrics",
            dockerImage = dockerImages["picard"]
    }

    # Gather BAM Metrics
    call metrics.BamMetrics as bamMetrics {
        input:
            bam = markDuplicates.outputBam,
            bamIndex = markDuplicates.outputBamIndex,
            outputDir = outputDir + "/metrics",
            referenceFasta = referenceFasta,
            referenceFastaFai = referenceFastaFai,
            referenceFastaDict = referenceFastaDict,
            strandedness = strandedness,
            refRefflat = refflatFile,
            dockerImages = dockerImages
    }

    output {
        String sampleName = sample.id
        File outputBam = markDuplicates.outputBam
        File outputBamIndex = markDuplicates.outputBamIndex
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
        dockerImages: {description: "The docker images used.", category: "advanced"}
        platform: {description: "The platform used for sequencing.", category: "advanced"}
    }

    meta {
        WDL_AID: {
            exclude: ["star.outSAMtype", "star.readFilesCommand"]
        }
    }
}
