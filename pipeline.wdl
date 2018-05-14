import "sample.wdl" as sampleWorkflow
import "tasks/biopet.wdl" as biopet
import "jointgenotyping/jointgenotyping.wdl" as jointgenotyping
import "expression-quantification/multi-bam-quantify.wdl" as expressionQuantification

workflow pipeline {
    Array[File] sampleConfigs
    String outputDir
    File ref_fasta
    File ref_dict
    File ref_fasta_index
    File ref_refflat
    File ref_gtf
    String strandedness

    #parse sample configs
    call biopet.SampleConfig as config {
        input:
            inputFiles = sampleConfigs,
            stdoutFile = outputDir + "/config.keys"
    }

    scatter (sm in read_lines(config.keysFile)){
        call sampleWorkflow.sample  as sample {
            input:
                sampleDir = outputDir + "/samples/" + sm + "/",
                sampleConfigs = sampleConfigs,
                sampleId = sm,
                ref_fasta = ref_fasta,
                ref_dict = ref_dict,
                ref_fasta_index = ref_fasta_index
        }
    }

    call expressionQuantification.MultiBamExpressionQuantification as expression {
        input:
            bams = zip(sample.sampleName, sample.bam),
            outputDir = outputDir + "/expression_measures/",
            strandedness = strandedness,
            ref_gtf = ref_gtf,
            ref_refflat = ref_refflat
    }

    call jointgenotyping.JointGenotyping {
        input:
            ref_fasta = ref_fasta,
            ref_dict = ref_dict,
            ref_fasta_index = ref_fasta_index,
            outputDir = outputDir,
            gvcfFiles = sample.gvcfFile,
            gvcfIndexes = sample.gvcfFileIndex,
            vcf_basename = "multisample"
    }

    output {
        Array[String] samples = config.keys
    }
}
