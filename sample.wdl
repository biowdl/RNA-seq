import "tasks/biopet.wdl" as biopet
import "library.wdl" as library
import "tasks/samtools.wdl" as samtools
import "bam-to-gvcf/gvcf.wdl" as gvcf
import "quantification/quantify-from-bam.wdl" as quantification

workflow sample {
    Array[File] sampleConfigs
    String sampleId
    String sampleDir
    String expressionDir
    File ref_fasta
    File ref_dict
    File ref_fasta_index
    File ref_gff
    File ref_refflat
    String strandedness

    call biopet.SampleConfig as config {
        input:
            inputFiles = sampleConfigs,
            sample = sampleId,
            tsvOutputPath = sampleId + ".config.tsv"
    }

    scatter (lib in config.keys) {
        if (lib != "") {
            call library.library as library_call {
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
            bamFiles = library_call.bamFile,
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
            bamFiles = select_all(library_call.bqsrBamFile),
            bamIndexes = select_all(library_call.bqsrBamIndexFile),
            gvcf_basename = sampleDir + "/" + sampleId + ".g"
    }

    # expression quantification, requires different bam file than variant calling
    call quantification.QuantifyFromBam as expression {
        input:
            inputBam = mergeLibraries.outputBam,
            referenceGff = ref_gff,
            referenceRefFlat = ref_refflat,
            sample = sampleId,
            strandedness = strandedness,
            outputDir = expressionDir
    }

    output {
        Array[File?] bams = library_call.bam
        Array[File?] bais = library_call.bai
        File TPMTable = expression.TPMTable
        File FPKMTable = expression.FPKMTable
        File fragmentsPerGeneTable = expression.fragmentsPerGeneTable
        File baseCountsPerGeneTable = expression.baseCountsPerGeneTable
        File gvcfFile = createGvcf.output_gvcf
        File gvcfFileIndex = createGvcf.output_gvcf_index
    }
}
