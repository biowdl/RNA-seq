version 1.0

import "expression-quantification/multi-bam-quantify.wdl" as expressionQuantification
import "jointgenotyping/jointgenotyping.wdl" as jointgenotyping
import "rna-coding-potential/rna-coding-potential.wdl" as rnacodingpotential
import "sample.wdl" as sampleWorkflow
import "structs.wdl" as structs
import "tasks/biopet/biopet.wdl" as biopet
import "tasks/biopet/sampleconfig.wdl" as sampleconfig
import "tasks/common.wdl" as common
import "tasks/gffcompare.wdl" as gffcompare
import "tasks/multiqc.wdl" as multiqc

workflow pipeline {
    input {
        File sampleConfigFile
        Array[Sample] samples = []
        String outputDir
        Reference reference
        IndexedVcfFile? dbsnp
        File? starIndexDir
        Hisat2Index? hisat2Index
        String strandedness
        File? refflatFile
        File? referenceGtfFile
        Array[File] lncRNAdatabases = []
        Boolean variantCalling = false
        Boolean lncRNAdetection = false
        Boolean detectNovelTranscipts = false
        File? cpatLogitModel
        File? cpatHex
        File dockerTagsFile
    }

    String expressionDir = outputDir + "/expression_measures/"
    String genotypingDir = outputDir + "/multisample_variants/"

    # Parse docker Tags configuration and sample sheet
    call common.YamlToJson as ConvertDockerTagsFile {
        input:
            yaml = dockerTagsFile,
            outputJson = outputDir + "/dockerTags.json"
    }
    Map[String, String] dockerTags = read_json(ConvertDockerTagsFile.json)

    call common.YamlToJson as ConvertSampleConfig {
        input:
            yaml = sampleConfigFile,
            outputJson = outputDir + "/samples.json"
    }
    SampleConfig sampleConfig = read_json(ConvertSampleConfig.json)
    Array[Sample] allSamples = flatten([samples, sampleConfig.samples])

    #FIXME The following Copy calls are a workaround to ensure all data is on the same device.
    #      This is necssary to avoid cromwell from copying the data an excessive amount of times.
    #      Since containers are being used, soft-linking cannot be used for localization.
    #      Hard-links cannot be made between different devices/shares. Therefore, cromwell will
    #      resort to copying input files. It will do so seperatly for every call, which creates a
    #      huge amount of overhead in disk usage. By copying the data to (presumably) the same
    #      device as the cromwell-execution folder, hard-linking can be used instead.

    #Copy reference into output directory
    call common.Copy as copyFasta {
        input:
            inputFile = reference.fasta,
            outputPath = outputDir + "/reference/fasta/" + basename(reference.fasta)
    }

    call common.Copy as copyFai {
        input:
            inputFile = reference.fai,
            outputPath = outputDir + "/reference/fasta/" + basename(reference.fai)
    }

    call common.Copy as copyDict {
        input:
            inputFile = reference.dict,
            outputPath = outputDir + "/reference/fasta/" + basename(reference.dict)
    }

    Reference effectiveReference = object {
        fasta: copyFasta.outputFile,
        fai: copyFai.outputFile,
        dict: copyDict.outputFile
    }

    # Copy and validate dnsnp
    if (defined(dbsnp)) {
        IndexedVcfFile definedDBsnp = select_first([dbsnp])
        call common.Copy as copyDBsnp {
            input:
                inputFile = definedDBsnp.file,
                outputPath = outputDir + "/reference/dbsnp/" + basename(definedDBsnp.file)
        }

        call common.Copy as copyDBsnpIndex {
            input:
                inputFile = definedDBsnp.index,
                outputPath = outputDir + "/reference/dbsnp/" + basename(definedDBsnp.index)
        }

        IndexedVcfFile effectiveDBsnp = object {
            file: copyDBsnp.outputFile,
            index: copyDBsnpIndex.outputFile
        }

        call biopet.ValidateVcf as validateVcf {
            input:
                vcf = effectiveDBsnp,
                reference = effectiveReference,
                dockerTag = dockerTags["biopet-validatevcf"]
        }
    }

    # Copy indexes into output directory
    if (defined(starIndexDir)) {
        call common.Copy as copyStarIndex {
            input:
                inputFile = select_first([starIndexDir]),
                outputPath = outputDir + "/reference/star_index/" +
                    basename(select_first([starIndexDir])),
                recursive = true
        }
    }

    if (defined(hisat2Index)) {
        Hisat2Index definedHisat2Index = select_first([hisat2Index])
        call common.Copy as copyHisat2Index {
            input:
                inputFile = definedHisat2Index.directory,
                outputPath = outputDir + "/reference/hisat2_index/" +
                    definedHisat2Index.directory,
                recursive = true
        }

        Hisat2Index effectiveHisat2Index = object {
            directory: copyHisat2Index.outputFile,
            basename: definedHisat2Index.basename
        }
    }

    # Copy and validate annotations
    if (defined(referenceGtfFile) && defined(refflatFile)) {
        call common.Copy as copyRefflat {
            input:
                inputFile = select_first([refflatFile]),
                outputPath = outputDir + "/reference/annotations/" +
                    basename(select_first([refflatFile]))
        }

        call common.Copy as copyReferenceGtf {
            input:
                inputFile = select_first([referenceGtfFile]),
                outputPath = outputDir + "/reference/annotations/" +
                    basename(select_first([referenceGtfFile]))
        }

        call biopet.ValidateAnnotation as validateAnnotation {
            input:
                refRefflat = copyRefflat.outputFile,
                gtfFile = copyReferenceGtf.outputFile,
                reference = effectiveReference,
                dockerTag = dockerTags["biopet-validateannotation"]
        }
    }

    # Start processing of data
    scatter (sm in allSamples) {
        call sampleWorkflow.Sample as sample {
            input:
                sample = sm,
                outputDir = outputDir + "/samples/" + sm.id,
                reference = effectiveReference,
                dbsnp = effectiveDBsnp,
                starIndexDir = copyStarIndex.outputFile,
                hisat2Index = effectiveHisat2Index,
                strandedness = strandedness,
                refflatFile = copyRefflat.outputFile,
                variantCalling = variantCalling,
                dockerTags = dockerTags
        }
    }

    call expressionQuantification.MultiBamExpressionQuantification as expression {
        input:
            bams = zip(sample.sampleName, sample.bam),
            outputDir = expressionDir,
            strandedness = strandedness,
            referenceGtfFile = copyReferenceGtf.outputFile,
            detectNovelTranscripts = lncRNAdetection || detectNovelTranscipts,
            dockerTags = dockerTags
    }

    if (variantCalling) {
        call jointgenotyping.JointGenotyping as genotyping {
            input:
                reference = effectiveReference,
                outputDir = genotypingDir,
                gvcfFiles = select_all(sample.gvcfFile),
                vcfBasename = "multisample",
                dbsnpVCF = select_first([effectiveDBsnp]),
                dockerTags = dockerTags
        }

        # TODO: Look for a MultiQC replacement with good performance.
        call biopet.VcfStats as vcfStats {
            input:
                vcf = genotyping.vcfFile,
                reference = effectiveReference,
                outputDir = genotypingDir + "/stats",
                dockerTag = dockerTags["biopet-vcfstats"]
        }
        File vcfFile = genotyping.vcfFile.file
    }

    if (lncRNAdetection) {
        #FIXME See comment on Copy calls above.
        call common.Copy as copyCPATlogitModel {
            input:
                inputFile = select_first([cpatLogitModel]),
                outputPath = outputDir + "/lncrna/coding-potential/" +
                    basename(select_first([cpatLogitModel]))
        }

        call common.Copy as copyCPAThex {
            input:
                inputFile = select_first([cpatHex]),
                outputPath = outputDir + "/lncrna/coding-potential/" +
                    basename(select_first([cpatHex]))
        }

        call rnacodingpotential.RnaCodingPotential as RnaCodingPotential {
            input:
                outputDir = outputDir + "/lncrna/coding-potential",
                transcriptsGff = select_first([expression.mergedGtfFile]),
                referenceFasta = effectiveReference.fasta,
                referenceFastaIndex = effectiveReference.fai,
                cpatLogitModel = copyCPATlogitModel.outputFile,
                cpatHex = copyCPAThex.outputFile,
                dockerTags = dockerTags
        }

        scatter (database in lncRNAdatabases) {
            #FIXME See comment on Copy calls above.
            call common.Copy as copyDatabase {
                input:
                    inputFile = database,
                    outputPath = outputDir + "/lncrna/" + basename(database)
            }

            call gffcompare.GffCompare as GffCompare {
                input:
                    inputGtfFiles = select_all([expression.mergedGtfFile]),
                    referenceAnnotation = copyDatabase.outputFile,
                    outputDir = outputDir + "/lncrna/" + basename(database) + ".d",
                    dockerTag = dockerTags["gffcompare"]
            }
        }
        # These files are created so that multiqc has some dependencies to wait for.
        # In theory this could be done by all sort of flattening array stuff, but
        # this is the simplest way. I could not get the other ways to work.
        File cpatOutputs = write_lines([RnaCodingPotential.cpatOutput])
        File gffComparisons = write_lines(GffCompare.annotated)
    }

    call multiqc.MultiQC as multiqcTask {
        input:
            # Multiqc will only run if these files are created.
            # Need to do some select_all and flatten magic here
            # so only outputs from workflows that are run are taken
            # as dependencies
            # vcfFile
            dependencies = select_all([expression.TPMTable, RnaCodingPotential.cpatOutput, gffComparisons, vcfFile]),
            outDir = outputDir + "/multiqc",
            analysisDirectory = outputDir,
            dockerTag = dockerTags["multiqc"]
    }

    output {
        File report = multiqcTask.multiqcReport
    }
}
