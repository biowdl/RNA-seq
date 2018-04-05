import "sample.wdl" as sample
import "tasks/biopet.wdl" as biopet
import "tasks/mergecounts.wdl" as mergeCounts

workflow main {
    Array[File] sampleConfigs
    String outputDir

    #parse sample configs
    call biopet.SampleConfig as config {
        input:
            inputFiles = sampleConfigs
    }

    scatter (sm in config.keys){
        call sample.sample  as sample_call {
            input:
                sampleDir = outputDir + "/samples/" + sm + "/",
                expressionDir = outputDir + "/expression_measures/",
                sampleConfigs = sampleConfigs,
                sampleId = sm
        }
    }

    # Merge count tables into one multisample count table per count type
    call mergeCounts.MergeCounts as mergedTPMs {
        input:
            inputFiles = sample_call.TPMTable,
            outputFile = outputDir + "/expression_measures/TPM/all_samples.TPM",
            idVar = "'Gene ID'",
            measurementVar = "TPM"
    }

    call mergeCounts.MergeCounts as mergedFPKMs {
        input:
            inputFiles = sample_call.FPKMTable,
            outputFile = outputDir + "/expression_measures/FPKM/all_samples.FPKM",
            idVar = "'Gene ID'",
            measurementVar = "FPKM"
    }

    call mergeCounts.MergeCounts as mergedFragmentsPerGenes {
        input:
            inputFiles = sample_call.fragmentsPerGeneTable,
            outputFile = outputDir + "/expression_measures/fragments_per_gene/all_samples.fragments_per_gene",
            idVar = "feature",
            measurementVar = "counts"
    }

    call mergeCounts.MergeCounts as mergedBaseCountsPerGene {
        input:
            inputFiles = sample_call.baseCountsPerGeneTable,
            outputFile = outputDir + "/BaseCounter/all_samples.base.gene.counts",
            idVar = "X1",
            measurementVar = "X2"
        }

    #TODO merge vcfs

    output {
        Array[String] samples = config.keys
    }
}
