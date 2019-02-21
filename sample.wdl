version 1.0

import "bam-to-gvcf/gvcf.wdl" as gvcf
import "library.wdl" as libraryWorkflow
import "tasks/biopet/biopet.wdl" as biopet
import "tasks/common.wdl" as common
import "tasks/samtools.wdl" as samtools
import "structs.wdl" as structs

workflow Sample {
    input {
        Sample sample
        String outputDir
        Reference reference
        IndexedVcfFile? dbsnp
        String? starIndexDir
        Hisat2Index? hisat2Index
        String strandedness
        File? refflatFile
        Boolean variantCalling = false
    }

    scatter (lib in sample.libraries) {
        call libraryWorkflow.Library as library {
            input:
                reference = reference,
                dbsnp = dbsnp,
                starIndexDir = starIndexDir,
                hisat2Index = hisat2Index,
                strandedness = strandedness,
                refflatFile = refflatFile,
                outputDir = outputDir + "/lib_" + lib.id,
                sample = sample,
                library = lib,
                variantCalling = variantCalling
        }
        File lbBamFiles = library.bamFile.file
        File indexFiles = library.bamFile.index
    }

    Boolean multipleBams = length(library.bamFile) > 1

    # Merge library (mdup) bams into one (for counting).
    if (multipleBams) {
        call samtools.Merge as mergeLibraries {
            input:
                bamFiles = lbBamFiles,
                outputBamPath = outputDir + "/" + sample.id + ".bam"
        }

        call samtools.Index as mergedIndex {
            input:
                bamFile = mergeLibraries.outputBam,
                bamIndexPath = outputDir + "/" + sample.id + ".bai"
        }
    }

    # Create links instead, if there is only one bam, to retain output structure.
    if (! multipleBams) {
        call common.CreateLink as linkBam {
            input:
                inputFile = library.bamFile[0].file,
                outputPath = outputDir + "/" + sample.id + ".bam"
        }

        call common.CreateLink as linkIndex {
            input:
                inputFile = library.bamFile[0].index,
                outputPath = outputDir + "/" + sample.id + ".bai"
        }
    }

    if (variantCalling) {
    # variant calling, requires different bam file than counting
        call gvcf.Gvcf as createGvcf {
            input:

                bamFiles = select_all(library.preprocessBamFile),
                gvcfPath = outputDir + "/" + sample.id + ".g.vcf.gz",
                dbsnpVCF = select_first([dbsnp]),
                reference = reference
        }
    }

    output {
        String sampleName = sample.id
        IndexedBamFile bam = if multipleBams
            then select_first([mergedIndex.outputBam])
            else library.bamFile[0]
        IndexedVcfFile? gvcfFile = createGvcf.outputGVcf
    }
}
