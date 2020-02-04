---
layout: default
title: "Inputs: pipeline"
---

# Inputs for pipeline

The following is an overview of all available inputs in
pipeline.


## Required inputs
<dl>
<dt id="pipeline.dockerImagesFile"><a href="#pipeline.dockerImagesFile">pipeline.dockerImagesFile</a></dt>
<dd>
    <i>File </i><br />
    A YAML file describing the docker image used for the tasks. The dockerImages.yml provided with the pipeline is recommended.
</dd>
<dt id="pipeline.hisat2Index"><a href="#pipeline.hisat2Index">pipeline.hisat2Index</a></dt>
<dd>
    <i>Array[File]+? </i><br />
    The hisat2 index files. Defining this will cause the hisat2 aligner to run. Note that is starIndex is also defined the star results will be used for downstream analyses. May be omitted in starIndex is defined.
</dd>
<dt id="pipeline.outputDir"><a href="#pipeline.outputDir">pipeline.outputDir</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"."</code><br />
    The output directory.
</dd>
<dt id="pipeline.referenceFasta"><a href="#pipeline.referenceFasta">pipeline.referenceFasta</a></dt>
<dd>
    <i>File </i><br />
    The reference fasta file
</dd>
<dt id="pipeline.referenceFastaDict"><a href="#pipeline.referenceFastaDict">pipeline.referenceFastaDict</a></dt>
<dd>
    <i>File </i><br />
    Sequence dictionary (.dict) file of the reference
</dd>
<dt id="pipeline.referenceFastaFai"><a href="#pipeline.referenceFastaFai">pipeline.referenceFastaFai</a></dt>
<dd>
    <i>File </i><br />
    Fasta index (.fai) file of the reference
</dd>
<dt id="pipeline.sampleConfigFile"><a href="#pipeline.sampleConfigFile">pipeline.sampleConfigFile</a></dt>
<dd>
    <i>File </i><br />
    The samplesheet, including sample ids, library ids, readgroup ids and fastq file locations.
</dd>
<dt id="pipeline.starIndex"><a href="#pipeline.starIndex">pipeline.starIndex</a></dt>
<dd>
    <i>Array[File]+? </i><br />
    The star index files. Defining this will cause the star aligner to run and be used for downstream analyses. May be ommited if hisat2Index is defined.
</dd>
<dt id="pipeline.strandedness"><a href="#pipeline.strandedness">pipeline.strandedness</a></dt>
<dd>
    <i>String </i><br />
    The strandedness of the RNA sequencing library preparation. One of "None" (unstranded), "FR" (forward-reverse: first read equal transcript) or "RF" (reverse-forward: second read equals transcript).
</dd>
</dl>

## Other common inputs
<dl>
<dt id="pipeline.cpatHex"><a href="#pipeline.cpatHex">pipeline.cpatHex</a></dt>
<dd>
    <i>File? </i><br />
    A hexamer frequency table for CPAT. Required if lncRNAdetection is `true`.
</dd>
<dt id="pipeline.cpatLogitModel"><a href="#pipeline.cpatLogitModel">pipeline.cpatLogitModel</a></dt>
<dd>
    <i>File? </i><br />
    A logit model for CPAT. Required if lncRNAdetection is `true`.
</dd>
<dt id="pipeline.dbsnpVCF"><a href="#pipeline.dbsnpVCF">pipeline.dbsnpVCF</a></dt>
<dd>
    <i>File? </i><br />
    dbsnp VCF file used for checking known sites
</dd>
<dt id="pipeline.dbsnpVCFIndex"><a href="#pipeline.dbsnpVCFIndex">pipeline.dbsnpVCFIndex</a></dt>
<dd>
    <i>File? </i><br />
    Index (.tbi) file for the dbsnp VCF
</dd>
<dt id="pipeline.detectNovelTranscripts"><a href="#pipeline.detectNovelTranscripts">pipeline.detectNovelTranscripts</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not a transcripts assembly should be used. If set to true Stringtie will be used to create a new GTF file based on the BAM files. This generated GTF file will be used for expression quantification. If `referenceGtfFile` is also provided this reference GTF will be used to guide the assembly.
</dd>
<dt id="pipeline.expression.stringtieAssembly.geneAbundanceFile"><a href="#pipeline.expression.stringtieAssembly.geneAbundanceFile">pipeline.expression.stringtieAssembly.geneAbundanceFile</a></dt>
<dd>
    <i>String? </i><br />
    Where the abundance file should be written.
</dd>
<dt id="pipeline.lncRNAdatabases"><a href="#pipeline.lncRNAdatabases">pipeline.lncRNAdatabases</a></dt>
<dd>
    <i>Array[File] </i><i>&mdash; Default:</i> <code>[]</code><br />
    A set of GTF files the assembled GTF file should be compared with. Only used if lncRNAdetection is set to `true`.
</dd>
<dt id="pipeline.lncRNAdetection"><a href="#pipeline.lncRNAdetection">pipeline.lncRNAdetection</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not lncRNA detection should be run. This will enable detectNovelTranscript (this cannot be disabled by setting detectNovelTranscript to false). This will require cpatLogitModel and cpatHex to be defined.
</dd>
<dt id="pipeline.preprocessing.regions"><a href="#pipeline.preprocessing.regions">pipeline.preprocessing.regions</a></dt>
<dd>
    <i>File? </i><br />
    A bed file describing the regions to operate on.
</dd>
<dt id="pipeline.referenceGtfFile"><a href="#pipeline.referenceGtfFile">pipeline.referenceGtfFile</a></dt>
<dd>
    <i>File? </i><br />
    A reference GTF file. Used for expression quantification or to guide the transcriptome assembly if detectNovelTranscripts is set to `true` (this GTF won't be be used directly for the expression quantification in that case.
</dd>
<dt id="pipeline.refflatFile"><a href="#pipeline.refflatFile">pipeline.refflatFile</a></dt>
<dd>
    <i>File? </i><br />
    A refflat files describing the genes. If this is defined RNAseq metrics will be collected.
</dd>
<dt id="pipeline.sampleJobs.bamMetrics.ampliconIntervals"><a href="#pipeline.sampleJobs.bamMetrics.ampliconIntervals">pipeline.sampleJobs.bamMetrics.ampliconIntervals</a></dt>
<dd>
    <i>File? </i><br />
    An interval list describinig the coordinates of the amplicons sequenced. This should only be used for targeted sequencing or WES. Required if `ampliconIntervals` is defined.
</dd>
<dt id="pipeline.sampleJobs.bamMetrics.targetIntervals"><a href="#pipeline.sampleJobs.bamMetrics.targetIntervals">pipeline.sampleJobs.bamMetrics.targetIntervals</a></dt>
<dd>
    <i>Array[File]+? </i><br />
    An interval list describing the coordinates of the targets sequenced. This should only be used for targeted sequencing or WES. If defined targeted PCR metrics will be collected. Requires `ampliconIntervals` to also be defined.
</dd>
<dt id="pipeline.sampleJobs.indexStarBam.outputBamPath"><a href="#pipeline.sampleJobs.indexStarBam.outputBamPath">pipeline.sampleJobs.indexStarBam.outputBamPath</a></dt>
<dd>
    <i>String? </i><br />
    The location where the BAM file should be written to. The index will appear alongside this link to the BAM file.
</dd>
<dt id="pipeline.sampleJobs.qc.adapterForward"><a href="#pipeline.sampleJobs.qc.adapterForward">pipeline.sampleJobs.qc.adapterForward</a></dt>
<dd>
    <i>String? </i><i>&mdash; Default:</i> <code>"AGATCGGAAGAG"</code><br />
    The adapter to be removed from the reads first or single end reads.
</dd>
<dt id="pipeline.sampleJobs.qc.adapterReverse"><a href="#pipeline.sampleJobs.qc.adapterReverse">pipeline.sampleJobs.qc.adapterReverse</a></dt>
<dd>
    <i>String? </i><i>&mdash; Default:</i> <code>"AGATCGGAAGAG"</code><br />
    The adapter to be removed from the reads second end reads.
</dd>
<dt id="pipeline.sampleJobs.qc.contaminations"><a href="#pipeline.sampleJobs.qc.contaminations">pipeline.sampleJobs.qc.contaminations</a></dt>
<dd>
    <i>Array[String]+? </i><br />
    Contaminants/adapters to be removed from the reads.
</dd>
<dt id="pipeline.sampleJobs.qc.readgroupName"><a href="#pipeline.sampleJobs.qc.readgroupName">pipeline.sampleJobs.qc.readgroupName</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>sub(basename(read1),"(\.fq)?(\.fastq)?(\.gz)?","")</code><br />
    The name of the readgroup.
</dd>
<dt id="pipeline.variantCalling"><a href="#pipeline.variantCalling">pipeline.variantCalling</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not variantcalling should be performed.
</dd>
<dt id="pipeline.variantcalling.callAutosomal.haplotypeCaller.excludeIntervalList"><a href="#pipeline.variantcalling.callAutosomal.haplotypeCaller.excludeIntervalList">pipeline.variantcalling.callAutosomal.haplotypeCaller.excludeIntervalList</a></dt>
<dd>
    <i>Array[File]+? </i><br />
    Bed files or interval lists describing the regions to NOT operate on.
</dd>
<dt id="pipeline.variantcalling.callAutosomal.haplotypeCaller.ploidy"><a href="#pipeline.variantcalling.callAutosomal.haplotypeCaller.ploidy">pipeline.variantcalling.callAutosomal.haplotypeCaller.ploidy</a></dt>
<dd>
    <i>Int? </i><br />
    The ploidy with which the variants should be called.
</dd>
<dt id="pipeline.variantcalling.callX.excludeIntervalList"><a href="#pipeline.variantcalling.callX.excludeIntervalList">pipeline.variantcalling.callX.excludeIntervalList</a></dt>
<dd>
    <i>Array[File]+? </i><br />
    Bed files or interval lists describing the regions to NOT operate on.
</dd>
<dt id="pipeline.variantcalling.callY.excludeIntervalList"><a href="#pipeline.variantcalling.callY.excludeIntervalList">pipeline.variantcalling.callY.excludeIntervalList</a></dt>
<dd>
    <i>Array[File]+? </i><br />
    Bed files or interval lists describing the regions to NOT operate on.
</dd>
<dt id="pipeline.variantcalling.regions"><a href="#pipeline.variantcalling.regions">pipeline.variantcalling.regions</a></dt>
<dd>
    <i>File? </i><br />
    A bed file describing the regions to operate on.
</dd>
<dt id="pipeline.variantcalling.vcfBasename"><a href="#pipeline.variantcalling.vcfBasename">pipeline.variantcalling.vcfBasename</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"multisample"</code><br />
    The basename of the VCF and GVCF files that are outputted by the workflow
</dd>
<dt id="pipeline.variantcalling.XNonParRegions"><a href="#pipeline.variantcalling.XNonParRegions">pipeline.variantcalling.XNonParRegions</a></dt>
<dd>
    <i>File? </i><br />
    Bed file with the non-PAR regions of X
</dd>
<dt id="pipeline.variantcalling.YNonParRegions"><a href="#pipeline.variantcalling.YNonParRegions">pipeline.variantcalling.YNonParRegions</a></dt>
<dd>
    <i>File? </i><br />
    Bed file with the non-PAR regions of Y
</dd>
</dl>

## Advanced inputs
<details>
<summary> Show/Hide </summary>
<dl>
<dt id="pipeline.ConvertDockerTagsFile.dockerImage"><a href="#pipeline.ConvertDockerTagsFile.dockerImage">pipeline.ConvertDockerTagsFile.dockerImage</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"quay.io/biocontainers/biowdl-input-converter:0.2.1--py_0"</code><br />
    The docker image used for this task. Changing this may result in errors which the developers may choose not to address.
</dd>
<dt id="pipeline.ConvertSampleConfig.checkFileMd5sums"><a href="#pipeline.ConvertSampleConfig.checkFileMd5sums">pipeline.ConvertSampleConfig.checkFileMd5sums</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not the MD5 sums of the files mentioned in the samplesheet should be checked.
</dd>
<dt id="pipeline.ConvertSampleConfig.dockerImage"><a href="#pipeline.ConvertSampleConfig.dockerImage">pipeline.ConvertSampleConfig.dockerImage</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"quay.io/biocontainers/biowdl-input-converter:0.2.1--py_0"</code><br />
    The docker image used for this task. Changing this may result in errors which the developers may choose not to address.
</dd>
<dt id="pipeline.ConvertSampleConfig.old"><a href="#pipeline.ConvertSampleConfig.old">pipeline.ConvertSampleConfig.old</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not the old samplesheet format should be used.
</dd>
<dt id="pipeline.ConvertSampleConfig.skipFileCheck"><a href="#pipeline.ConvertSampleConfig.skipFileCheck">pipeline.ConvertSampleConfig.skipFileCheck</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Whether or not the existance of the files mentioned in the samplesheet should be checked.
</dd>
<dt id="pipeline.CPAT.startCodons"><a href="#pipeline.CPAT.startCodons">pipeline.CPAT.startCodons</a></dt>
<dd>
    <i>Array[String]? </i><br />
    Equivalent to CPAT's `--start` option.
</dd>
<dt id="pipeline.CPAT.stopCodons"><a href="#pipeline.CPAT.stopCodons">pipeline.CPAT.stopCodons</a></dt>
<dd>
    <i>Array[String]? </i><br />
    Equivalent to CPAT's `--stop` option.
</dd>
<dt id="pipeline.expression.additionalAttributes"><a href="#pipeline.expression.additionalAttributes">pipeline.expression.additionalAttributes</a></dt>
<dd>
    <i>Array[String]+? </i><br />
    Additional attributes which should be taken from the GTF used for quantification and added to the merged expression value tables.
</dd>
<dt id="pipeline.expression.htSeqCount.additionalAttributes"><a href="#pipeline.expression.htSeqCount.additionalAttributes">pipeline.expression.htSeqCount.additionalAttributes</a></dt>
<dd>
    <i>Array[String] </i><i>&mdash; Default:</i> <code>[]</code><br />
    Equivalent to the --additional-attr option of htseq-count.
</dd>
<dt id="pipeline.expression.htSeqCount.featureType"><a href="#pipeline.expression.htSeqCount.featureType">pipeline.expression.htSeqCount.featureType</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to the --type option of htseq-count.
</dd>
<dt id="pipeline.expression.htSeqCount.format"><a href="#pipeline.expression.htSeqCount.format">pipeline.expression.htSeqCount.format</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"bam"</code><br />
    Equivalent to the -f option of htseq-count.
</dd>
<dt id="pipeline.expression.htSeqCount.idattr"><a href="#pipeline.expression.htSeqCount.idattr">pipeline.expression.htSeqCount.idattr</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to the --idattr option of htseq-count.
</dd>
<dt id="pipeline.expression.htSeqCount.memory"><a href="#pipeline.expression.htSeqCount.memory">pipeline.expression.htSeqCount.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"40G"</code><br />
    The amount of memory the job requires in GB.
</dd>
<dt id="pipeline.expression.htSeqCount.order"><a href="#pipeline.expression.htSeqCount.order">pipeline.expression.htSeqCount.order</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"pos"</code><br />
    Equivalent to the -r option of htseq-count.
</dd>
<dt id="pipeline.expression.mergedHTSeqFragmentsPerGenes.featureAttribute"><a href="#pipeline.expression.mergedHTSeqFragmentsPerGenes.featureAttribute">pipeline.expression.mergedHTSeqFragmentsPerGenes.featureAttribute</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to the -F option of collect-columns.
</dd>
<dt id="pipeline.expression.mergedHTSeqFragmentsPerGenes.featureColumn"><a href="#pipeline.expression.mergedHTSeqFragmentsPerGenes.featureColumn">pipeline.expression.mergedHTSeqFragmentsPerGenes.featureColumn</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to the -f option of collect-columns.
</dd>
<dt id="pipeline.expression.mergedHTSeqFragmentsPerGenes.header"><a href="#pipeline.expression.mergedHTSeqFragmentsPerGenes.header">pipeline.expression.mergedHTSeqFragmentsPerGenes.header</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to the -H flag of collect-columns.
</dd>
<dt id="pipeline.expression.mergedHTSeqFragmentsPerGenes.separator"><a href="#pipeline.expression.mergedHTSeqFragmentsPerGenes.separator">pipeline.expression.mergedHTSeqFragmentsPerGenes.separator</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to the -s option of collect-columns.
</dd>
<dt id="pipeline.expression.mergedHTSeqFragmentsPerGenes.valueColumn"><a href="#pipeline.expression.mergedHTSeqFragmentsPerGenes.valueColumn">pipeline.expression.mergedHTSeqFragmentsPerGenes.valueColumn</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to the -c option of collect-columns.
</dd>
<dt id="pipeline.expression.mergedStringtieFPKMs.featureAttribute"><a href="#pipeline.expression.mergedStringtieFPKMs.featureAttribute">pipeline.expression.mergedStringtieFPKMs.featureAttribute</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to the -F option of collect-columns.
</dd>
<dt id="pipeline.expression.mergedStringtieFPKMs.featureColumn"><a href="#pipeline.expression.mergedStringtieFPKMs.featureColumn">pipeline.expression.mergedStringtieFPKMs.featureColumn</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to the -f option of collect-columns.
</dd>
<dt id="pipeline.expression.mergedStringtieFPKMs.separator"><a href="#pipeline.expression.mergedStringtieFPKMs.separator">pipeline.expression.mergedStringtieFPKMs.separator</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to the -s option of collect-columns.
</dd>
<dt id="pipeline.expression.mergedStringtieTPMs.featureAttribute"><a href="#pipeline.expression.mergedStringtieTPMs.featureAttribute">pipeline.expression.mergedStringtieTPMs.featureAttribute</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to the -F option of collect-columns.
</dd>
<dt id="pipeline.expression.mergedStringtieTPMs.featureColumn"><a href="#pipeline.expression.mergedStringtieTPMs.featureColumn">pipeline.expression.mergedStringtieTPMs.featureColumn</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to the -f option of collect-columns.
</dd>
<dt id="pipeline.expression.mergedStringtieTPMs.separator"><a href="#pipeline.expression.mergedStringtieTPMs.separator">pipeline.expression.mergedStringtieTPMs.separator</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to the -s option of collect-columns.
</dd>
<dt id="pipeline.expression.mergeStringtieGtf.keepMergedTranscriptsWithRetainedIntrons"><a href="#pipeline.expression.mergeStringtieGtf.keepMergedTranscriptsWithRetainedIntrons">pipeline.expression.mergeStringtieGtf.keepMergedTranscriptsWithRetainedIntrons</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to the -i flag of 'stringtie --merge'.
</dd>
<dt id="pipeline.expression.mergeStringtieGtf.label"><a href="#pipeline.expression.mergeStringtieGtf.label">pipeline.expression.mergeStringtieGtf.label</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to the -l option of 'stringtie --merge'.
</dd>
<dt id="pipeline.expression.mergeStringtieGtf.memory"><a href="#pipeline.expression.mergeStringtieGtf.memory">pipeline.expression.mergeStringtieGtf.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"10G"</code><br />
    The amount of memory needed for this task in GB.
</dd>
<dt id="pipeline.expression.mergeStringtieGtf.minimumCoverage"><a href="#pipeline.expression.mergeStringtieGtf.minimumCoverage">pipeline.expression.mergeStringtieGtf.minimumCoverage</a></dt>
<dd>
    <i>Float? </i><br />
    Equivalent to the -c option of 'stringtie --merge'.
</dd>
<dt id="pipeline.expression.mergeStringtieGtf.minimumFPKM"><a href="#pipeline.expression.mergeStringtieGtf.minimumFPKM">pipeline.expression.mergeStringtieGtf.minimumFPKM</a></dt>
<dd>
    <i>Float? </i><br />
    Equivalent to the -F option of 'stringtie --merge'.
</dd>
<dt id="pipeline.expression.mergeStringtieGtf.minimumIsoformFraction"><a href="#pipeline.expression.mergeStringtieGtf.minimumIsoformFraction">pipeline.expression.mergeStringtieGtf.minimumIsoformFraction</a></dt>
<dd>
    <i>Float? </i><br />
    Equivalent to the -f option of 'stringtie --merge'.
</dd>
<dt id="pipeline.expression.mergeStringtieGtf.minimumLength"><a href="#pipeline.expression.mergeStringtieGtf.minimumLength">pipeline.expression.mergeStringtieGtf.minimumLength</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to the -m option of 'stringtie --merge'.
</dd>
<dt id="pipeline.expression.mergeStringtieGtf.minimumTPM"><a href="#pipeline.expression.mergeStringtieGtf.minimumTPM">pipeline.expression.mergeStringtieGtf.minimumTPM</a></dt>
<dd>
    <i>Float? </i><br />
    Equivalent to the -T option of 'stringtie --merge'.
</dd>
<dt id="pipeline.expression.stringtie.memory"><a href="#pipeline.expression.stringtie.memory">pipeline.expression.stringtie.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"10G"</code><br />
    The amount of memory needed for this task in GB.
</dd>
<dt id="pipeline.expression.stringtie.threads"><a href="#pipeline.expression.stringtie.threads">pipeline.expression.stringtie.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of threads to use.
</dd>
<dt id="pipeline.expression.stringtieAssembly.memory"><a href="#pipeline.expression.stringtieAssembly.memory">pipeline.expression.stringtieAssembly.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"10G"</code><br />
    The amount of memory needed for this task in GB.
</dd>
<dt id="pipeline.expression.stringtieAssembly.threads"><a href="#pipeline.expression.stringtieAssembly.threads">pipeline.expression.stringtieAssembly.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of threads to use.
</dd>
<dt id="pipeline.GffCompare.A"><a href="#pipeline.GffCompare.A">pipeline.GffCompare.A</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to gffcompare's `-A` flag.
</dd>
<dt id="pipeline.GffCompare.C"><a href="#pipeline.GffCompare.C">pipeline.GffCompare.C</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to gffcompare's `-C` flag.
</dd>
<dt id="pipeline.GffCompare.debugMode"><a href="#pipeline.GffCompare.debugMode">pipeline.GffCompare.debugMode</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to gffcompare's `-D` flag.
</dd>
<dt id="pipeline.GffCompare.discardSingleExonReferenceTranscripts"><a href="#pipeline.GffCompare.discardSingleExonReferenceTranscripts">pipeline.GffCompare.discardSingleExonReferenceTranscripts</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to gffcompare's `-N` flag.
</dd>
<dt id="pipeline.GffCompare.discardSingleExonTransfragsAndReferenceTranscripts"><a href="#pipeline.GffCompare.discardSingleExonTransfragsAndReferenceTranscripts">pipeline.GffCompare.discardSingleExonTransfragsAndReferenceTranscripts</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to gffcompare's `-M` flag.
</dd>
<dt id="pipeline.GffCompare.genomeSequences"><a href="#pipeline.GffCompare.genomeSequences">pipeline.GffCompare.genomeSequences</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to gffcompare's `-s` option.
</dd>
<dt id="pipeline.GffCompare.inputGtfList"><a href="#pipeline.GffCompare.inputGtfList">pipeline.GffCompare.inputGtfList</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to gffcompare's `-i` option.
</dd>
<dt id="pipeline.GffCompare.K"><a href="#pipeline.GffCompare.K">pipeline.GffCompare.K</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to gffcompare's `-K` flag.
</dd>
<dt id="pipeline.GffCompare.maxDistanceFreeEndsTerminalExons"><a href="#pipeline.GffCompare.maxDistanceFreeEndsTerminalExons">pipeline.GffCompare.maxDistanceFreeEndsTerminalExons</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to gffcompare's `-e` option.
</dd>
<dt id="pipeline.GffCompare.maxDistanceGroupingTranscriptStartSites"><a href="#pipeline.GffCompare.maxDistanceGroupingTranscriptStartSites">pipeline.GffCompare.maxDistanceGroupingTranscriptStartSites</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to gffcompare's `-d` option.
</dd>
<dt id="pipeline.GffCompare.namePrefix"><a href="#pipeline.GffCompare.namePrefix">pipeline.GffCompare.namePrefix</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to gffcompare's `-p` option.
</dd>
<dt id="pipeline.GffCompare.noTmap"><a href="#pipeline.GffCompare.noTmap">pipeline.GffCompare.noTmap</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to gffcompare's `-T` flag.
</dd>
<dt id="pipeline.GffCompare.outPrefix"><a href="#pipeline.GffCompare.outPrefix">pipeline.GffCompare.outPrefix</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"gffcmp"</code><br />
    The prefix for the output.
</dd>
<dt id="pipeline.GffCompare.precisionCorrection"><a href="#pipeline.GffCompare.precisionCorrection">pipeline.GffCompare.precisionCorrection</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to gffcompare's `-Q` flag.
</dd>
<dt id="pipeline.GffCompare.snCorrection"><a href="#pipeline.GffCompare.snCorrection">pipeline.GffCompare.snCorrection</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to gffcompare's `-R` flag.
</dd>
<dt id="pipeline.GffCompare.verbose"><a href="#pipeline.GffCompare.verbose">pipeline.GffCompare.verbose</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to gffcompare's `-V` flag.
</dd>
<dt id="pipeline.GffCompare.X"><a href="#pipeline.GffCompare.X">pipeline.GffCompare.X</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to gffcompare's `-X` flag.
</dd>
<dt id="pipeline.gffread.CDSFastaPath"><a href="#pipeline.gffread.CDSFastaPath">pipeline.gffread.CDSFastaPath</a></dt>
<dd>
    <i>String? </i><br />
    The location the CDS fasta should be written to.
</dd>
<dt id="pipeline.gffread.filteredGffPath"><a href="#pipeline.gffread.filteredGffPath">pipeline.gffread.filteredGffPath</a></dt>
<dd>
    <i>String? </i><br />
    The location the filtered GFF should be written to.
</dd>
<dt id="pipeline.gffread.outputGtfFormat"><a href="#pipeline.gffread.outputGtfFormat">pipeline.gffread.outputGtfFormat</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to gffread's `-T` flag.
</dd>
<dt id="pipeline.gffread.proteinFastaPath"><a href="#pipeline.gffread.proteinFastaPath">pipeline.gffread.proteinFastaPath</a></dt>
<dd>
    <i>String? </i><br />
    The location the protein fasta should be written to.
</dd>
<dt id="pipeline.multiqcTask.clConfig"><a href="#pipeline.multiqcTask.clConfig">pipeline.multiqcTask.clConfig</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--cl-config` option.
</dd>
<dt id="pipeline.multiqcTask.comment"><a href="#pipeline.multiqcTask.comment">pipeline.multiqcTask.comment</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--comment` option.
</dd>
<dt id="pipeline.multiqcTask.config"><a href="#pipeline.multiqcTask.config">pipeline.multiqcTask.config</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to MultiQC's `--config` option.
</dd>
<dt id="pipeline.multiqcTask.dataDir"><a href="#pipeline.multiqcTask.dataDir">pipeline.multiqcTask.dataDir</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--data-dir` flag.
</dd>
<dt id="pipeline.multiqcTask.dataFormat"><a href="#pipeline.multiqcTask.dataFormat">pipeline.multiqcTask.dataFormat</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--data-format` option.
</dd>
<dt id="pipeline.multiqcTask.dirs"><a href="#pipeline.multiqcTask.dirs">pipeline.multiqcTask.dirs</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--dirs` flag.
</dd>
<dt id="pipeline.multiqcTask.dirsDepth"><a href="#pipeline.multiqcTask.dirsDepth">pipeline.multiqcTask.dirsDepth</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to MultiQC's `--dirs-depth` option.
</dd>
<dt id="pipeline.multiqcTask.exclude"><a href="#pipeline.multiqcTask.exclude">pipeline.multiqcTask.exclude</a></dt>
<dd>
    <i>Array[String]+? </i><br />
    Equivalent to MultiQC's `--exclude` option.
</dd>
<dt id="pipeline.multiqcTask.export"><a href="#pipeline.multiqcTask.export">pipeline.multiqcTask.export</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--export` flag.
</dd>
<dt id="pipeline.multiqcTask.fileList"><a href="#pipeline.multiqcTask.fileList">pipeline.multiqcTask.fileList</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to MultiQC's `--file-list` option.
</dd>
<dt id="pipeline.multiqcTask.fileName"><a href="#pipeline.multiqcTask.fileName">pipeline.multiqcTask.fileName</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--filename` option.
</dd>
<dt id="pipeline.multiqcTask.flat"><a href="#pipeline.multiqcTask.flat">pipeline.multiqcTask.flat</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--flat` flag.
</dd>
<dt id="pipeline.multiqcTask.force"><a href="#pipeline.multiqcTask.force">pipeline.multiqcTask.force</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--force` flag.
</dd>
<dt id="pipeline.multiqcTask.fullNames"><a href="#pipeline.multiqcTask.fullNames">pipeline.multiqcTask.fullNames</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--fullnames` flag.
</dd>
<dt id="pipeline.multiqcTask.ignore"><a href="#pipeline.multiqcTask.ignore">pipeline.multiqcTask.ignore</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--ignore` option.
</dd>
<dt id="pipeline.multiqcTask.ignoreSamples"><a href="#pipeline.multiqcTask.ignoreSamples">pipeline.multiqcTask.ignoreSamples</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--ignore-samples` option.
</dd>
<dt id="pipeline.multiqcTask.ignoreSymlinks"><a href="#pipeline.multiqcTask.ignoreSymlinks">pipeline.multiqcTask.ignoreSymlinks</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--ignore-symlinks` flag.
</dd>
<dt id="pipeline.multiqcTask.interactive"><a href="#pipeline.multiqcTask.interactive">pipeline.multiqcTask.interactive</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to MultiQC's `--interactive` flag.
</dd>
<dt id="pipeline.multiqcTask.lint"><a href="#pipeline.multiqcTask.lint">pipeline.multiqcTask.lint</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--lint` flag.
</dd>
<dt id="pipeline.multiqcTask.megaQCUpload"><a href="#pipeline.multiqcTask.megaQCUpload">pipeline.multiqcTask.megaQCUpload</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Opposite to MultiQC's `--no-megaqc-upload` flag.
</dd>
<dt id="pipeline.multiqcTask.memory"><a href="#pipeline.multiqcTask.memory">pipeline.multiqcTask.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="pipeline.multiqcTask.module"><a href="#pipeline.multiqcTask.module">pipeline.multiqcTask.module</a></dt>
<dd>
    <i>Array[String]+? </i><br />
    Equivalent to MultiQC's `--module` option.
</dd>
<dt id="pipeline.multiqcTask.noDataDir"><a href="#pipeline.multiqcTask.noDataDir">pipeline.multiqcTask.noDataDir</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--no-data-dir` flag.
</dd>
<dt id="pipeline.multiqcTask.pdf"><a href="#pipeline.multiqcTask.pdf">pipeline.multiqcTask.pdf</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--pdf` flag.
</dd>
<dt id="pipeline.multiqcTask.sampleNames"><a href="#pipeline.multiqcTask.sampleNames">pipeline.multiqcTask.sampleNames</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to MultiQC's `--sample-names` option.
</dd>
<dt id="pipeline.multiqcTask.tag"><a href="#pipeline.multiqcTask.tag">pipeline.multiqcTask.tag</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--tag` option.
</dd>
<dt id="pipeline.multiqcTask.template"><a href="#pipeline.multiqcTask.template">pipeline.multiqcTask.template</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--template` option.
</dd>
<dt id="pipeline.multiqcTask.title"><a href="#pipeline.multiqcTask.title">pipeline.multiqcTask.title</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--title` option.
</dd>
<dt id="pipeline.multiqcTask.zipDataDir"><a href="#pipeline.multiqcTask.zipDataDir">pipeline.multiqcTask.zipDataDir</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--zip-data-dir` flag.
</dd>
<dt id="pipeline.preprocessing.applyBqsr.javaXmx"><a href="#pipeline.preprocessing.applyBqsr.javaXmx">pipeline.preprocessing.applyBqsr.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="pipeline.preprocessing.applyBqsr.memory"><a href="#pipeline.preprocessing.applyBqsr.memory">pipeline.preprocessing.applyBqsr.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="pipeline.preprocessing.baseRecalibrator.javaXmx"><a href="#pipeline.preprocessing.baseRecalibrator.javaXmx">pipeline.preprocessing.baseRecalibrator.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="pipeline.preprocessing.baseRecalibrator.knownIndelsSitesVCFIndexes"><a href="#pipeline.preprocessing.baseRecalibrator.knownIndelsSitesVCFIndexes">pipeline.preprocessing.baseRecalibrator.knownIndelsSitesVCFIndexes</a></dt>
<dd>
    <i>Array[File] </i><i>&mdash; Default:</i> <code>[]</code><br />
    The indexed for the known variant VCFs.
</dd>
<dt id="pipeline.preprocessing.baseRecalibrator.knownIndelsSitesVCFs"><a href="#pipeline.preprocessing.baseRecalibrator.knownIndelsSitesVCFs">pipeline.preprocessing.baseRecalibrator.knownIndelsSitesVCFs</a></dt>
<dd>
    <i>Array[File] </i><i>&mdash; Default:</i> <code>[]</code><br />
    VCF files with known indels.
</dd>
<dt id="pipeline.preprocessing.baseRecalibrator.memory"><a href="#pipeline.preprocessing.baseRecalibrator.memory">pipeline.preprocessing.baseRecalibrator.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="pipeline.preprocessing.gatherBamFiles.javaXmx"><a href="#pipeline.preprocessing.gatherBamFiles.javaXmx">pipeline.preprocessing.gatherBamFiles.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="pipeline.preprocessing.gatherBamFiles.memory"><a href="#pipeline.preprocessing.gatherBamFiles.memory">pipeline.preprocessing.gatherBamFiles.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="pipeline.preprocessing.gatherBqsr.javaXmx"><a href="#pipeline.preprocessing.gatherBqsr.javaXmx">pipeline.preprocessing.gatherBqsr.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="pipeline.preprocessing.gatherBqsr.memory"><a href="#pipeline.preprocessing.gatherBqsr.memory">pipeline.preprocessing.gatherBqsr.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="pipeline.preprocessing.orderedScatters.dockerImage"><a href="#pipeline.preprocessing.orderedScatters.dockerImage">pipeline.preprocessing.orderedScatters.dockerImage</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"python:3.7-slim"</code><br />
    The docker image used for this task. Changing this may result in errors which the developers may choose not to address.
</dd>
<dt id="pipeline.preprocessing.scatterList.bamFile"><a href="#pipeline.preprocessing.scatterList.bamFile">pipeline.preprocessing.scatterList.bamFile</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to biopet scatterregions' `--bamfile` option.
</dd>
<dt id="pipeline.preprocessing.scatterList.bamIndex"><a href="#pipeline.preprocessing.scatterList.bamIndex">pipeline.preprocessing.scatterList.bamIndex</a></dt>
<dd>
    <i>File? </i><br />
    The index for the bamfile given through bamFile.
</dd>
<dt id="pipeline.preprocessing.scatterList.javaXmx"><a href="#pipeline.preprocessing.scatterList.javaXmx">pipeline.preprocessing.scatterList.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"8G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="pipeline.preprocessing.scatterList.memory"><a href="#pipeline.preprocessing.scatterList.memory">pipeline.preprocessing.scatterList.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"24G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="pipeline.preprocessing.scatterSize"><a href="#pipeline.preprocessing.scatterSize">pipeline.preprocessing.scatterSize</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1000000000</code><br />
    The size of the scattered regions in bases. Scattering is used to speed up certain processes. The genome will be sseperated into multiple chunks (scatters) which will be processed in their own job, allowing for parallel processing. Higher values will result in a lower number of jobs. The optimal value here will depend on the available resources.
</dd>
<dt id="pipeline.preprocessing.splitNCigarReads.javaXmx"><a href="#pipeline.preprocessing.splitNCigarReads.javaXmx">pipeline.preprocessing.splitNCigarReads.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="pipeline.preprocessing.splitNCigarReads.memory"><a href="#pipeline.preprocessing.splitNCigarReads.memory">pipeline.preprocessing.splitNCigarReads.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"16G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="pipeline.runMultiQC"><a href="#pipeline.runMultiQC">pipeline.runMultiQC</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>outputDir != "."</code><br />
    Whether or not MultiQC should be run.
</dd>
<dt id="pipeline.sampleJobs.bamMetrics.ampliconIntervalsLists.javaXmx"><a href="#pipeline.sampleJobs.bamMetrics.ampliconIntervalsLists.javaXmx">pipeline.sampleJobs.bamMetrics.ampliconIntervalsLists.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="pipeline.sampleJobs.bamMetrics.ampliconIntervalsLists.memory"><a href="#pipeline.sampleJobs.bamMetrics.ampliconIntervalsLists.memory">pipeline.sampleJobs.bamMetrics.ampliconIntervalsLists.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="pipeline.sampleJobs.bamMetrics.picardMetrics.collectAlignmentSummaryMetrics"><a href="#pipeline.sampleJobs.bamMetrics.picardMetrics.collectAlignmentSummaryMetrics">pipeline.sampleJobs.bamMetrics.picardMetrics.collectAlignmentSummaryMetrics</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=CollectAlignmentSummaryMetrics` argument.
</dd>
<dt id="pipeline.sampleJobs.bamMetrics.picardMetrics.collectBaseDistributionByCycle"><a href="#pipeline.sampleJobs.bamMetrics.picardMetrics.collectBaseDistributionByCycle">pipeline.sampleJobs.bamMetrics.picardMetrics.collectBaseDistributionByCycle</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=CollectBaseDistributionByCycle` argument.
</dd>
<dt id="pipeline.sampleJobs.bamMetrics.picardMetrics.collectGcBiasMetrics"><a href="#pipeline.sampleJobs.bamMetrics.picardMetrics.collectGcBiasMetrics">pipeline.sampleJobs.bamMetrics.picardMetrics.collectGcBiasMetrics</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=CollectGcBiasMetrics` argument.
</dd>
<dt id="pipeline.sampleJobs.bamMetrics.picardMetrics.collectInsertSizeMetrics"><a href="#pipeline.sampleJobs.bamMetrics.picardMetrics.collectInsertSizeMetrics">pipeline.sampleJobs.bamMetrics.picardMetrics.collectInsertSizeMetrics</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=CollectInsertSizeMetrics` argument.
</dd>
<dt id="pipeline.sampleJobs.bamMetrics.picardMetrics.collectQualityYieldMetrics"><a href="#pipeline.sampleJobs.bamMetrics.picardMetrics.collectQualityYieldMetrics">pipeline.sampleJobs.bamMetrics.picardMetrics.collectQualityYieldMetrics</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=CollectQualityYieldMetrics` argument.
</dd>
<dt id="pipeline.sampleJobs.bamMetrics.picardMetrics.collectSequencingArtifactMetrics"><a href="#pipeline.sampleJobs.bamMetrics.picardMetrics.collectSequencingArtifactMetrics">pipeline.sampleJobs.bamMetrics.picardMetrics.collectSequencingArtifactMetrics</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=CollectSequencingArtifactMetrics` argument.
</dd>
<dt id="pipeline.sampleJobs.bamMetrics.picardMetrics.javaXmx"><a href="#pipeline.sampleJobs.bamMetrics.picardMetrics.javaXmx">pipeline.sampleJobs.bamMetrics.picardMetrics.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"8G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="pipeline.sampleJobs.bamMetrics.picardMetrics.meanQualityByCycle"><a href="#pipeline.sampleJobs.bamMetrics.picardMetrics.meanQualityByCycle">pipeline.sampleJobs.bamMetrics.picardMetrics.meanQualityByCycle</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=MeanQualityByCycle` argument.
</dd>
<dt id="pipeline.sampleJobs.bamMetrics.picardMetrics.memory"><a href="#pipeline.sampleJobs.bamMetrics.picardMetrics.memory">pipeline.sampleJobs.bamMetrics.picardMetrics.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"32G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="pipeline.sampleJobs.bamMetrics.picardMetrics.qualityScoreDistribution"><a href="#pipeline.sampleJobs.bamMetrics.picardMetrics.qualityScoreDistribution">pipeline.sampleJobs.bamMetrics.picardMetrics.qualityScoreDistribution</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=QualityScoreDistribution` argument.
</dd>
<dt id="pipeline.sampleJobs.bamMetrics.rnaSeqMetrics.javaXmx"><a href="#pipeline.sampleJobs.bamMetrics.rnaSeqMetrics.javaXmx">pipeline.sampleJobs.bamMetrics.rnaSeqMetrics.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"8G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="pipeline.sampleJobs.bamMetrics.rnaSeqMetrics.memory"><a href="#pipeline.sampleJobs.bamMetrics.rnaSeqMetrics.memory">pipeline.sampleJobs.bamMetrics.rnaSeqMetrics.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"32G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="pipeline.sampleJobs.bamMetrics.targetIntervalsLists.javaXmx"><a href="#pipeline.sampleJobs.bamMetrics.targetIntervalsLists.javaXmx">pipeline.sampleJobs.bamMetrics.targetIntervalsLists.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="pipeline.sampleJobs.bamMetrics.targetIntervalsLists.memory"><a href="#pipeline.sampleJobs.bamMetrics.targetIntervalsLists.memory">pipeline.sampleJobs.bamMetrics.targetIntervalsLists.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="pipeline.sampleJobs.bamMetrics.targetMetrics.javaXmx"><a href="#pipeline.sampleJobs.bamMetrics.targetMetrics.javaXmx">pipeline.sampleJobs.bamMetrics.targetMetrics.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="pipeline.sampleJobs.bamMetrics.targetMetrics.memory"><a href="#pipeline.sampleJobs.bamMetrics.targetMetrics.memory">pipeline.sampleJobs.bamMetrics.targetMetrics.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="pipeline.sampleJobs.hisat2.downstreamTranscriptomeAssembly"><a href="#pipeline.sampleJobs.hisat2.downstreamTranscriptomeAssembly">pipeline.sampleJobs.hisat2.downstreamTranscriptomeAssembly</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to hisat2's `--dta` flag.
</dd>
<dt id="pipeline.sampleJobs.hisat2.memory"><a href="#pipeline.sampleJobs.hisat2.memory">pipeline.sampleJobs.hisat2.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"48G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="pipeline.sampleJobs.hisat2.threads"><a href="#pipeline.sampleJobs.hisat2.threads">pipeline.sampleJobs.hisat2.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of threads to use.
</dd>
<dt id="pipeline.sampleJobs.indexStarBam.dockerImage"><a href="#pipeline.sampleJobs.indexStarBam.dockerImage">pipeline.sampleJobs.indexStarBam.dockerImage</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"quay.io/biocontainers/samtools:1.8--h46bd0b3_5"</code><br />
    The docker image used for this task. Changing this may result in errors which the developers may choose not to address.
</dd>
<dt id="pipeline.sampleJobs.markDuplicates.javaXmx"><a href="#pipeline.sampleJobs.markDuplicates.javaXmx">pipeline.sampleJobs.markDuplicates.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"8G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="pipeline.sampleJobs.markDuplicates.memory"><a href="#pipeline.sampleJobs.markDuplicates.memory">pipeline.sampleJobs.markDuplicates.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"24G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="pipeline.sampleJobs.markDuplicates.read_name_regex"><a href="#pipeline.sampleJobs.markDuplicates.read_name_regex">pipeline.sampleJobs.markDuplicates.read_name_regex</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to the `READ_NAME_REGEX` option of MarkDuplicates.
</dd>
<dt id="pipeline.sampleJobs.platform"><a href="#pipeline.sampleJobs.platform">pipeline.sampleJobs.platform</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"illumina"</code><br />
    The platform used for sequencing.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.bwa"><a href="#pipeline.sampleJobs.qc.Cutadapt.bwa">pipeline.sampleJobs.qc.Cutadapt.bwa</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --bwa flag.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.colorspace"><a href="#pipeline.sampleJobs.qc.Cutadapt.colorspace">pipeline.sampleJobs.qc.Cutadapt.colorspace</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --colorspace flag.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.cores"><a href="#pipeline.sampleJobs.qc.Cutadapt.cores">pipeline.sampleJobs.qc.Cutadapt.cores</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of cores to use.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.cut"><a href="#pipeline.sampleJobs.qc.Cutadapt.cut">pipeline.sampleJobs.qc.Cutadapt.cut</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to cutadapt's --cut option.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.discardTrimmed"><a href="#pipeline.sampleJobs.qc.Cutadapt.discardTrimmed">pipeline.sampleJobs.qc.Cutadapt.discardTrimmed</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --quality-cutoff option.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.discardUntrimmed"><a href="#pipeline.sampleJobs.qc.Cutadapt.discardUntrimmed">pipeline.sampleJobs.qc.Cutadapt.discardUntrimmed</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --discard-untrimmed option.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.doubleEncode"><a href="#pipeline.sampleJobs.qc.Cutadapt.doubleEncode">pipeline.sampleJobs.qc.Cutadapt.doubleEncode</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --double-encode flag.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.errorRate"><a href="#pipeline.sampleJobs.qc.Cutadapt.errorRate">pipeline.sampleJobs.qc.Cutadapt.errorRate</a></dt>
<dd>
    <i>Float? </i><br />
    Equivalent to cutadapt's --error-rate option.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.front"><a href="#pipeline.sampleJobs.qc.Cutadapt.front">pipeline.sampleJobs.qc.Cutadapt.front</a></dt>
<dd>
    <i>Array[String] </i><i>&mdash; Default:</i> <code>[]</code><br />
    A list of 5' ligated adapter sequences to be cut from the given first or single end fastq file.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.frontRead2"><a href="#pipeline.sampleJobs.qc.Cutadapt.frontRead2">pipeline.sampleJobs.qc.Cutadapt.frontRead2</a></dt>
<dd>
    <i>Array[String] </i><i>&mdash; Default:</i> <code>[]</code><br />
    A list of 5' ligated adapter sequences to be cut from the given second end fastq file.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.infoFilePath"><a href="#pipeline.sampleJobs.qc.Cutadapt.infoFilePath">pipeline.sampleJobs.qc.Cutadapt.infoFilePath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --info-file option.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.interleaved"><a href="#pipeline.sampleJobs.qc.Cutadapt.interleaved">pipeline.sampleJobs.qc.Cutadapt.interleaved</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --interleaved flag.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.length"><a href="#pipeline.sampleJobs.qc.Cutadapt.length">pipeline.sampleJobs.qc.Cutadapt.length</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to cutadapt's --length option.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.lengthTag"><a href="#pipeline.sampleJobs.qc.Cutadapt.lengthTag">pipeline.sampleJobs.qc.Cutadapt.lengthTag</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --length-tag option.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.maq"><a href="#pipeline.sampleJobs.qc.Cutadapt.maq">pipeline.sampleJobs.qc.Cutadapt.maq</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --maq flag.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.maskAdapter"><a href="#pipeline.sampleJobs.qc.Cutadapt.maskAdapter">pipeline.sampleJobs.qc.Cutadapt.maskAdapter</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --mask-adapter flag.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.matchReadWildcards"><a href="#pipeline.sampleJobs.qc.Cutadapt.matchReadWildcards">pipeline.sampleJobs.qc.Cutadapt.matchReadWildcards</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --match-read-wildcards flag.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.maximumLength"><a href="#pipeline.sampleJobs.qc.Cutadapt.maximumLength">pipeline.sampleJobs.qc.Cutadapt.maximumLength</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to cutadapt's --maximum-length option.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.maxN"><a href="#pipeline.sampleJobs.qc.Cutadapt.maxN">pipeline.sampleJobs.qc.Cutadapt.maxN</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to cutadapt's --max-n option.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.memory"><a href="#pipeline.sampleJobs.qc.Cutadapt.memory">pipeline.sampleJobs.qc.Cutadapt.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.minimumLength"><a href="#pipeline.sampleJobs.qc.Cutadapt.minimumLength">pipeline.sampleJobs.qc.Cutadapt.minimumLength</a></dt>
<dd>
    <i>Int? </i><i>&mdash; Default:</i> <code>2</code><br />
    Equivalent to cutadapt's --minimum-length option.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.nextseqTrim"><a href="#pipeline.sampleJobs.qc.Cutadapt.nextseqTrim">pipeline.sampleJobs.qc.Cutadapt.nextseqTrim</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --nextseq-trim option.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.noIndels"><a href="#pipeline.sampleJobs.qc.Cutadapt.noIndels">pipeline.sampleJobs.qc.Cutadapt.noIndels</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --no-indels flag.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.noMatchAdapterWildcards"><a href="#pipeline.sampleJobs.qc.Cutadapt.noMatchAdapterWildcards">pipeline.sampleJobs.qc.Cutadapt.noMatchAdapterWildcards</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --no-match-adapter-wildcards flag.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.noTrim"><a href="#pipeline.sampleJobs.qc.Cutadapt.noTrim">pipeline.sampleJobs.qc.Cutadapt.noTrim</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --no-trim flag.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.noZeroCap"><a href="#pipeline.sampleJobs.qc.Cutadapt.noZeroCap">pipeline.sampleJobs.qc.Cutadapt.noZeroCap</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --no-zero-cap flag.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.overlap"><a href="#pipeline.sampleJobs.qc.Cutadapt.overlap">pipeline.sampleJobs.qc.Cutadapt.overlap</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to cutadapt's --overlap option.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.pairFilter"><a href="#pipeline.sampleJobs.qc.Cutadapt.pairFilter">pipeline.sampleJobs.qc.Cutadapt.pairFilter</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --pair-filter option.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.prefix"><a href="#pipeline.sampleJobs.qc.Cutadapt.prefix">pipeline.sampleJobs.qc.Cutadapt.prefix</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --prefix option.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.qualityBase"><a href="#pipeline.sampleJobs.qc.Cutadapt.qualityBase">pipeline.sampleJobs.qc.Cutadapt.qualityBase</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to cutadapt's --quality-base option.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.qualityCutoff"><a href="#pipeline.sampleJobs.qc.Cutadapt.qualityCutoff">pipeline.sampleJobs.qc.Cutadapt.qualityCutoff</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --quality-cutoff option.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.restFilePath"><a href="#pipeline.sampleJobs.qc.Cutadapt.restFilePath">pipeline.sampleJobs.qc.Cutadapt.restFilePath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --rest-file option.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.stripF3"><a href="#pipeline.sampleJobs.qc.Cutadapt.stripF3">pipeline.sampleJobs.qc.Cutadapt.stripF3</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --strip-f3 flag.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.stripSuffix"><a href="#pipeline.sampleJobs.qc.Cutadapt.stripSuffix">pipeline.sampleJobs.qc.Cutadapt.stripSuffix</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --strip-suffix option.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.suffix"><a href="#pipeline.sampleJobs.qc.Cutadapt.suffix">pipeline.sampleJobs.qc.Cutadapt.suffix</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --suffix option.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.times"><a href="#pipeline.sampleJobs.qc.Cutadapt.times">pipeline.sampleJobs.qc.Cutadapt.times</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to cutadapt's --times option.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.tooLongOutputPath"><a href="#pipeline.sampleJobs.qc.Cutadapt.tooLongOutputPath">pipeline.sampleJobs.qc.Cutadapt.tooLongOutputPath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --too-long-output option.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.tooLongPairedOutputPath"><a href="#pipeline.sampleJobs.qc.Cutadapt.tooLongPairedOutputPath">pipeline.sampleJobs.qc.Cutadapt.tooLongPairedOutputPath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --too-long-paired-output option.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.tooShortOutputPath"><a href="#pipeline.sampleJobs.qc.Cutadapt.tooShortOutputPath">pipeline.sampleJobs.qc.Cutadapt.tooShortOutputPath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --too-short-output option.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.tooShortPairedOutputPath"><a href="#pipeline.sampleJobs.qc.Cutadapt.tooShortPairedOutputPath">pipeline.sampleJobs.qc.Cutadapt.tooShortPairedOutputPath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --too-short-paired-output option.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.trimN"><a href="#pipeline.sampleJobs.qc.Cutadapt.trimN">pipeline.sampleJobs.qc.Cutadapt.trimN</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --trim-n flag.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.untrimmedOutputPath"><a href="#pipeline.sampleJobs.qc.Cutadapt.untrimmedOutputPath">pipeline.sampleJobs.qc.Cutadapt.untrimmedOutputPath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --untrimmed-output option.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.untrimmedPairedOutputPath"><a href="#pipeline.sampleJobs.qc.Cutadapt.untrimmedPairedOutputPath">pipeline.sampleJobs.qc.Cutadapt.untrimmedPairedOutputPath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --untrimmed-paired-output option.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.wildcardFilePath"><a href="#pipeline.sampleJobs.qc.Cutadapt.wildcardFilePath">pipeline.sampleJobs.qc.Cutadapt.wildcardFilePath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --wildcard-file option.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.Z"><a href="#pipeline.sampleJobs.qc.Cutadapt.Z">pipeline.sampleJobs.qc.Cutadapt.Z</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to cutadapt's -Z flag.
</dd>
<dt id="pipeline.sampleJobs.qc.Cutadapt.zeroCap"><a href="#pipeline.sampleJobs.qc.Cutadapt.zeroCap">pipeline.sampleJobs.qc.Cutadapt.zeroCap</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --zero-cap flag.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead1.adapters"><a href="#pipeline.sampleJobs.qc.FastqcRead1.adapters">pipeline.sampleJobs.qc.FastqcRead1.adapters</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --adapters option.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead1.casava"><a href="#pipeline.sampleJobs.qc.FastqcRead1.casava">pipeline.sampleJobs.qc.FastqcRead1.casava</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --casava flag.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead1.contaminants"><a href="#pipeline.sampleJobs.qc.FastqcRead1.contaminants">pipeline.sampleJobs.qc.FastqcRead1.contaminants</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --contaminants option.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead1.dir"><a href="#pipeline.sampleJobs.qc.FastqcRead1.dir">pipeline.sampleJobs.qc.FastqcRead1.dir</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --dir option.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead1.extract"><a href="#pipeline.sampleJobs.qc.FastqcRead1.extract">pipeline.sampleJobs.qc.FastqcRead1.extract</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --extract flag.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead1.format"><a href="#pipeline.sampleJobs.qc.FastqcRead1.format">pipeline.sampleJobs.qc.FastqcRead1.format</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --format option.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead1.kmers"><a href="#pipeline.sampleJobs.qc.FastqcRead1.kmers">pipeline.sampleJobs.qc.FastqcRead1.kmers</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --kmers option.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead1.limits"><a href="#pipeline.sampleJobs.qc.FastqcRead1.limits">pipeline.sampleJobs.qc.FastqcRead1.limits</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --limits option.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead1.minLength"><a href="#pipeline.sampleJobs.qc.FastqcRead1.minLength">pipeline.sampleJobs.qc.FastqcRead1.minLength</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --min_length option.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead1.nano"><a href="#pipeline.sampleJobs.qc.FastqcRead1.nano">pipeline.sampleJobs.qc.FastqcRead1.nano</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nano flag.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead1.noFilter"><a href="#pipeline.sampleJobs.qc.FastqcRead1.noFilter">pipeline.sampleJobs.qc.FastqcRead1.noFilter</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nofilter flag.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead1.nogroup"><a href="#pipeline.sampleJobs.qc.FastqcRead1.nogroup">pipeline.sampleJobs.qc.FastqcRead1.nogroup</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nogroup flag.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead1.threads"><a href="#pipeline.sampleJobs.qc.FastqcRead1.threads">pipeline.sampleJobs.qc.FastqcRead1.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of cores to use.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead1After.adapters"><a href="#pipeline.sampleJobs.qc.FastqcRead1After.adapters">pipeline.sampleJobs.qc.FastqcRead1After.adapters</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --adapters option.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead1After.casava"><a href="#pipeline.sampleJobs.qc.FastqcRead1After.casava">pipeline.sampleJobs.qc.FastqcRead1After.casava</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --casava flag.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead1After.contaminants"><a href="#pipeline.sampleJobs.qc.FastqcRead1After.contaminants">pipeline.sampleJobs.qc.FastqcRead1After.contaminants</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --contaminants option.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead1After.dir"><a href="#pipeline.sampleJobs.qc.FastqcRead1After.dir">pipeline.sampleJobs.qc.FastqcRead1After.dir</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --dir option.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead1After.extract"><a href="#pipeline.sampleJobs.qc.FastqcRead1After.extract">pipeline.sampleJobs.qc.FastqcRead1After.extract</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --extract flag.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead1After.format"><a href="#pipeline.sampleJobs.qc.FastqcRead1After.format">pipeline.sampleJobs.qc.FastqcRead1After.format</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --format option.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead1After.kmers"><a href="#pipeline.sampleJobs.qc.FastqcRead1After.kmers">pipeline.sampleJobs.qc.FastqcRead1After.kmers</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --kmers option.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead1After.limits"><a href="#pipeline.sampleJobs.qc.FastqcRead1After.limits">pipeline.sampleJobs.qc.FastqcRead1After.limits</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --limits option.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead1After.minLength"><a href="#pipeline.sampleJobs.qc.FastqcRead1After.minLength">pipeline.sampleJobs.qc.FastqcRead1After.minLength</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --min_length option.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead1After.nano"><a href="#pipeline.sampleJobs.qc.FastqcRead1After.nano">pipeline.sampleJobs.qc.FastqcRead1After.nano</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nano flag.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead1After.noFilter"><a href="#pipeline.sampleJobs.qc.FastqcRead1After.noFilter">pipeline.sampleJobs.qc.FastqcRead1After.noFilter</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nofilter flag.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead1After.nogroup"><a href="#pipeline.sampleJobs.qc.FastqcRead1After.nogroup">pipeline.sampleJobs.qc.FastqcRead1After.nogroup</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nogroup flag.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead1After.threads"><a href="#pipeline.sampleJobs.qc.FastqcRead1After.threads">pipeline.sampleJobs.qc.FastqcRead1After.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of cores to use.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead2.adapters"><a href="#pipeline.sampleJobs.qc.FastqcRead2.adapters">pipeline.sampleJobs.qc.FastqcRead2.adapters</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --adapters option.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead2.casava"><a href="#pipeline.sampleJobs.qc.FastqcRead2.casava">pipeline.sampleJobs.qc.FastqcRead2.casava</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --casava flag.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead2.contaminants"><a href="#pipeline.sampleJobs.qc.FastqcRead2.contaminants">pipeline.sampleJobs.qc.FastqcRead2.contaminants</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --contaminants option.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead2.dir"><a href="#pipeline.sampleJobs.qc.FastqcRead2.dir">pipeline.sampleJobs.qc.FastqcRead2.dir</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --dir option.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead2.extract"><a href="#pipeline.sampleJobs.qc.FastqcRead2.extract">pipeline.sampleJobs.qc.FastqcRead2.extract</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --extract flag.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead2.format"><a href="#pipeline.sampleJobs.qc.FastqcRead2.format">pipeline.sampleJobs.qc.FastqcRead2.format</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --format option.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead2.kmers"><a href="#pipeline.sampleJobs.qc.FastqcRead2.kmers">pipeline.sampleJobs.qc.FastqcRead2.kmers</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --kmers option.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead2.limits"><a href="#pipeline.sampleJobs.qc.FastqcRead2.limits">pipeline.sampleJobs.qc.FastqcRead2.limits</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --limits option.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead2.minLength"><a href="#pipeline.sampleJobs.qc.FastqcRead2.minLength">pipeline.sampleJobs.qc.FastqcRead2.minLength</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --min_length option.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead2.nano"><a href="#pipeline.sampleJobs.qc.FastqcRead2.nano">pipeline.sampleJobs.qc.FastqcRead2.nano</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nano flag.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead2.noFilter"><a href="#pipeline.sampleJobs.qc.FastqcRead2.noFilter">pipeline.sampleJobs.qc.FastqcRead2.noFilter</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nofilter flag.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead2.nogroup"><a href="#pipeline.sampleJobs.qc.FastqcRead2.nogroup">pipeline.sampleJobs.qc.FastqcRead2.nogroup</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nogroup flag.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead2.threads"><a href="#pipeline.sampleJobs.qc.FastqcRead2.threads">pipeline.sampleJobs.qc.FastqcRead2.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of cores to use.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead2After.adapters"><a href="#pipeline.sampleJobs.qc.FastqcRead2After.adapters">pipeline.sampleJobs.qc.FastqcRead2After.adapters</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --adapters option.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead2After.casava"><a href="#pipeline.sampleJobs.qc.FastqcRead2After.casava">pipeline.sampleJobs.qc.FastqcRead2After.casava</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --casava flag.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead2After.contaminants"><a href="#pipeline.sampleJobs.qc.FastqcRead2After.contaminants">pipeline.sampleJobs.qc.FastqcRead2After.contaminants</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --contaminants option.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead2After.dir"><a href="#pipeline.sampleJobs.qc.FastqcRead2After.dir">pipeline.sampleJobs.qc.FastqcRead2After.dir</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --dir option.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead2After.extract"><a href="#pipeline.sampleJobs.qc.FastqcRead2After.extract">pipeline.sampleJobs.qc.FastqcRead2After.extract</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --extract flag.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead2After.format"><a href="#pipeline.sampleJobs.qc.FastqcRead2After.format">pipeline.sampleJobs.qc.FastqcRead2After.format</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --format option.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead2After.kmers"><a href="#pipeline.sampleJobs.qc.FastqcRead2After.kmers">pipeline.sampleJobs.qc.FastqcRead2After.kmers</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --kmers option.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead2After.limits"><a href="#pipeline.sampleJobs.qc.FastqcRead2After.limits">pipeline.sampleJobs.qc.FastqcRead2After.limits</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --limits option.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead2After.minLength"><a href="#pipeline.sampleJobs.qc.FastqcRead2After.minLength">pipeline.sampleJobs.qc.FastqcRead2After.minLength</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --min_length option.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead2After.nano"><a href="#pipeline.sampleJobs.qc.FastqcRead2After.nano">pipeline.sampleJobs.qc.FastqcRead2After.nano</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nano flag.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead2After.noFilter"><a href="#pipeline.sampleJobs.qc.FastqcRead2After.noFilter">pipeline.sampleJobs.qc.FastqcRead2After.noFilter</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nofilter flag.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead2After.nogroup"><a href="#pipeline.sampleJobs.qc.FastqcRead2After.nogroup">pipeline.sampleJobs.qc.FastqcRead2After.nogroup</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nogroup flag.
</dd>
<dt id="pipeline.sampleJobs.qc.FastqcRead2After.threads"><a href="#pipeline.sampleJobs.qc.FastqcRead2After.threads">pipeline.sampleJobs.qc.FastqcRead2After.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of cores to use.
</dd>
<dt id="pipeline.sampleJobs.qc.runAdapterClipping"><a href="#pipeline.sampleJobs.qc.runAdapterClipping">pipeline.sampleJobs.qc.runAdapterClipping</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>defined(adapterForward) || defined(adapterReverse) || length(select_first([contaminations, []])) > 0</code><br />
    Whether or not adapters should be removed from the reads.
</dd>
<dt id="pipeline.sampleJobs.star.limitBAMsortRAM"><a href="#pipeline.sampleJobs.star.limitBAMsortRAM">pipeline.sampleJobs.star.limitBAMsortRAM</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to star's `--limitBAMsortRAM` option.
</dd>
<dt id="pipeline.sampleJobs.star.memory"><a href="#pipeline.sampleJobs.star.memory">pipeline.sampleJobs.star.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"48G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="pipeline.sampleJobs.star.outSAMunmapped"><a href="#pipeline.sampleJobs.star.outSAMunmapped">pipeline.sampleJobs.star.outSAMunmapped</a></dt>
<dd>
    <i>String? </i><i>&mdash; Default:</i> <code>"Within KeepPairs"</code><br />
    Equivalent to star's `--outSAMunmapped` option.
</dd>
<dt id="pipeline.sampleJobs.star.outStd"><a href="#pipeline.sampleJobs.star.outStd">pipeline.sampleJobs.star.outStd</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to star's `--outStd` option.
</dd>
<dt id="pipeline.sampleJobs.star.runThreadN"><a href="#pipeline.sampleJobs.star.runThreadN">pipeline.sampleJobs.star.runThreadN</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>4</code><br />
    The number of threads to use.
</dd>
<dt id="pipeline.sampleJobs.star.twopassMode"><a href="#pipeline.sampleJobs.star.twopassMode">pipeline.sampleJobs.star.twopassMode</a></dt>
<dd>
    <i>String? </i><i>&mdash; Default:</i> <code>"Basic"</code><br />
    Equivalent to star's `--twopassMode` option.
</dd>
<dt id="pipeline.variantcalling.callAutosomal.haplotypeCaller.contamination"><a href="#pipeline.variantcalling.callAutosomal.haplotypeCaller.contamination">pipeline.variantcalling.callAutosomal.haplotypeCaller.contamination</a></dt>
<dd>
    <i>Float? </i><br />
    Equivalent to HaplotypeCaller's `-contamination` option.
</dd>
<dt id="pipeline.variantcalling.callAutosomal.haplotypeCaller.javaXmx"><a href="#pipeline.variantcalling.callAutosomal.haplotypeCaller.javaXmx">pipeline.variantcalling.callAutosomal.haplotypeCaller.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="pipeline.variantcalling.callAutosomal.haplotypeCaller.memory"><a href="#pipeline.variantcalling.callAutosomal.haplotypeCaller.memory">pipeline.variantcalling.callAutosomal.haplotypeCaller.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="pipeline.variantcalling.callX.contamination"><a href="#pipeline.variantcalling.callX.contamination">pipeline.variantcalling.callX.contamination</a></dt>
<dd>
    <i>Float? </i><br />
    Equivalent to HaplotypeCaller's `-contamination` option.
</dd>
<dt id="pipeline.variantcalling.callX.javaXmx"><a href="#pipeline.variantcalling.callX.javaXmx">pipeline.variantcalling.callX.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="pipeline.variantcalling.callX.memory"><a href="#pipeline.variantcalling.callX.memory">pipeline.variantcalling.callX.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="pipeline.variantcalling.callY.contamination"><a href="#pipeline.variantcalling.callY.contamination">pipeline.variantcalling.callY.contamination</a></dt>
<dd>
    <i>Float? </i><br />
    Equivalent to HaplotypeCaller's `-contamination` option.
</dd>
<dt id="pipeline.variantcalling.callY.javaXmx"><a href="#pipeline.variantcalling.callY.javaXmx">pipeline.variantcalling.callY.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="pipeline.variantcalling.callY.memory"><a href="#pipeline.variantcalling.callY.memory">pipeline.variantcalling.callY.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="pipeline.variantcalling.gatherGvcfs.intervals"><a href="#pipeline.variantcalling.gatherGvcfs.intervals">pipeline.variantcalling.gatherGvcfs.intervals</a></dt>
<dd>
    <i>Array[File] </i><i>&mdash; Default:</i> <code>[]</code><br />
    Bed files or interval lists describing the regions to operate on.
</dd>
<dt id="pipeline.variantcalling.gatherGvcfs.javaXmx"><a href="#pipeline.variantcalling.gatherGvcfs.javaXmx">pipeline.variantcalling.gatherGvcfs.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"12G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="pipeline.variantcalling.gatherGvcfs.memory"><a href="#pipeline.variantcalling.gatherGvcfs.memory">pipeline.variantcalling.gatherGvcfs.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"24G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="pipeline.variantcalling.gatherVcfs.javaXmx"><a href="#pipeline.variantcalling.gatherVcfs.javaXmx">pipeline.variantcalling.gatherVcfs.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"8G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="pipeline.variantcalling.gatherVcfs.memory"><a href="#pipeline.variantcalling.gatherVcfs.memory">pipeline.variantcalling.gatherVcfs.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"24G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="pipeline.variantcalling.genotypeGvcfs.annotationGroups"><a href="#pipeline.variantcalling.genotypeGvcfs.annotationGroups">pipeline.variantcalling.genotypeGvcfs.annotationGroups</a></dt>
<dd>
    <i>Array[String] </i><i>&mdash; Default:</i> <code>["StandardAnnotation"]</code><br />
    Which annotation groups will be used for the annotation
</dd>
<dt id="pipeline.variantcalling.genotypeGvcfs.javaXmx"><a href="#pipeline.variantcalling.genotypeGvcfs.javaXmx">pipeline.variantcalling.genotypeGvcfs.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"6G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="pipeline.variantcalling.genotypeGvcfs.memory"><a href="#pipeline.variantcalling.genotypeGvcfs.memory">pipeline.variantcalling.genotypeGvcfs.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"18G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="pipeline.variantcalling.mergeBeds.outputBed"><a href="#pipeline.variantcalling.mergeBeds.outputBed">pipeline.variantcalling.mergeBeds.outputBed</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"merged.bed"</code><br />
    The path to write the output to
</dd>
<dt id="pipeline.variantcalling.orderedAllScatters.dockerImage"><a href="#pipeline.variantcalling.orderedAllScatters.dockerImage">pipeline.variantcalling.orderedAllScatters.dockerImage</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"python:3.7-slim"</code><br />
    The docker image used for this task. Changing this may result in errors which the developers may choose not to address.
</dd>
<dt id="pipeline.variantcalling.orderedAutosomalScatters.dockerImage"><a href="#pipeline.variantcalling.orderedAutosomalScatters.dockerImage">pipeline.variantcalling.orderedAutosomalScatters.dockerImage</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"python:3.7-slim"</code><br />
    The docker image used for this task. Changing this may result in errors which the developers may choose not to address.
</dd>
<dt id="pipeline.variantcalling.scatterAllRegions.bamFile"><a href="#pipeline.variantcalling.scatterAllRegions.bamFile">pipeline.variantcalling.scatterAllRegions.bamFile</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to biopet scatterregions' `--bamfile` option.
</dd>
<dt id="pipeline.variantcalling.scatterAllRegions.bamIndex"><a href="#pipeline.variantcalling.scatterAllRegions.bamIndex">pipeline.variantcalling.scatterAllRegions.bamIndex</a></dt>
<dd>
    <i>File? </i><br />
    The index for the bamfile given through bamFile.
</dd>
<dt id="pipeline.variantcalling.scatterAllRegions.javaXmx"><a href="#pipeline.variantcalling.scatterAllRegions.javaXmx">pipeline.variantcalling.scatterAllRegions.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"8G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="pipeline.variantcalling.scatterAllRegions.memory"><a href="#pipeline.variantcalling.scatterAllRegions.memory">pipeline.variantcalling.scatterAllRegions.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"24G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="pipeline.variantcalling.scatterAllRegions.notSplitContigs"><a href="#pipeline.variantcalling.scatterAllRegions.notSplitContigs">pipeline.variantcalling.scatterAllRegions.notSplitContigs</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to biopet scatterregions' `--notSplitContigs` flag.
</dd>
<dt id="pipeline.variantcalling.scatterAutosomalRegions.bamFile"><a href="#pipeline.variantcalling.scatterAutosomalRegions.bamFile">pipeline.variantcalling.scatterAutosomalRegions.bamFile</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to biopet scatterregions' `--bamfile` option.
</dd>
<dt id="pipeline.variantcalling.scatterAutosomalRegions.bamIndex"><a href="#pipeline.variantcalling.scatterAutosomalRegions.bamIndex">pipeline.variantcalling.scatterAutosomalRegions.bamIndex</a></dt>
<dd>
    <i>File? </i><br />
    The index for the bamfile given through bamFile.
</dd>
<dt id="pipeline.variantcalling.scatterAutosomalRegions.javaXmx"><a href="#pipeline.variantcalling.scatterAutosomalRegions.javaXmx">pipeline.variantcalling.scatterAutosomalRegions.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"8G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="pipeline.variantcalling.scatterAutosomalRegions.memory"><a href="#pipeline.variantcalling.scatterAutosomalRegions.memory">pipeline.variantcalling.scatterAutosomalRegions.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"24G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="pipeline.variantcalling.scatterAutosomalRegions.notSplitContigs"><a href="#pipeline.variantcalling.scatterAutosomalRegions.notSplitContigs">pipeline.variantcalling.scatterAutosomalRegions.notSplitContigs</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to biopet scatterregions' `--notSplitContigs` flag.
</dd>
<dt id="pipeline.variantcalling.scatterSize"><a href="#pipeline.variantcalling.scatterSize">pipeline.variantcalling.scatterSize</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1000000000</code><br />
    The size of the scattered regions in bases. Scattering is used to speed up certain processes. The genome will be sseperated into multiple chunks (scatters) which will be processed in their own job, allowing for parallel processing. Higher values will result in a lower number of jobs. The optimal value here will depend on the available resources.
</dd>
</dl>
</details>





## Do not set these inputs!
The following inputs should ***not*** be set, even though womtool may
show them as being available inputs.

* pipeline.sampleJobs.star.outSAMtype
* pipeline.sampleJobs.star.readFilesCommand
* pipeline.sampleJobs.qc.FastqcRead1.NoneFile
* pipeline.sampleJobs.qc.FastqcRead1.NoneArray
* pipeline.sampleJobs.qc.FastqcRead2.NoneFile
* pipeline.sampleJobs.qc.FastqcRead2.NoneArray
* pipeline.sampleJobs.qc.FastqcRead1After.NoneFile
* pipeline.sampleJobs.qc.FastqcRead1After.NoneArray
* pipeline.sampleJobs.qc.FastqcRead2After.NoneFile
* pipeline.sampleJobs.qc.FastqcRead2After.NoneArray
* pipeline.GffCompare.noneFile
* pipeline.multiqcTask.finished
* pipeline.multiqcTask.dependencies
