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
        Reference reference
        IndexedVcfFile dbsnp
        String starIndexDir
        String strandedness
        File refflatFile
        File gtfFile
    }

    String expressionDir = outputDir + "/expression_measures/"
    String genotypingDir = outputDir + "/multisample_variants/"

    # Validation of annotations and dbSNP
    call biopet.ValidateAnnotation as validateAnnotation {
        input:
            refRefflat = refflatFile,
            gtfFile = gtfFile,
            reference = reference
    }

    call biopet.ValidateVcf as validateVcf {
        input:
            vcf = dbsnp,
            reference = reference
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
            strandedness = strandedness,
            #refflatFile = refflatFile,
            gtfFile = gtfFile
    }

    call jointgenotyping.JointGenotyping as genotyping {
        input:
            reference = reference,
            outputDir = genotypingDir,
            gvcfFiles = sample.gvcfFile,
            vcfBasename = "multisample",
            dbsnpVCF = dbsnp
    }

    call biopet.VcfStats as vcfStats {
        input:
            vcf = genotyping.vcfFile,
            reference = reference,
            outputDir = genotypingDir + "/stats"
    }

    output {
    }
}
