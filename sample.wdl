version 1.0

import "bam-to-gvcf/gvcf.wdl" as gvcf
import "library.wdl" as libraryWorkflow
import "tasks/biopet.wdl" as biopet
import "tasks/common.wdl" as common
import "samplesheet.wdl" as samplesheet
import "tasks/samtools.wdl" as samtools

workflow sample {
    input {
        Sample sample
        String sampleDir
        File refFasta
        File refDict
        File refFastaIndex
        File refRefflat
        File dbsnpVCF
        File dbsnpVCFindex
        String strandedness
        String starIndexDir
    }

    scatter (library in sample.libraries) {
        call libraryWorkflow.library as library {
            input:
                outputDir = sampleDir + "/lib_" + library.id + "/",
                sampleId = sample.id,
                library = library,
                refFasta = refFasta,
                refDict = refDict,
                refFastaIndex = refFastaIndex,
                refRefflat = refRefflat,
                dbsnpVCF = dbsnpVCF,
                dbsnpVCFindex = dbsnpVCFindex,
                strandedness = strandedness,
                starIndexDir = starIndexDir
        }

        # Necessary for predicting the path to the BAM/BAI in linkBam and linkIndex
        String libraryId = library.id
    }

    Boolean multipleBams = length(library.bamFile) > 1

    # Merge library (mdup) bams into one (for counting).
    if (multipleBams) {
        call samtools.Merge as mergeLibraries {
            input:
                bamFiles = library.bamFile,
                outputBamPath = sampleDir + "/" + sample.id + ".bam"
        }

        call samtools.Index as mergedIndex {
            input:
                bamFilePath = mergeLibraries.outputBam,
                bamIndexPath = sampleDir + "/" + sample.id + ".bai"
        }
    }

    # Create links instead, if there is only one bam, to retain output structure.
    if (! multipleBams) {
        String lib = libraryId[0]
        call common.CreateLink as linkBam {
            input:
                inputFile = sampleDir + "/lib_" + lib + "/" + sample.id + "-" + lib + ".markdup.bam",
                outputPath = sampleDir + "/" + sample.id + ".bam"
        }

        call common.CreateLink as linkIndex {
            input:
                inputFile = sampleDir + "/lib_" + lib + "/" + sample.id + "-" + lib + ".markdup.bai",
                outputPath = sampleDir + "/" + sample.id + ".bai"
        }
    }

    # variant calling, requires different bam file than counting
    call gvcf.Gvcf as createGvcf {
        input:
            refFasta = refFasta,
            refDict = refDict,
            refFastaIndex = refFastaIndex,
            bamFiles = library.preprocessBamFile,
            bamIndexes = library.preprocessBamIndexFile,
            gvcfPath = sampleDir + "/" + sample.id + ".g.vcf.gz",
            dbsnpVCF = dbsnpVCF,
            dbsnpVCFindex = dbsnpVCFindex
    }

    output {
        String sampleName = sample.id
        File bam = if multipleBams
            then select_first([mergeLibraries.outputBam])
            else library.bamFile[0]
        File bai = if multipleBams
            then select_first([mergedIndex.indexFile])
            else library.bamIndexFile[0]
        File gvcfFile = createGvcf.outputGVCF
        File gvcfFileIndex = createGvcf.outputGVCFindex
    }
}
