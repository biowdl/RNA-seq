version 1.0

import "bam-to-gvcf/gvcf.wdl" as gvcf
import "library.wdl" as libraryWorkflow
import "tasks/biopet.wdl" as biopet
import "tasks/common.wdl" as common
import "tasks/samtools.wdl" as samtools
import "structs.wdl" as structs

workflow Sample {
    input {
        Sample sample
        String outputDir
        RnaSeqInput rnaSeqInput
    }

    scatter (lib in sample.libraries) {
        call libraryWorkflow.Library as library {
            input:
                rnaSeqInput = rnaSeqInput,
                outputDir = outputDir + "/lib_" + lib.id,
                sample = sample,
                library = lib
            }
        }

    Boolean multipleBams = length(library.bamFile) > 1

    # Merge library (mdup) bams into one (for counting).
    if (multipleBams) {
        call samtools.Merge as mergeLibraries {
            input:
                bamFiles = library.bamFile,
                outputBamPath = outputDir + "/" + sample.id + ".bam"
        }

        call samtools.Index as mergedIndex {
            input:
                bamFilePath = mergeLibraries.outputBam,
                bamIndexPath = outputDir + "/" + sample.id + ".bai"
        }
    }

    # Create links instead, if there is only one bam, to retain output structure.
    if (! multipleBams) {
        call common.CreateLink as linkBam {
            input:
                inputFile = library.bamFile[0],
                outputPath = outputDir + "/" + sample.id + ".bam"
        }

        call common.CreateLink as linkIndex {
            input:
                inputFile = library.bamIndexFile[0],
                outputPath = outputDir + "/" + sample.id + ".bai"
        }
    }

    # variant calling, requires different bam file than counting
    call gvcf.Gvcf as createGvcf {
        input:
            bamFiles = library.preprocessBamFile,
            bamIndexes = library.preprocessBamIndexFile,
            gvcfPath = outputDir + "/" + sample.id + ".g.vcf.gz",
            dbsnpVCF = rnaSeqInput.dbsnp.file,
            dbsnpVCFindex = rnaSeqInput.dbsnp.index,
            refFasta = rnaSeqInput.reference.fasta,
            refFastaIndex = rnaSeqInput.reference.fai,
            refDict = rnaSeqInput.reference.dict
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
