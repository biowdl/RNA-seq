import "tasks/biopet.wdl" as biopet
import "tasks/common.wdl" as common
import "library.wdl" as libraryWorkflow
import "tasks/samtools.wdl" as samtools
import "bam-to-gvcf/gvcf.wdl" as gvcf

workflow sample {
    Array[File] sampleConfigs
    String sampleId
    String sampleDir
    File refFasta
    File refDict
    File refFastaIndex

    call biopet.SampleConfig as config {
        input:
            inputFiles = sampleConfigs,
            sample = sampleId,
            tsvOutputPath = sampleDir + "/" + sampleId + ".config.tsv",
            keyFilePath = sampleDir + "/" + sampleId + ".config.keys"
    }

    scatter (lib in read_lines(config.keysFile)) {
        if (lib != "") {
            call libraryWorkflow.library as library {
                input:
                    outputDir = sampleDir + "/lib_" + lib + "/",
                    sampleConfigs = sampleConfigs,
                    sampleId = sampleId,
                    libraryId = lib,
                    ref_fasta = refFasta,
                    ref_dict = refDict,
                    ref_fasta_index = refFastaIndex
            }
        }
    }

    Boolean multipleBams = length(library.bamFile) > 1

    # Merge library (mdup) bams into one (for counting).
    if (multipleBams) {
        call samtools.Merge as mergeLibraries {
            input:
                bamFiles = select_all(library.bamFile),
                outputBamPath = sampleDir + "/" + sampleId + ".bam"
        }

        call samtools.Index as mergedIndex {
            input:
                bamFilePath = mergeLibraries.outputBam,
                bamIndexPath = sampleDir + "/" + sampleId + ".bai"
        }
    }

    # Create links instead if only one bam, to retain output structure.
    if (! multipleBams) {
        call common.createLink as linkBam {
            input:
                inputFile = select_first(library.bamFile),
                outputPath = sampleDir + "/" + sampleId + ".bam"
        }

        call common.createLink as linkIndex {
            input:
                inputFile = select_first(library.bamIndexFile),
                outputPath = sampleDir + "/" + sampleId + ".bai"
        }
    }

    # variant calling, requires different bam file than counting
    call gvcf.Gvcf as createGvcf {
        input:
            ref_fasta = refFasta,
            ref_dict = refDict,
            ref_fasta_index = refFastaIndex,
            bamFiles = select_all(library.preprocessBamFile),
            bamIndexes = select_all(library.preprocessBamIndexFile),
            gvcf_basename = sampleDir + "/" + sampleId + ".g"
    }

    output {
        String sampleName = sampleId
        File bam = if multipleBams then select_first([mergeLibraries.outputBam]) else select_first(library.bamFile)
        File bai = if multipleBams then select_first([mergedIndex.indexFile]) else select_first(library.bamIndexFile)
        File gvcfFile = createGvcf.output_gvcf
        File gvcfFileIndex = createGvcf.output_gvcf_index
    }
}
