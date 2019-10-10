version 1.0

import "bam-to-gvcf/gvcf.wdl" as gvcf
import "BamMetrics/bammetrics.wdl" as metrics
import "QC/QC.wdl" as qcWorkflow
import "gatk-preprocess/gatk-preprocess.wdl" as preprocess
import "tasks/biopet/biopet.wdl" as biopet
import "tasks/common.wdl" as common
import "tasks/samtools.wdl" as samtools
import "structs.wdl" as structs
import "tasks/star.wdl" as star_task
import "tasks/hisat2.wdl" as hisat2Task
import "tasks/picard.wdl" as picard

workflow Sample {
    input {
        Sample sample
        String outputDir
        Reference reference
        IndexedVcfFile? dbsnp
        Array[File]+? starIndex
        Array[File]+? hisat2Index
        String strandedness
        File? refflatFile
        Boolean variantCalling = false
        Map[String, String] dockerImages
        String platform = "illumina"
        Array[File]+? targetIntervals
        File? ampliconIntervals
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
        }

        if (defined(hisat2Index)) {
            call hisat2Task.Hisat2 as hisat2 {
                 input:
                indexFiles = select_first([hisat2Index]),
                inputR1 = readgroup.R1,
                inputR2 = readgroup.R2,
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
        File continuationBam = select_first([star.bamFile, hisat2.bamFile])
    }

    call samtools.Merge as samtoolsMerge {
            input:
                bamFiles = continuationBam,
                outputBamPath = outputDir + "/" + sample.id + ".bam",
                dockerImage = dockerImages["samtools"]
    }

     call picard.MarkDuplicates as markDuplicates {
        input:
            inputBams = [samtoolsMerge.outputBam],
            inputBamIndexes = [samtoolsMerge.outputBamIndex],
            outputBamPath = outputDir + "/" + sample.id + ".markdup.bam",
            metricsPath = outputDir + "/" + sample.id + ".markdup.metrics",
            dockerImage = dockerImages["picard"]
    }

    # Gather BAM Metrics
    call metrics.BamMetrics as bamMetrics {
        input:
            bam = {
                "file": markDuplicates.outputBam,
                "index": markDuplicates.outputBamIndex
            },
            outputDir = outputDir + "/metrics",
            reference = reference,
            strandedness = strandedness,
            refRefflat = refflatFile,
            dockerImages = dockerImages
    }

    if (variantCalling) {
        # Preprocess BAM for variant calling
        call preprocess.GatkPreprocess as preprocessing {
            input:
                bamFile = {
                    "file": markDuplicates.outputBam,
                    "index": markDuplicates.outputBamIndex
                },
                outputDir = outputDir + "/",
                bamName = sample.id + ".markdup.bqsr",
                outputRecalibratedBam = true,
                splitSplicedReads = true,
                dbsnpVCF = select_first([dbsnp]),
                reference = reference,
                dockerImages = dockerImages
        }
        call gvcf.Gvcf as createGvcf {
            input:

                bamFiles = select_all([preprocessing.outputBamFile]),
                outputDir = outputDir,
                gvcfName = sample.id + ".g.vcf.gz",
                dbsnpVCF = select_first([dbsnp]).file,
                dbsnpVCFIndex = select_first([dbsnp]).index,
                referenceFasta = reference.fasta,
                referenceFastaFai = reference.fai,
                referenceFastaDict = reference.dict,
                dockerImages = dockerImages
        }
        IndexedVcfFile gvcf = object {file:  createGvcf.outputGVcf, index: createGvcf.outputGVcfIndex}
    }

    output {
        String sampleName = sample.id
        IndexedBamFile bam = {
            "file": markDuplicates.outputBam,
            "index": markDuplicates.outputBamIndex
        }
        IndexedVcfFile? gvcfFile = gvcf
    }
}
