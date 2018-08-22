version 1.0

import "expression-quantification/multi-bam-quantify.wdl" as expressionQuantification
import "jointgenotyping/jointgenotyping.wdl" as jointgenotyping
import "sample.wdl" as sampleWorkflow
import "tasks/biopet.wdl" as biopet
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
            refFasta = rnaSeqInput.reference.fasta,
            refFastaIndex = rnaSeqInput.reference.fai,
            refDict = rnaSeqInput.reference.dict
    }

    call biopet.ValidateVcf as validateVcf {
        input:
            vcfFile = rnaSeqInput.dbsnp.file,
            vcfIndex = rnaSeqInput.dbsnp.index,
            refFasta = rnaSeqInput.reference.fasta,
            refFastaIndex = rnaSeqInput.reference.fai,
            refDict = rnaSeqInput.reference.dict
    }

    call biopet.SampleConfigCromwellArrays as configFile {
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
            bams = zip(sample.sampleName, zip(sample.bam, sample.bai)),
            outputDir = expressionDir,
            strandedness = rnaSeqInput.strandedness,
            refflatFile = rnaSeqInput.refflatFile,
            gtfFile = rnaSeqInput.gtfFile
    }

    call jointgenotyping.JointGenotyping as genotyping {
        input:
            refFasta = rnaSeqInput.reference.fasta,
            refFastaIndex = rnaSeqInput.reference.fai,
            refDict = rnaSeqInput.reference.dict,
            outputDir = genotypingDir,
            gvcfFiles = sample.gvcfFile,
            gvcfIndexes = sample.gvcfFileIndex,
            vcfBasename = "multisample",
            dbsnpVCF = rnaSeqInput.dbsnp.file,
            dbsnpVCFindex = rnaSeqInput.dbsnp.index
    }

    call biopet.VcfStats as vcfStats {
        input:
            vcfFile = genotyping.vcfFile,
            vcfIndex = genotyping.vcfFileIndex,
            refFasta = rnaSeqInput.reference.fasta,
            refFastaIndex = rnaSeqInput.reference.fai,
            refDict = rnaSeqInput.reference.dict,
            outputDir = genotypingDir + "/stats"
    }

    output {
    }
}
