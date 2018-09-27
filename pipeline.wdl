version 1.0

import "expression-quantification/multi-bam-quantify.wdl" as expressionQuantification
import "jointgenotyping/jointgenotyping.wdl" as jointgenotyping
import "sample.wdl" as sampleWorkflow
import "tasks/biopet/biopet.wdl" as biopet
import "tasks/biopet/sampleconfig.wdl" as sampleconfig
import "structs.wdl" as structs
import "tasks/common.wdl" as common

workflow pipeline {
    input {
        Array[File] sampleConfigFiles
        String outputDir
        RnaSeqInput rnaSeqInput
    }

    String expressionDir = outputDir + "/expression_measures/"
    String genotypingDir = outputDir + "/multisample_variants/"

    # Validation of annotations and dbSNP
    call biopet.ValidateAnnotation as validateAnnotation {
        input:
            refRefflat = rnaSeqInput.refflatFile,
            gtfFile = rnaSeqInput.gtfFile,
            reference = rnaSeqInput.reference
    }

    call biopet.ValidateVcf as validateVcf {
        input:
            vcf = rnaSeqInput.dbsnp,
            reference = rnaSeqInput.reference
    }

    call sampleconfig.SampleConfigCromwellArrays as configFile {
      input:
        inputFiles = sampleConfigFiles,
        outputPath = "samples.json"
    }

    Root config = read_json(configFile.outputFile)

    scatter (sm in config.samples) {
        call sampleWorkflow.Sample as sample {
            input:
                rnaSeqInput = rnaSeqInput,
                sample = sm,
                outputDir = outputDir + "/samples/" + sm.id
        }
    }

    call expressionQuantification.MultiBamExpressionQuantification as expression {
        input:
            bams = zip(sample.sampleName, sample.bam),
            outputDir = expressionDir,
            strandedness = rnaSeqInput.strandedness,
            refflatFile = rnaSeqInput.refflatFile,
            gtfFile = rnaSeqInput.gtfFile
    }

    call jointgenotyping.JointGenotyping as genotyping {
        input:
            reference = rnaSeqInput.reference,
            outputDir = genotypingDir,
            gvcfFiles = sample.gvcfFile,
            vcfBasename = "multisample",
            dbsnpVCF = rnaSeqInput.dbsnp
    }

    call biopet.VcfStats as vcfStats {
        input:
            vcf = genotyping.vcfFile,
            reference = rnaSeqInput.reference,
            outputDir = genotypingDir + "/stats"
    }

    output {
    }
}
