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
        File? starIndexDir
        Hisat2Index? hisat2Index
        String strandedness
        File? refflatFile
        Boolean variantCalling = false
        Map[String, String] dockerTags
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
                variantCalling = variantCalling,
                dockerTags = dockerTags
        }
        File lbBamFiles = library.bamFile.file
        File indexFiles = library.bamFile.index
    }

    # Merge library (mdup) bams into one (for counting).

    call samtools.Merge as mergeLibraries {
        input:
            bamFiles = lbBamFiles,
            outputBamPath = outputDir + "/" + sample.id + ".bam",
            dockerTag = dockerTags["samtools"]
    }

    if (variantCalling) {
    # variant calling, requires different bam file than counting
        call gvcf.Gvcf as createGvcf {
            input:

                bamFiles = select_all(library.preprocessBamFile),
                gvcfPath = outputDir + "/" + sample.id + ".g.vcf.gz",
                dbsnpVCF = select_first([dbsnp]),
                reference = reference,
                dockerTags = dockerTags
        }
    }

    output {
        String sampleName = sample.id
        IndexedBamFile bam = {
            "file": mergeLibraries.outputBam,
            "index": mergeLibraries.outputBamIndex
        }
        IndexedVcfFile? gvcfFile = createGvcf.outputGVcf
    }
}
