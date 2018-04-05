import "tasks/biopet.wdl" as biopet
import "library.wdl" as libraryWorkflow
import "tasks/samtools.wdl" as samtools
import "bam-to-gvcf/gvcf.wdl" as gvcf

workflow sample {
    Array[File] sampleConfigs
    String sampleId
    String sampleDir
    File ref_fasta
    File ref_dict
    File ref_fasta_index

    call biopet.SampleConfig as config {
        input:
            inputFiles = sampleConfigs,
            sample = sampleId,
            tsvOutputPath = sampleId + ".config.tsv"
    }

    scatter (lib in config.keys) {
        if (lib != "") {
            call libraryWorkflow.library as library {
                input:
                    outputDir = sampleDir + "lib_" + lib + "/",
                    sampleConfigs = sampleConfigs,
                    sampleId = sampleId,
                    libraryId = lib,
                    ref_fasta = ref_fasta,
                    ref_dict = ref_dict,
                    ref_fasta_index = ref_fasta_index
            }
        }
    }

    # merge library (mdup) bams into one
    call samtools.Merge as mergeLibraries {
        input:
            bamFiles = library.bamFile,
            outputBamPath = sampleDir + "/" + sampleId + ".bam"
    }

    call samtools.Index as mergedIndex {
        input:
            bamFilePath = mergeLibraries.outputBam
    }

    # variant calling, requires different bam file than counting
    call gvcf.Gvcf as createGvcf {
        input:
            ref_fasta = ref_fasta,
            ref_dict = ref_dict,
            ref_fasta_index = ref_fasta_index,
            bamFiles = select_all(library.preprocessBamFile),
            bamIndexes = select_all(library.preprocessBamIndexFile),
            gvcf_basename = sampleDir + "/" + sampleId + ".g"
    }

    output {
        String sampleName = sampleId
        File bam = mergeLibraries.outputBam
        File bai = mergedIndex.indexFile
        File gvcfFile = createGvcf.output_gvcf
        File gvcfFileIndex = createGvcf.output_gvcf_index
    }
}
