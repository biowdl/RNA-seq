version 1.0

# Copyright (c) 2018 Leiden University Medical Center
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

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
        File referenceFasta
        File referenceFastaFai
        File referenceFastaDict
        Array[File]+? starIndex
        Array[File]+? hisat2Index
        String strandedness
        File? refflatFile
        Boolean umiDeduplication = false
        String? adapterForward
        String? adapterReverse
        String platform
        Boolean collectUmiStats = false

        Map[String, String] dockerImages

        String? DONOTDEFINE
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
                adapterForward = adapterForward,
                adapterReverse = adapterReverse,
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
        call umiTools.Dedup as umiDedup {
            input:
                inputBam = markDuplicates.outputBam,
                inputBamIndex = markDuplicates.outputBamIndex,
                outputBamPath = outputDir + "/" + sample.id + ".dedup.bam",
                statsPrefix = if collectUmiStats
                    then outputDir + "/" + sample.id
                    else DONOTDEFINE,
                paired = paired[0], # Assumes that if one readgroup is paired, all are
                dockerImage = dockerImages["umi-tools"]
        }
    }

    # Gather BAM Metrics
    call metrics.BamMetrics as bamMetrics {
        input:
            bam = select_first([umiDedup.deduppedBam, markDuplicates.outputBam]),
            bamIndex = select_first([umiDedup.deduppedBamIndex, markDuplicates.outputBamIndex]),
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
        File outputBam = select_first([umiDedup.deduppedBam, markDuplicates.outputBam])
        File outputBamIndex = select_first([umiDedup.deduppedBamIndex, markDuplicates.outputBamIndex])
        File? umiEditDistance = umiDedup.editDistance
        File? umiStats = umiDedup.umiStats
        File? umiPositionStats = umiDedup.positionStats
    }

    parameter_meta {
        sample: {description: "The sample data.", category: "required"}
        outputDir: {description: "The output directory.", category: "required"}
        referenceFasta: { description: "The reference fasta file", category: "required" }
        referenceFastaFai: { description: "Fasta index (.fai) file of the reference", category: "required" }
        referenceFastaDict: { description: "Sequence dictionary (.dict) file of the reference", category: "required" }
        starIndex: {description: "The star index files. Defining this will cause the star aligner to run and be used for downstream analyses.",
                    category: "common"}
        hisat2Index: {description: "The hisat2 index files. Defining this will cause the hisat2 aligner to run. Note that is starIndex is also defined the star results will be used for downstream analyses.",
                      category: "common"}
        strandedness: {description: "The strandedness of the RNA sequencing library preparation. One of \"None\" (unstranded), \"FR\" (forward-reverse: first read equal transcript) or \"RF\" (reverse-forward: second read equals transcript).",
                       category: "required"}
        refflatFile: {description: "A refflat files describing the genes. If this is defined RNAseq metrics will be collected.",
                      category: "common"}
        umiDeduplication: {description: "Whether or not UMI based deduplication should be performed.", category: "common"}
        adapterForward: {description: "The adapter to be removed from the reads first or single end reads.", category: "common"}
        adapterReverse: {description: "The adapter to be removed from the reads second end reads.", category: "common"}
        collectUmiStats: {description: "Whether or not UMI deduplication stats should be collected. This will potentially cause a massive increase in memory usage of the deduplication step.",
                          category: "advanced"}
        platform: {description: "The platform used for sequencing.", category: "advanced"}
        dockerImages: {description: "The docker images used.", category: "advanced"}
    }

    meta {
        WDL_AID: {
            exclude: ["star.outSAMtype", "star.readFilesCommand", "DONOTDEFINE"]
        }
    }
}
