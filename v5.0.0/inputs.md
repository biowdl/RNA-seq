---
layout: default
title: "Inputs: RNAseq"
---

# Inputs for RNAseq

The following is an overview of all available inputs in
RNAseq.


## Required inputs
<dl>
<dt id="RNAseq.dockerImagesFile"><a href="#RNAseq.dockerImagesFile">RNAseq.dockerImagesFile</a></dt>
<dd>
    <i>File </i><br />
    A YAML file describing the docker image used for the tasks. The dockerImages.yml provided with the pipeline is recommended.
</dd>
<dt id="RNAseq.expression.mergeStringtieGtf.referenceAnnotation"><a href="#RNAseq.expression.mergeStringtieGtf.referenceAnnotation">RNAseq.expression.mergeStringtieGtf.referenceAnnotation</a></dt>
<dd>
    <i>File? </i><br />
    The GTF file to compare with.
</dd>
<dt id="RNAseq.hisat2Index"><a href="#RNAseq.hisat2Index">RNAseq.hisat2Index</a></dt>
<dd>
    <i>Array[File]+? </i><br />
    The hisat2 index files. Defining this will cause the hisat2 aligner to run. Note that is starIndex is also defined the star results will be used for downstream analyses. May be omitted in starIndex is defined.
</dd>
<dt id="RNAseq.outputDir"><a href="#RNAseq.outputDir">RNAseq.outputDir</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"."</code><br />
    The output directory.
</dd>
<dt id="RNAseq.referenceFasta"><a href="#RNAseq.referenceFasta">RNAseq.referenceFasta</a></dt>
<dd>
    <i>File </i><br />
    The reference fasta file.
</dd>
<dt id="RNAseq.referenceFastaDict"><a href="#RNAseq.referenceFastaDict">RNAseq.referenceFastaDict</a></dt>
<dd>
    <i>File </i><br />
    Sequence dictionary (.dict) file of the reference.
</dd>
<dt id="RNAseq.referenceFastaFai"><a href="#RNAseq.referenceFastaFai">RNAseq.referenceFastaFai</a></dt>
<dd>
    <i>File </i><br />
    Fasta index (.fai) file of the reference.
</dd>
<dt id="RNAseq.sampleConfigFile"><a href="#RNAseq.sampleConfigFile">RNAseq.sampleConfigFile</a></dt>
<dd>
    <i>File </i><br />
    The samplesheet, including sample ids, library ids, readgroup ids and fastq file locations.
</dd>
<dt id="RNAseq.starIndex"><a href="#RNAseq.starIndex">RNAseq.starIndex</a></dt>
<dd>
    <i>Array[File]+? </i><br />
    The star index files. Defining this will cause the star aligner to run and be used for downstream analyses. May be ommited if hisat2Index is defined.
</dd>
<dt id="RNAseq.strandedness"><a href="#RNAseq.strandedness">RNAseq.strandedness</a></dt>
<dd>
    <i>String </i><br />
    The strandedness of the RNA sequencing library preparation. One of "None" (unstranded), "FR" (forward-reverse: first read equal transcript) or "RF" (reverse-forward: second read equals transcript).
</dd>
</dl>

## Other common inputs
<dl>
<dt id="RNAseq.adapterForward"><a href="#RNAseq.adapterForward">RNAseq.adapterForward</a></dt>
<dd>
    <i>String? </i><i>&mdash; Default:</i> <code>"AGATCGGAAGAG"</code><br />
    The adapter to be removed from the reads first or single end reads.
</dd>
<dt id="RNAseq.adapterReverse"><a href="#RNAseq.adapterReverse">RNAseq.adapterReverse</a></dt>
<dd>
    <i>String? </i><i>&mdash; Default:</i> <code>"AGATCGGAAGAG"</code><br />
    The adapter to be removed from the reads second end reads.
</dd>
<dt id="RNAseq.cpatHex"><a href="#RNAseq.cpatHex">RNAseq.cpatHex</a></dt>
<dd>
    <i>File? </i><br />
    A hexamer frequency table for CPAT. Required if lncRNAdetection is `true`.
</dd>
<dt id="RNAseq.cpatLogitModel"><a href="#RNAseq.cpatLogitModel">RNAseq.cpatLogitModel</a></dt>
<dd>
    <i>File? </i><br />
    A logit model for CPAT. Required if lncRNAdetection is `true`.
</dd>
<dt id="RNAseq.dbsnpVCF"><a href="#RNAseq.dbsnpVCF">RNAseq.dbsnpVCF</a></dt>
<dd>
    <i>File? </i><br />
    dbsnp VCF file used for checking known sites.
</dd>
<dt id="RNAseq.dbsnpVCFIndex"><a href="#RNAseq.dbsnpVCFIndex">RNAseq.dbsnpVCFIndex</a></dt>
<dd>
    <i>File? </i><br />
    Index (.tbi) file for the dbsnp VCF.
</dd>
<dt id="RNAseq.detectNovelTranscripts"><a href="#RNAseq.detectNovelTranscripts">RNAseq.detectNovelTranscripts</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not a transcripts assembly should be used. If set to true Stringtie will be used to create a new GTF file based on the BAM files. This generated GTF file will be used for expression quantification. If `referenceGtfFile` is also provided this reference GTF will be used to guide the assembly.
</dd>
<dt id="RNAseq.dgeFiles"><a href="#RNAseq.dgeFiles">RNAseq.dgeFiles</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not input files for DGE should be generated.
</dd>
<dt id="RNAseq.expression.stringtieAssembly.geneAbundanceFile"><a href="#RNAseq.expression.stringtieAssembly.geneAbundanceFile">RNAseq.expression.stringtieAssembly.geneAbundanceFile</a></dt>
<dd>
    <i>String? </i><br />
    Where the abundance file should be written.
</dd>
<dt id="RNAseq.lncRNAdatabases"><a href="#RNAseq.lncRNAdatabases">RNAseq.lncRNAdatabases</a></dt>
<dd>
    <i>Array[File] </i><i>&mdash; Default:</i> <code>[]</code><br />
    A set of GTF files the assembled GTF file should be compared with. Only used if lncRNAdetection is set to `true`.
</dd>
<dt id="RNAseq.lncRNAdetection"><a href="#RNAseq.lncRNAdetection">RNAseq.lncRNAdetection</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not lncRNA detection should be run. This will enable detectNovelTranscript (this cannot be disabled by setting detectNovelTranscript to false). This will require cpatLogitModel and cpatHex to be defined.
</dd>
<dt id="RNAseq.referenceGtfFile"><a href="#RNAseq.referenceGtfFile">RNAseq.referenceGtfFile</a></dt>
<dd>
    <i>File? </i><br />
    A reference GTF file. Used for expression quantification or to guide the transcriptome assembly if detectNovelTranscripts is set to `true` (this GTF won't be be used directly for the expression quantification in that case.
</dd>
<dt id="RNAseq.refflatFile"><a href="#RNAseq.refflatFile">RNAseq.refflatFile</a></dt>
<dd>
    <i>File? </i><br />
    A refflat files describing the genes. If this is defined RNAseq metrics will be collected.
</dd>
<dt id="RNAseq.runStringtieQuantification"><a href="#RNAseq.runStringtieQuantification">RNAseq.runStringtieQuantification</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Option to disable running stringtie for quantification. This does not affect the usage of stringtie for novel transcript detection.
</dd>
<dt id="RNAseq.sampleJobs.bamMetrics.ampliconIntervals"><a href="#RNAseq.sampleJobs.bamMetrics.ampliconIntervals">RNAseq.sampleJobs.bamMetrics.ampliconIntervals</a></dt>
<dd>
    <i>File? </i><br />
    An interval list describinig the coordinates of the amplicons sequenced. This should only be used for targeted sequencing or WES. Required if `ampliconIntervals` is defined.
</dd>
<dt id="RNAseq.sampleJobs.bamMetrics.targetIntervals"><a href="#RNAseq.sampleJobs.bamMetrics.targetIntervals">RNAseq.sampleJobs.bamMetrics.targetIntervals</a></dt>
<dd>
    <i>Array[File]+? </i><br />
    An interval list describing the coordinates of the targets sequenced. This should only be used for targeted sequencing or WES. If defined targeted PCR metrics will be collected. Requires `ampliconIntervals` to also be defined.
</dd>
<dt id="RNAseq.sampleJobs.qc.contaminations"><a href="#RNAseq.sampleJobs.qc.contaminations">RNAseq.sampleJobs.qc.contaminations</a></dt>
<dd>
    <i>Array[String]+? </i><br />
    Contaminants/adapters to be removed from the reads.
</dd>
<dt id="RNAseq.sampleJobs.qc.readgroupName"><a href="#RNAseq.sampleJobs.qc.readgroupName">RNAseq.sampleJobs.qc.readgroupName</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>sub(basename(read1),"(\.fq)?(\.fastq)?(\.gz)?","")</code><br />
    The name of the readgroup.
</dd>
<dt id="RNAseq.umiDeduplication"><a href="#RNAseq.umiDeduplication">RNAseq.umiDeduplication</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not UMI based deduplication should be performed.
</dd>
<dt id="RNAseq.variantCalling"><a href="#RNAseq.variantCalling">RNAseq.variantCalling</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not variantcalling should be performed.
</dd>
<dt id="RNAseq.variantcalling.callAutosomal.excludeIntervalList"><a href="#RNAseq.variantcalling.callAutosomal.excludeIntervalList">RNAseq.variantcalling.callAutosomal.excludeIntervalList</a></dt>
<dd>
    <i>Array[File]+? </i><br />
    Bed files or interval lists describing the regions to NOT operate on.
</dd>
<dt id="RNAseq.variantcalling.callAutosomal.pedigree"><a href="#RNAseq.variantcalling.callAutosomal.pedigree">RNAseq.variantcalling.callAutosomal.pedigree</a></dt>
<dd>
    <i>File? </i><br />
    Pedigree file for determining the population "founders".
</dd>
<dt id="RNAseq.variantcalling.callAutosomal.ploidy"><a href="#RNAseq.variantcalling.callAutosomal.ploidy">RNAseq.variantcalling.callAutosomal.ploidy</a></dt>
<dd>
    <i>Int? </i><br />
    The ploidy with which the variants should be called.
</dd>
<dt id="RNAseq.variantcalling.callX.excludeIntervalList"><a href="#RNAseq.variantcalling.callX.excludeIntervalList">RNAseq.variantcalling.callX.excludeIntervalList</a></dt>
<dd>
    <i>Array[File]+? </i><br />
    Bed files or interval lists describing the regions to NOT operate on.
</dd>
<dt id="RNAseq.variantcalling.callX.pedigree"><a href="#RNAseq.variantcalling.callX.pedigree">RNAseq.variantcalling.callX.pedigree</a></dt>
<dd>
    <i>File? </i><br />
    Pedigree file for determining the population "founders".
</dd>
<dt id="RNAseq.variantcalling.callY.excludeIntervalList"><a href="#RNAseq.variantcalling.callY.excludeIntervalList">RNAseq.variantcalling.callY.excludeIntervalList</a></dt>
<dd>
    <i>Array[File]+? </i><br />
    Bed files or interval lists describing the regions to NOT operate on.
</dd>
<dt id="RNAseq.variantcalling.callY.pedigree"><a href="#RNAseq.variantcalling.callY.pedigree">RNAseq.variantcalling.callY.pedigree</a></dt>
<dd>
    <i>File? </i><br />
    Pedigree file for determining the population "founders".
</dd>
<dt id="RNAseq.variantcalling.gvcf"><a href="#RNAseq.variantcalling.gvcf">RNAseq.variantcalling.gvcf</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether to call in GVCF mode.
</dd>
<dt id="RNAseq.variantcalling.mergeVcf"><a href="#RNAseq.variantcalling.mergeVcf">RNAseq.variantcalling.mergeVcf</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Whether to merge scattered VCFs.
</dd>
<dt id="RNAseq.variantcalling.Stats.compareVcf"><a href="#RNAseq.variantcalling.Stats.compareVcf">RNAseq.variantcalling.Stats.compareVcf</a></dt>
<dd>
    <i>File? </i><br />
    When inputVcf and compareVCF are given, the program generates separate stats for intersection and the complements. By default only sites are compared, samples must be given to include also sample columns.
</dd>
<dt id="RNAseq.variantcalling.Stats.compareVcfIndex"><a href="#RNAseq.variantcalling.Stats.compareVcfIndex">RNAseq.variantcalling.Stats.compareVcfIndex</a></dt>
<dd>
    <i>File? </i><br />
    Index for the compareVcf.
</dd>
<dt id="RNAseq.variantCallingRegions"><a href="#RNAseq.variantCallingRegions">RNAseq.variantCallingRegions</a></dt>
<dd>
    <i>File? </i><br />
    A bed file describing the regions to operate on for variant calling.
</dd>
</dl>

## Advanced inputs
<details>
<summary> Show/Hide </summary>
<dl>
<dt id="RNAseq.calculateRegions.intersectAutosomalRegions.memory"><a href="#RNAseq.calculateRegions.intersectAutosomalRegions.memory">RNAseq.calculateRegions.intersectAutosomalRegions.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"~{512 + ceil(size([regionsA, regionsB],"M"))}M"</code><br />
    The amount of memory needed for the job.
</dd>
<dt id="RNAseq.calculateRegions.intersectAutosomalRegions.timeMinutes"><a href="#RNAseq.calculateRegions.intersectAutosomalRegions.timeMinutes">RNAseq.calculateRegions.intersectAutosomalRegions.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil(size([regionsA, regionsB],"G"))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.calculateRegions.intersectX.memory"><a href="#RNAseq.calculateRegions.intersectX.memory">RNAseq.calculateRegions.intersectX.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"~{512 + ceil(size([regionsA, regionsB],"M"))}M"</code><br />
    The amount of memory needed for the job.
</dd>
<dt id="RNAseq.calculateRegions.intersectX.timeMinutes"><a href="#RNAseq.calculateRegions.intersectX.timeMinutes">RNAseq.calculateRegions.intersectX.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil(size([regionsA, regionsB],"G"))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.calculateRegions.intersectY.memory"><a href="#RNAseq.calculateRegions.intersectY.memory">RNAseq.calculateRegions.intersectY.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"~{512 + ceil(size([regionsA, regionsB],"M"))}M"</code><br />
    The amount of memory needed for the job.
</dd>
<dt id="RNAseq.calculateRegions.intersectY.timeMinutes"><a href="#RNAseq.calculateRegions.intersectY.timeMinutes">RNAseq.calculateRegions.intersectY.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil(size([regionsA, regionsB],"G"))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.calculateRegions.inverseBed.memory"><a href="#RNAseq.calculateRegions.inverseBed.memory">RNAseq.calculateRegions.inverseBed.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"~{512 + ceil(size([inputBed, faidx],"M"))}M"</code><br />
    The amount of memory needed for the job.
</dd>
<dt id="RNAseq.calculateRegions.inverseBed.timeMinutes"><a href="#RNAseq.calculateRegions.inverseBed.timeMinutes">RNAseq.calculateRegions.inverseBed.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil(size([inputBed, faidx],"G"))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.calculateRegions.mergeBeds.memory"><a href="#RNAseq.calculateRegions.mergeBeds.memory">RNAseq.calculateRegions.mergeBeds.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"~{512 + ceil(size(bedFiles,"M"))}M"</code><br />
    The amount of memory needed for the job.
</dd>
<dt id="RNAseq.calculateRegions.mergeBeds.outputBed"><a href="#RNAseq.calculateRegions.mergeBeds.outputBed">RNAseq.calculateRegions.mergeBeds.outputBed</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"merged.bed"</code><br />
    The path to write the output to.
</dd>
<dt id="RNAseq.calculateRegions.mergeBeds.timeMinutes"><a href="#RNAseq.calculateRegions.mergeBeds.timeMinutes">RNAseq.calculateRegions.mergeBeds.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil(size(bedFiles,"G"))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.calculateRegions.scatterAutosomalRegions.memory"><a href="#RNAseq.calculateRegions.scatterAutosomalRegions.memory">RNAseq.calculateRegions.scatterAutosomalRegions.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"256M"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="RNAseq.calculateRegions.scatterAutosomalRegions.prefix"><a href="#RNAseq.calculateRegions.scatterAutosomalRegions.prefix">RNAseq.calculateRegions.scatterAutosomalRegions.prefix</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"scatters/scatter-"</code><br />
    The prefix of the ouput files. Output will be named like: <PREFIX><N>.bed, in which N is an incrementing number. Default 'scatter-'.
</dd>
<dt id="RNAseq.calculateRegions.scatterAutosomalRegions.splitContigs"><a href="#RNAseq.calculateRegions.scatterAutosomalRegions.splitContigs">RNAseq.calculateRegions.scatterAutosomalRegions.splitContigs</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    If set, contigs are allowed to be split up over multiple files.
</dd>
<dt id="RNAseq.calculateRegions.scatterAutosomalRegions.timeMinutes"><a href="#RNAseq.calculateRegions.scatterAutosomalRegions.timeMinutes">RNAseq.calculateRegions.scatterAutosomalRegions.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>2</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.collectUmiStats"><a href="#RNAseq.collectUmiStats">RNAseq.collectUmiStats</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not UMI deduplication stats should be collected. This will potentially cause a massive increase in memory usage of the deduplication step.
</dd>
<dt id="RNAseq.convertDockerTagsFile.dockerImage"><a href="#RNAseq.convertDockerTagsFile.dockerImage">RNAseq.convertDockerTagsFile.dockerImage</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"quay.io/biocontainers/biowdl-input-converter:0.3.0--pyhdfd78af_0"</code><br />
    The docker image used for this task. Changing this may result in errors which the developers may choose not to address.
</dd>
<dt id="RNAseq.convertDockerTagsFile.memory"><a href="#RNAseq.convertDockerTagsFile.memory">RNAseq.convertDockerTagsFile.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"128M"</code><br />
    The maximum amount of memory the job will need.
</dd>
<dt id="RNAseq.convertDockerTagsFile.timeMinutes"><a href="#RNAseq.convertDockerTagsFile.timeMinutes">RNAseq.convertDockerTagsFile.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.convertSampleConfig.checkFileMd5sums"><a href="#RNAseq.convertSampleConfig.checkFileMd5sums">RNAseq.convertSampleConfig.checkFileMd5sums</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not the MD5 sums of the files mentioned in the samplesheet should be checked.
</dd>
<dt id="RNAseq.convertSampleConfig.dockerImage"><a href="#RNAseq.convertSampleConfig.dockerImage">RNAseq.convertSampleConfig.dockerImage</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"quay.io/biocontainers/biowdl-input-converter:0.3.0--pyhdfd78af_0"</code><br />
    The docker image used for this task. Changing this may result in errors which the developers may choose not to address.
</dd>
<dt id="RNAseq.convertSampleConfig.memory"><a href="#RNAseq.convertSampleConfig.memory">RNAseq.convertSampleConfig.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"128M"</code><br />
    The amount of memory needed for the job.
</dd>
<dt id="RNAseq.convertSampleConfig.old"><a href="#RNAseq.convertSampleConfig.old">RNAseq.convertSampleConfig.old</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether or not the old samplesheet format should be used.
</dd>
<dt id="RNAseq.convertSampleConfig.skipFileCheck"><a href="#RNAseq.convertSampleConfig.skipFileCheck">RNAseq.convertSampleConfig.skipFileCheck</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Whether or not the existance of the files mentioned in the samplesheet should be checked.
</dd>
<dt id="RNAseq.convertSampleConfig.timeMinutes"><a href="#RNAseq.convertSampleConfig.timeMinutes">RNAseq.convertSampleConfig.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.CPAT.memory"><a href="#RNAseq.CPAT.memory">RNAseq.CPAT.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The amount of memory available to the job.
</dd>
<dt id="RNAseq.CPAT.startCodons"><a href="#RNAseq.CPAT.startCodons">RNAseq.CPAT.startCodons</a></dt>
<dd>
    <i>Array[String]? </i><br />
    Equivalent to CPAT's `--start` option.
</dd>
<dt id="RNAseq.CPAT.stopCodons"><a href="#RNAseq.CPAT.stopCodons">RNAseq.CPAT.stopCodons</a></dt>
<dd>
    <i>Array[String]? </i><br />
    Equivalent to CPAT's `--stop` option.
</dd>
<dt id="RNAseq.CPAT.timeMinutes"><a href="#RNAseq.CPAT.timeMinutes">RNAseq.CPAT.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>10 + ceil((size(gene,"G") * 30))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.createAnnotation.memory"><a href="#RNAseq.createAnnotation.memory">RNAseq.createAnnotation.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"5G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="RNAseq.createAnnotation.timeMinutes"><a href="#RNAseq.createAnnotation.timeMinutes">RNAseq.createAnnotation.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>30</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.createDesign.memory"><a href="#RNAseq.createDesign.memory">RNAseq.createDesign.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"5G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="RNAseq.createDesign.timeMinutes"><a href="#RNAseq.createDesign.timeMinutes">RNAseq.createDesign.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>30</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.expression.additionalAttributes"><a href="#RNAseq.expression.additionalAttributes">RNAseq.expression.additionalAttributes</a></dt>
<dd>
    <i>Array[String]+? </i><br />
    Additional attributes which should be taken from the GTF used for quantification and added to the merged expression value tables.
</dd>
<dt id="RNAseq.expression.htSeqCount.additionalAttributes"><a href="#RNAseq.expression.htSeqCount.additionalAttributes">RNAseq.expression.htSeqCount.additionalAttributes</a></dt>
<dd>
    <i>Array[String] </i><i>&mdash; Default:</i> <code>[]</code><br />
    Equivalent to the --additional-attr option of htseq-count.
</dd>
<dt id="RNAseq.expression.htSeqCount.featureType"><a href="#RNAseq.expression.htSeqCount.featureType">RNAseq.expression.htSeqCount.featureType</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to the --type option of htseq-count.
</dd>
<dt id="RNAseq.expression.htSeqCount.idattr"><a href="#RNAseq.expression.htSeqCount.idattr">RNAseq.expression.htSeqCount.idattr</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to the --idattr option of htseq-count.
</dd>
<dt id="RNAseq.expression.htSeqCount.memory"><a href="#RNAseq.expression.htSeqCount.memory">RNAseq.expression.htSeqCount.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"8G"</code><br />
    The amount of memory the job requires in GB.
</dd>
<dt id="RNAseq.expression.htSeqCount.nprocesses"><a href="#RNAseq.expression.htSeqCount.nprocesses">RNAseq.expression.htSeqCount.nprocesses</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    Number of processes to run htseq with.
</dd>
<dt id="RNAseq.expression.htSeqCount.order"><a href="#RNAseq.expression.htSeqCount.order">RNAseq.expression.htSeqCount.order</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"pos"</code><br />
    Equivalent to the -r option of htseq-count.
</dd>
<dt id="RNAseq.expression.htSeqCount.timeMinutes"><a href="#RNAseq.expression.htSeqCount.timeMinutes">RNAseq.expression.htSeqCount.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1440</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.expression.mergedHTSeqFragmentsPerGenes.featureAttribute"><a href="#RNAseq.expression.mergedHTSeqFragmentsPerGenes.featureAttribute">RNAseq.expression.mergedHTSeqFragmentsPerGenes.featureAttribute</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to the -F option of collect-columns.
</dd>
<dt id="RNAseq.expression.mergedHTSeqFragmentsPerGenes.featureColumn"><a href="#RNAseq.expression.mergedHTSeqFragmentsPerGenes.featureColumn">RNAseq.expression.mergedHTSeqFragmentsPerGenes.featureColumn</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to the -f option of collect-columns.
</dd>
<dt id="RNAseq.expression.mergedHTSeqFragmentsPerGenes.header"><a href="#RNAseq.expression.mergedHTSeqFragmentsPerGenes.header">RNAseq.expression.mergedHTSeqFragmentsPerGenes.header</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to the -H flag of collect-columns.
</dd>
<dt id="RNAseq.expression.mergedHTSeqFragmentsPerGenes.memoryGb"><a href="#RNAseq.expression.mergedHTSeqFragmentsPerGenes.memoryGb">RNAseq.expression.mergedHTSeqFragmentsPerGenes.memoryGb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>4 + ceil((0.5 * length(inputTables)))</code><br />
    The maximum amount of memory the job will need in GB.
</dd>
<dt id="RNAseq.expression.mergedHTSeqFragmentsPerGenes.separator"><a href="#RNAseq.expression.mergedHTSeqFragmentsPerGenes.separator">RNAseq.expression.mergedHTSeqFragmentsPerGenes.separator</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to the -s option of collect-columns.
</dd>
<dt id="RNAseq.expression.mergedHTSeqFragmentsPerGenes.sumOnDuplicateId"><a href="#RNAseq.expression.mergedHTSeqFragmentsPerGenes.sumOnDuplicateId">RNAseq.expression.mergedHTSeqFragmentsPerGenes.sumOnDuplicateId</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to the -S flag of collect-columns.
</dd>
<dt id="RNAseq.expression.mergedHTSeqFragmentsPerGenes.timeMinutes"><a href="#RNAseq.expression.mergedHTSeqFragmentsPerGenes.timeMinutes">RNAseq.expression.mergedHTSeqFragmentsPerGenes.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>10</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.expression.mergedHTSeqFragmentsPerGenes.valueColumn"><a href="#RNAseq.expression.mergedHTSeqFragmentsPerGenes.valueColumn">RNAseq.expression.mergedHTSeqFragmentsPerGenes.valueColumn</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to the -c option of collect-columns.
</dd>
<dt id="RNAseq.expression.mergedStringtieFPKMs.featureAttribute"><a href="#RNAseq.expression.mergedStringtieFPKMs.featureAttribute">RNAseq.expression.mergedStringtieFPKMs.featureAttribute</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to the -F option of collect-columns.
</dd>
<dt id="RNAseq.expression.mergedStringtieFPKMs.featureColumn"><a href="#RNAseq.expression.mergedStringtieFPKMs.featureColumn">RNAseq.expression.mergedStringtieFPKMs.featureColumn</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to the -f option of collect-columns.
</dd>
<dt id="RNAseq.expression.mergedStringtieFPKMs.memoryGb"><a href="#RNAseq.expression.mergedStringtieFPKMs.memoryGb">RNAseq.expression.mergedStringtieFPKMs.memoryGb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>4 + ceil((0.5 * length(inputTables)))</code><br />
    The maximum amount of memory the job will need in GB.
</dd>
<dt id="RNAseq.expression.mergedStringtieFPKMs.separator"><a href="#RNAseq.expression.mergedStringtieFPKMs.separator">RNAseq.expression.mergedStringtieFPKMs.separator</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to the -s option of collect-columns.
</dd>
<dt id="RNAseq.expression.mergedStringtieFPKMs.timeMinutes"><a href="#RNAseq.expression.mergedStringtieFPKMs.timeMinutes">RNAseq.expression.mergedStringtieFPKMs.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>10</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.expression.mergedStringtieTPMs.featureAttribute"><a href="#RNAseq.expression.mergedStringtieTPMs.featureAttribute">RNAseq.expression.mergedStringtieTPMs.featureAttribute</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to the -F option of collect-columns.
</dd>
<dt id="RNAseq.expression.mergedStringtieTPMs.featureColumn"><a href="#RNAseq.expression.mergedStringtieTPMs.featureColumn">RNAseq.expression.mergedStringtieTPMs.featureColumn</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to the -f option of collect-columns.
</dd>
<dt id="RNAseq.expression.mergedStringtieTPMs.memoryGb"><a href="#RNAseq.expression.mergedStringtieTPMs.memoryGb">RNAseq.expression.mergedStringtieTPMs.memoryGb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>4 + ceil((0.5 * length(inputTables)))</code><br />
    The maximum amount of memory the job will need in GB.
</dd>
<dt id="RNAseq.expression.mergedStringtieTPMs.separator"><a href="#RNAseq.expression.mergedStringtieTPMs.separator">RNAseq.expression.mergedStringtieTPMs.separator</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to the -s option of collect-columns.
</dd>
<dt id="RNAseq.expression.mergedStringtieTPMs.timeMinutes"><a href="#RNAseq.expression.mergedStringtieTPMs.timeMinutes">RNAseq.expression.mergedStringtieTPMs.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>10</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.expression.mergeStringtieGtf.A"><a href="#RNAseq.expression.mergeStringtieGtf.A">RNAseq.expression.mergeStringtieGtf.A</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to gffcompare's `-A` flag.
</dd>
<dt id="RNAseq.expression.mergeStringtieGtf.debugMode"><a href="#RNAseq.expression.mergeStringtieGtf.debugMode">RNAseq.expression.mergeStringtieGtf.debugMode</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to gffcompare's `-D` flag.
</dd>
<dt id="RNAseq.expression.mergeStringtieGtf.discardSingleExonReferenceTranscripts"><a href="#RNAseq.expression.mergeStringtieGtf.discardSingleExonReferenceTranscripts">RNAseq.expression.mergeStringtieGtf.discardSingleExonReferenceTranscripts</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to gffcompare's `-N` flag.
</dd>
<dt id="RNAseq.expression.mergeStringtieGtf.discardSingleExonTransfragsAndReferenceTranscripts"><a href="#RNAseq.expression.mergeStringtieGtf.discardSingleExonTransfragsAndReferenceTranscripts">RNAseq.expression.mergeStringtieGtf.discardSingleExonTransfragsAndReferenceTranscripts</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to gffcompare's `-M` flag.
</dd>
<dt id="RNAseq.expression.mergeStringtieGtf.genomeSequences"><a href="#RNAseq.expression.mergeStringtieGtf.genomeSequences">RNAseq.expression.mergeStringtieGtf.genomeSequences</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to gffcompare's `-s` option.
</dd>
<dt id="RNAseq.expression.mergeStringtieGtf.inputGtfList"><a href="#RNAseq.expression.mergeStringtieGtf.inputGtfList">RNAseq.expression.mergeStringtieGtf.inputGtfList</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to gffcompare's `-i` option.
</dd>
<dt id="RNAseq.expression.mergeStringtieGtf.K"><a href="#RNAseq.expression.mergeStringtieGtf.K">RNAseq.expression.mergeStringtieGtf.K</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to gffcompare's `-K` flag.
</dd>
<dt id="RNAseq.expression.mergeStringtieGtf.maxDistanceFreeEndsTerminalExons"><a href="#RNAseq.expression.mergeStringtieGtf.maxDistanceFreeEndsTerminalExons">RNAseq.expression.mergeStringtieGtf.maxDistanceFreeEndsTerminalExons</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to gffcompare's `-e` option.
</dd>
<dt id="RNAseq.expression.mergeStringtieGtf.maxDistanceGroupingTranscriptStartSites"><a href="#RNAseq.expression.mergeStringtieGtf.maxDistanceGroupingTranscriptStartSites">RNAseq.expression.mergeStringtieGtf.maxDistanceGroupingTranscriptStartSites</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to gffcompare's `-d` option.
</dd>
<dt id="RNAseq.expression.mergeStringtieGtf.memory"><a href="#RNAseq.expression.mergeStringtieGtf.memory">RNAseq.expression.mergeStringtieGtf.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The amount of memory available to the job.
</dd>
<dt id="RNAseq.expression.mergeStringtieGtf.namePrefix"><a href="#RNAseq.expression.mergeStringtieGtf.namePrefix">RNAseq.expression.mergeStringtieGtf.namePrefix</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to gffcompare's `-p` option.
</dd>
<dt id="RNAseq.expression.mergeStringtieGtf.noTmap"><a href="#RNAseq.expression.mergeStringtieGtf.noTmap">RNAseq.expression.mergeStringtieGtf.noTmap</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to gffcompare's `-T` flag.
</dd>
<dt id="RNAseq.expression.mergeStringtieGtf.precisionCorrection"><a href="#RNAseq.expression.mergeStringtieGtf.precisionCorrection">RNAseq.expression.mergeStringtieGtf.precisionCorrection</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to gffcompare's `-Q` flag.
</dd>
<dt id="RNAseq.expression.mergeStringtieGtf.snCorrection"><a href="#RNAseq.expression.mergeStringtieGtf.snCorrection">RNAseq.expression.mergeStringtieGtf.snCorrection</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to gffcompare's `-R` flag.
</dd>
<dt id="RNAseq.expression.mergeStringtieGtf.timeMinutes"><a href="#RNAseq.expression.mergeStringtieGtf.timeMinutes">RNAseq.expression.mergeStringtieGtf.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil((size(inputGtfFiles,"G") * 30))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.expression.mergeStringtieGtf.verbose"><a href="#RNAseq.expression.mergeStringtieGtf.verbose">RNAseq.expression.mergeStringtieGtf.verbose</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to gffcompare's `-V` flag.
</dd>
<dt id="RNAseq.expression.mergeStringtieGtf.X"><a href="#RNAseq.expression.mergeStringtieGtf.X">RNAseq.expression.mergeStringtieGtf.X</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to gffcompare's `-X` flag.
</dd>
<dt id="RNAseq.expression.stringtie.memory"><a href="#RNAseq.expression.stringtie.memory">RNAseq.expression.stringtie.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"2G"</code><br />
    The amount of memory needed for this task in GB.
</dd>
<dt id="RNAseq.expression.stringtie.minimumCoverage"><a href="#RNAseq.expression.stringtie.minimumCoverage">RNAseq.expression.stringtie.minimumCoverage</a></dt>
<dd>
    <i>Float? </i><br />
    The minimum coverage for a transcript to be shown in the output.
</dd>
<dt id="RNAseq.expression.stringtie.threads"><a href="#RNAseq.expression.stringtie.threads">RNAseq.expression.stringtie.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of threads to use.
</dd>
<dt id="RNAseq.expression.stringtie.timeMinutes"><a href="#RNAseq.expression.stringtie.timeMinutes">RNAseq.expression.stringtie.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil((size(bam,"G") * 60 / threads))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.expression.stringtieAssembly.memory"><a href="#RNAseq.expression.stringtieAssembly.memory">RNAseq.expression.stringtieAssembly.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"2G"</code><br />
    The amount of memory needed for this task in GB.
</dd>
<dt id="RNAseq.expression.stringtieAssembly.minimumCoverage"><a href="#RNAseq.expression.stringtieAssembly.minimumCoverage">RNAseq.expression.stringtieAssembly.minimumCoverage</a></dt>
<dd>
    <i>Float? </i><br />
    The minimum coverage for a transcript to be shown in the output.
</dd>
<dt id="RNAseq.expression.stringtieAssembly.threads"><a href="#RNAseq.expression.stringtieAssembly.threads">RNAseq.expression.stringtieAssembly.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of threads to use.
</dd>
<dt id="RNAseq.expression.stringtieAssembly.timeMinutes"><a href="#RNAseq.expression.stringtieAssembly.timeMinutes">RNAseq.expression.stringtieAssembly.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil((size(bam,"G") * 60 / threads))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.GffCompare.A"><a href="#RNAseq.GffCompare.A">RNAseq.GffCompare.A</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to gffcompare's `-A` flag.
</dd>
<dt id="RNAseq.GffCompare.C"><a href="#RNAseq.GffCompare.C">RNAseq.GffCompare.C</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to gffcompare's `-C` flag.
</dd>
<dt id="RNAseq.GffCompare.debugMode"><a href="#RNAseq.GffCompare.debugMode">RNAseq.GffCompare.debugMode</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to gffcompare's `-D` flag.
</dd>
<dt id="RNAseq.GffCompare.discardSingleExonReferenceTranscripts"><a href="#RNAseq.GffCompare.discardSingleExonReferenceTranscripts">RNAseq.GffCompare.discardSingleExonReferenceTranscripts</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to gffcompare's `-N` flag.
</dd>
<dt id="RNAseq.GffCompare.discardSingleExonTransfragsAndReferenceTranscripts"><a href="#RNAseq.GffCompare.discardSingleExonTransfragsAndReferenceTranscripts">RNAseq.GffCompare.discardSingleExonTransfragsAndReferenceTranscripts</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to gffcompare's `-M` flag.
</dd>
<dt id="RNAseq.GffCompare.genomeSequences"><a href="#RNAseq.GffCompare.genomeSequences">RNAseq.GffCompare.genomeSequences</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to gffcompare's `-s` option.
</dd>
<dt id="RNAseq.GffCompare.inputGtfList"><a href="#RNAseq.GffCompare.inputGtfList">RNAseq.GffCompare.inputGtfList</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to gffcompare's `-i` option.
</dd>
<dt id="RNAseq.GffCompare.K"><a href="#RNAseq.GffCompare.K">RNAseq.GffCompare.K</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to gffcompare's `-K` flag.
</dd>
<dt id="RNAseq.GffCompare.maxDistanceFreeEndsTerminalExons"><a href="#RNAseq.GffCompare.maxDistanceFreeEndsTerminalExons">RNAseq.GffCompare.maxDistanceFreeEndsTerminalExons</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to gffcompare's `-e` option.
</dd>
<dt id="RNAseq.GffCompare.maxDistanceGroupingTranscriptStartSites"><a href="#RNAseq.GffCompare.maxDistanceGroupingTranscriptStartSites">RNAseq.GffCompare.maxDistanceGroupingTranscriptStartSites</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to gffcompare's `-d` option.
</dd>
<dt id="RNAseq.GffCompare.memory"><a href="#RNAseq.GffCompare.memory">RNAseq.GffCompare.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The amount of memory available to the job.
</dd>
<dt id="RNAseq.GffCompare.namePrefix"><a href="#RNAseq.GffCompare.namePrefix">RNAseq.GffCompare.namePrefix</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to gffcompare's `-p` option.
</dd>
<dt id="RNAseq.GffCompare.noTmap"><a href="#RNAseq.GffCompare.noTmap">RNAseq.GffCompare.noTmap</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to gffcompare's `-T` flag.
</dd>
<dt id="RNAseq.GffCompare.outPrefix"><a href="#RNAseq.GffCompare.outPrefix">RNAseq.GffCompare.outPrefix</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"gffcmp"</code><br />
    The prefix for the output.
</dd>
<dt id="RNAseq.GffCompare.precisionCorrection"><a href="#RNAseq.GffCompare.precisionCorrection">RNAseq.GffCompare.precisionCorrection</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to gffcompare's `-Q` flag.
</dd>
<dt id="RNAseq.GffCompare.snCorrection"><a href="#RNAseq.GffCompare.snCorrection">RNAseq.GffCompare.snCorrection</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to gffcompare's `-R` flag.
</dd>
<dt id="RNAseq.GffCompare.timeMinutes"><a href="#RNAseq.GffCompare.timeMinutes">RNAseq.GffCompare.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil((size(inputGtfFiles,"G") * 30))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.GffCompare.verbose"><a href="#RNAseq.GffCompare.verbose">RNAseq.GffCompare.verbose</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to gffcompare's `-V` flag.
</dd>
<dt id="RNAseq.GffCompare.X"><a href="#RNAseq.GffCompare.X">RNAseq.GffCompare.X</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to gffcompare's `-X` flag.
</dd>
<dt id="RNAseq.gffreadTask.CDSFastaPath"><a href="#RNAseq.gffreadTask.CDSFastaPath">RNAseq.gffreadTask.CDSFastaPath</a></dt>
<dd>
    <i>String? </i><br />
    The location the CDS fasta should be written to.
</dd>
<dt id="RNAseq.gffreadTask.filteredGffPath"><a href="#RNAseq.gffreadTask.filteredGffPath">RNAseq.gffreadTask.filteredGffPath</a></dt>
<dd>
    <i>String? </i><br />
    The location the filtered GFF should be written to.
</dd>
<dt id="RNAseq.gffreadTask.memory"><a href="#RNAseq.gffreadTask.memory">RNAseq.gffreadTask.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The amount of memory available to the job.
</dd>
<dt id="RNAseq.gffreadTask.outputGtfFormat"><a href="#RNAseq.gffreadTask.outputGtfFormat">RNAseq.gffreadTask.outputGtfFormat</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to gffread's `-T` flag.
</dd>
<dt id="RNAseq.gffreadTask.proteinFastaPath"><a href="#RNAseq.gffreadTask.proteinFastaPath">RNAseq.gffreadTask.proteinFastaPath</a></dt>
<dd>
    <i>String? </i><br />
    The location the protein fasta should be written to.
</dd>
<dt id="RNAseq.gffreadTask.timeMinutes"><a href="#RNAseq.gffreadTask.timeMinutes">RNAseq.gffreadTask.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil((size(inputGff,"G") * 10))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.makeStarIndex.memory"><a href="#RNAseq.makeStarIndex.memory">RNAseq.makeStarIndex.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"32G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="RNAseq.makeStarIndex.sjdbOverhang"><a href="#RNAseq.makeStarIndex.sjdbOverhang">RNAseq.makeStarIndex.sjdbOverhang</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to STAR's `--sjdbOverhang` option.
</dd>
<dt id="RNAseq.makeStarIndex.threads"><a href="#RNAseq.makeStarIndex.threads">RNAseq.makeStarIndex.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>4</code><br />
    The number of threads to use.
</dd>
<dt id="RNAseq.makeStarIndex.timeMinutes"><a href="#RNAseq.makeStarIndex.timeMinutes">RNAseq.makeStarIndex.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>ceil((size(referenceFasta,"G") * 240 / threads))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.multiqcTask.clConfig"><a href="#RNAseq.multiqcTask.clConfig">RNAseq.multiqcTask.clConfig</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--cl-config` option.
</dd>
<dt id="RNAseq.multiqcTask.comment"><a href="#RNAseq.multiqcTask.comment">RNAseq.multiqcTask.comment</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--comment` option.
</dd>
<dt id="RNAseq.multiqcTask.config"><a href="#RNAseq.multiqcTask.config">RNAseq.multiqcTask.config</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to MultiQC's `--config` option.
</dd>
<dt id="RNAseq.multiqcTask.dataDir"><a href="#RNAseq.multiqcTask.dataDir">RNAseq.multiqcTask.dataDir</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether to output a data dir. Sets `--data-dir` or `--no-data-dir` flag.
</dd>
<dt id="RNAseq.multiqcTask.dataFormat"><a href="#RNAseq.multiqcTask.dataFormat">RNAseq.multiqcTask.dataFormat</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--data-format` option.
</dd>
<dt id="RNAseq.multiqcTask.dirs"><a href="#RNAseq.multiqcTask.dirs">RNAseq.multiqcTask.dirs</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--dirs` flag.
</dd>
<dt id="RNAseq.multiqcTask.dirsDepth"><a href="#RNAseq.multiqcTask.dirsDepth">RNAseq.multiqcTask.dirsDepth</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to MultiQC's `--dirs-depth` option.
</dd>
<dt id="RNAseq.multiqcTask.exclude"><a href="#RNAseq.multiqcTask.exclude">RNAseq.multiqcTask.exclude</a></dt>
<dd>
    <i>Array[String]+? </i><br />
    Equivalent to MultiQC's `--exclude` option.
</dd>
<dt id="RNAseq.multiqcTask.export"><a href="#RNAseq.multiqcTask.export">RNAseq.multiqcTask.export</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--export` flag.
</dd>
<dt id="RNAseq.multiqcTask.fileList"><a href="#RNAseq.multiqcTask.fileList">RNAseq.multiqcTask.fileList</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to MultiQC's `--file-list` option.
</dd>
<dt id="RNAseq.multiqcTask.fileName"><a href="#RNAseq.multiqcTask.fileName">RNAseq.multiqcTask.fileName</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--filename` option.
</dd>
<dt id="RNAseq.multiqcTask.flat"><a href="#RNAseq.multiqcTask.flat">RNAseq.multiqcTask.flat</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--flat` flag.
</dd>
<dt id="RNAseq.multiqcTask.force"><a href="#RNAseq.multiqcTask.force">RNAseq.multiqcTask.force</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--force` flag.
</dd>
<dt id="RNAseq.multiqcTask.fullNames"><a href="#RNAseq.multiqcTask.fullNames">RNAseq.multiqcTask.fullNames</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--fullnames` flag.
</dd>
<dt id="RNAseq.multiqcTask.ignore"><a href="#RNAseq.multiqcTask.ignore">RNAseq.multiqcTask.ignore</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--ignore` option.
</dd>
<dt id="RNAseq.multiqcTask.ignoreSamples"><a href="#RNAseq.multiqcTask.ignoreSamples">RNAseq.multiqcTask.ignoreSamples</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--ignore-samples` option.
</dd>
<dt id="RNAseq.multiqcTask.interactive"><a href="#RNAseq.multiqcTask.interactive">RNAseq.multiqcTask.interactive</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to MultiQC's `--interactive` flag.
</dd>
<dt id="RNAseq.multiqcTask.lint"><a href="#RNAseq.multiqcTask.lint">RNAseq.multiqcTask.lint</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--lint` flag.
</dd>
<dt id="RNAseq.multiqcTask.megaQCUpload"><a href="#RNAseq.multiqcTask.megaQCUpload">RNAseq.multiqcTask.megaQCUpload</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Opposite to MultiQC's `--no-megaqc-upload` flag.
</dd>
<dt id="RNAseq.multiqcTask.memory"><a href="#RNAseq.multiqcTask.memory">RNAseq.multiqcTask.memory</a></dt>
<dd>
    <i>String? </i><br />
    The amount of memory this job will use.
</dd>
<dt id="RNAseq.multiqcTask.module"><a href="#RNAseq.multiqcTask.module">RNAseq.multiqcTask.module</a></dt>
<dd>
    <i>Array[String]+? </i><br />
    Equivalent to MultiQC's `--module` option.
</dd>
<dt id="RNAseq.multiqcTask.pdf"><a href="#RNAseq.multiqcTask.pdf">RNAseq.multiqcTask.pdf</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to MultiQC's `--pdf` flag.
</dd>
<dt id="RNAseq.multiqcTask.sampleNames"><a href="#RNAseq.multiqcTask.sampleNames">RNAseq.multiqcTask.sampleNames</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to MultiQC's `--sample-names` option.
</dd>
<dt id="RNAseq.multiqcTask.tag"><a href="#RNAseq.multiqcTask.tag">RNAseq.multiqcTask.tag</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--tag` option.
</dd>
<dt id="RNAseq.multiqcTask.template"><a href="#RNAseq.multiqcTask.template">RNAseq.multiqcTask.template</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--template` option.
</dd>
<dt id="RNAseq.multiqcTask.timeMinutes"><a href="#RNAseq.multiqcTask.timeMinutes">RNAseq.multiqcTask.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>10 + ceil((size(reports,"G") * 8))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.multiqcTask.title"><a href="#RNAseq.multiqcTask.title">RNAseq.multiqcTask.title</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to MultiQC's `--title` option.
</dd>
<dt id="RNAseq.multiqcTask.zipDataDir"><a href="#RNAseq.multiqcTask.zipDataDir">RNAseq.multiqcTask.zipDataDir</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to MultiQC's `--zip-data-dir` flag.
</dd>
<dt id="RNAseq.platform"><a href="#RNAseq.platform">RNAseq.platform</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"illumina"</code><br />
    The platform used for sequencing.
</dd>
<dt id="RNAseq.preprocessing.applyBqsr.javaXmxMb"><a href="#RNAseq.preprocessing.applyBqsr.javaXmxMb">RNAseq.preprocessing.applyBqsr.javaXmxMb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>2048</code><br />
    The maximum memory available to the program in megabytes. Should be lower than `memoryMb` to accommodate JVM overhead.
</dd>
<dt id="RNAseq.preprocessing.applyBqsr.memoryMb"><a href="#RNAseq.preprocessing.applyBqsr.memoryMb">RNAseq.preprocessing.applyBqsr.memoryMb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>javaXmxMb + 512</code><br />
    The amount of memory this job will use in megabytes.
</dd>
<dt id="RNAseq.preprocessing.baseRecalibrator.javaXmxMb"><a href="#RNAseq.preprocessing.baseRecalibrator.javaXmxMb">RNAseq.preprocessing.baseRecalibrator.javaXmxMb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1024</code><br />
    The maximum memory available to the program in megabytes. Should be lower than `memoryMb` to accommodate JVM overhead.
</dd>
<dt id="RNAseq.preprocessing.baseRecalibrator.knownIndelsSitesVCFIndexes"><a href="#RNAseq.preprocessing.baseRecalibrator.knownIndelsSitesVCFIndexes">RNAseq.preprocessing.baseRecalibrator.knownIndelsSitesVCFIndexes</a></dt>
<dd>
    <i>Array[File] </i><i>&mdash; Default:</i> <code>[]</code><br />
    The indexed for the known variant VCFs.
</dd>
<dt id="RNAseq.preprocessing.baseRecalibrator.knownIndelsSitesVCFs"><a href="#RNAseq.preprocessing.baseRecalibrator.knownIndelsSitesVCFs">RNAseq.preprocessing.baseRecalibrator.knownIndelsSitesVCFs</a></dt>
<dd>
    <i>Array[File] </i><i>&mdash; Default:</i> <code>[]</code><br />
    VCF files with known indels.
</dd>
<dt id="RNAseq.preprocessing.baseRecalibrator.memoryMb"><a href="#RNAseq.preprocessing.baseRecalibrator.memoryMb">RNAseq.preprocessing.baseRecalibrator.memoryMb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>javaXmxMb + 512</code><br />
    The amount of memory this job will use in megabytes.
</dd>
<dt id="RNAseq.preprocessing.gatherBamFiles.compressionLevel"><a href="#RNAseq.preprocessing.gatherBamFiles.compressionLevel">RNAseq.preprocessing.gatherBamFiles.compressionLevel</a></dt>
<dd>
    <i>Int? </i><br />
    The compression level of the output BAM.
</dd>
<dt id="RNAseq.preprocessing.gatherBamFiles.createMd5File"><a href="#RNAseq.preprocessing.gatherBamFiles.createMd5File">RNAseq.preprocessing.gatherBamFiles.createMd5File</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    ???
</dd>
<dt id="RNAseq.preprocessing.gatherBamFiles.javaXmxMb"><a href="#RNAseq.preprocessing.gatherBamFiles.javaXmxMb">RNAseq.preprocessing.gatherBamFiles.javaXmxMb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1024</code><br />
    The maximum memory available to the program in megabytes. Should be lower than `memoryMb` to accommodate JVM overhead.
</dd>
<dt id="RNAseq.preprocessing.gatherBamFiles.memoryMb"><a href="#RNAseq.preprocessing.gatherBamFiles.memoryMb">RNAseq.preprocessing.gatherBamFiles.memoryMb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>javaXmxMb + 512</code><br />
    The amount of memory this job will use in megabytes.
</dd>
<dt id="RNAseq.preprocessing.gatherBamFiles.timeMinutes"><a href="#RNAseq.preprocessing.gatherBamFiles.timeMinutes">RNAseq.preprocessing.gatherBamFiles.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil((size(inputBams,"G") * 1))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.preprocessing.gatherBqsr.javaXmxMb"><a href="#RNAseq.preprocessing.gatherBqsr.javaXmxMb">RNAseq.preprocessing.gatherBqsr.javaXmxMb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>256</code><br />
    The maximum memory available to the program in megabytes. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="RNAseq.preprocessing.gatherBqsr.memoryMb"><a href="#RNAseq.preprocessing.gatherBqsr.memoryMb">RNAseq.preprocessing.gatherBqsr.memoryMb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>256 + javaXmxMb</code><br />
    The amount of memory this job will use in megabytes.
</dd>
<dt id="RNAseq.preprocessing.gatherBqsr.timeMinutes"><a href="#RNAseq.preprocessing.gatherBqsr.timeMinutes">RNAseq.preprocessing.gatherBqsr.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.preprocessing.splitNCigarReads.javaXmx"><a href="#RNAseq.preprocessing.splitNCigarReads.javaXmx">RNAseq.preprocessing.splitNCigarReads.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="RNAseq.preprocessing.splitNCigarReads.memory"><a href="#RNAseq.preprocessing.splitNCigarReads.memory">RNAseq.preprocessing.splitNCigarReads.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"5G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="RNAseq.sampleJobs.bamMetrics.ampliconIntervalsLists.javaXmx"><a href="#RNAseq.sampleJobs.bamMetrics.ampliconIntervalsLists.javaXmx">RNAseq.sampleJobs.bamMetrics.ampliconIntervalsLists.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"3G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="RNAseq.sampleJobs.bamMetrics.ampliconIntervalsLists.memory"><a href="#RNAseq.sampleJobs.bamMetrics.ampliconIntervalsLists.memory">RNAseq.sampleJobs.bamMetrics.ampliconIntervalsLists.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="RNAseq.sampleJobs.bamMetrics.ampliconIntervalsLists.timeMinutes"><a href="#RNAseq.sampleJobs.bamMetrics.ampliconIntervalsLists.timeMinutes">RNAseq.sampleJobs.bamMetrics.ampliconIntervalsLists.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>5</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.sampleJobs.bamMetrics.collectAlignmentSummaryMetrics"><a href="#RNAseq.sampleJobs.bamMetrics.collectAlignmentSummaryMetrics">RNAseq.sampleJobs.bamMetrics.collectAlignmentSummaryMetrics</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=CollectAlignmentSummaryMetrics` argument in Picard.
</dd>
<dt id="RNAseq.sampleJobs.bamMetrics.Flagstat.memory"><a href="#RNAseq.sampleJobs.bamMetrics.Flagstat.memory">RNAseq.sampleJobs.bamMetrics.Flagstat.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"256M"</code><br />
    The amount of memory needed for the job.
</dd>
<dt id="RNAseq.sampleJobs.bamMetrics.Flagstat.timeMinutes"><a href="#RNAseq.sampleJobs.bamMetrics.Flagstat.timeMinutes">RNAseq.sampleJobs.bamMetrics.Flagstat.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil(size(inputBam,"G"))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.sampleJobs.bamMetrics.meanQualityByCycle"><a href="#RNAseq.sampleJobs.bamMetrics.meanQualityByCycle">RNAseq.sampleJobs.bamMetrics.meanQualityByCycle</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=MeanQualityByCycle` argument in Picard.
</dd>
<dt id="RNAseq.sampleJobs.bamMetrics.picardMetrics.collectBaseDistributionByCycle"><a href="#RNAseq.sampleJobs.bamMetrics.picardMetrics.collectBaseDistributionByCycle">RNAseq.sampleJobs.bamMetrics.picardMetrics.collectBaseDistributionByCycle</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=CollectBaseDistributionByCycle` argument.
</dd>
<dt id="RNAseq.sampleJobs.bamMetrics.picardMetrics.collectGcBiasMetrics"><a href="#RNAseq.sampleJobs.bamMetrics.picardMetrics.collectGcBiasMetrics">RNAseq.sampleJobs.bamMetrics.picardMetrics.collectGcBiasMetrics</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=CollectGcBiasMetrics` argument.
</dd>
<dt id="RNAseq.sampleJobs.bamMetrics.picardMetrics.collectInsertSizeMetrics"><a href="#RNAseq.sampleJobs.bamMetrics.picardMetrics.collectInsertSizeMetrics">RNAseq.sampleJobs.bamMetrics.picardMetrics.collectInsertSizeMetrics</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=CollectInsertSizeMetrics` argument.
</dd>
<dt id="RNAseq.sampleJobs.bamMetrics.picardMetrics.collectQualityYieldMetrics"><a href="#RNAseq.sampleJobs.bamMetrics.picardMetrics.collectQualityYieldMetrics">RNAseq.sampleJobs.bamMetrics.picardMetrics.collectQualityYieldMetrics</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=CollectQualityYieldMetrics` argument.
</dd>
<dt id="RNAseq.sampleJobs.bamMetrics.picardMetrics.collectSequencingArtifactMetrics"><a href="#RNAseq.sampleJobs.bamMetrics.picardMetrics.collectSequencingArtifactMetrics">RNAseq.sampleJobs.bamMetrics.picardMetrics.collectSequencingArtifactMetrics</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=CollectSequencingArtifactMetrics` argument.
</dd>
<dt id="RNAseq.sampleJobs.bamMetrics.picardMetrics.javaXmxMb"><a href="#RNAseq.sampleJobs.bamMetrics.picardMetrics.javaXmxMb">RNAseq.sampleJobs.bamMetrics.picardMetrics.javaXmxMb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>3072</code><br />
    The maximum memory available to the program in megabytes. Should be lower than `memoryMb` to accommodate JVM overhead.
</dd>
<dt id="RNAseq.sampleJobs.bamMetrics.picardMetrics.memoryMb"><a href="#RNAseq.sampleJobs.bamMetrics.picardMetrics.memoryMb">RNAseq.sampleJobs.bamMetrics.picardMetrics.memoryMb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>javaXmxMb + 512</code><br />
    The amount of memory this job will use in megabytes.
</dd>
<dt id="RNAseq.sampleJobs.bamMetrics.picardMetrics.qualityScoreDistribution"><a href="#RNAseq.sampleJobs.bamMetrics.picardMetrics.qualityScoreDistribution">RNAseq.sampleJobs.bamMetrics.picardMetrics.qualityScoreDistribution</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to the `PROGRAM=QualityScoreDistribution` argument.
</dd>
<dt id="RNAseq.sampleJobs.bamMetrics.picardMetrics.timeMinutes"><a href="#RNAseq.sampleJobs.bamMetrics.picardMetrics.timeMinutes">RNAseq.sampleJobs.bamMetrics.picardMetrics.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil((size(referenceFasta,"G") * 3 * 2)) + ceil((size(inputBam,"G") * 6))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.sampleJobs.bamMetrics.rnaSeqMetrics.javaXmx"><a href="#RNAseq.sampleJobs.bamMetrics.rnaSeqMetrics.javaXmx">RNAseq.sampleJobs.bamMetrics.rnaSeqMetrics.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"8G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="RNAseq.sampleJobs.bamMetrics.rnaSeqMetrics.memory"><a href="#RNAseq.sampleJobs.bamMetrics.rnaSeqMetrics.memory">RNAseq.sampleJobs.bamMetrics.rnaSeqMetrics.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"9G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="RNAseq.sampleJobs.bamMetrics.rnaSeqMetrics.timeMinutes"><a href="#RNAseq.sampleJobs.bamMetrics.rnaSeqMetrics.timeMinutes">RNAseq.sampleJobs.bamMetrics.rnaSeqMetrics.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil((size(inputBam,"G") * 12))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.sampleJobs.bamMetrics.targetIntervalsLists.javaXmx"><a href="#RNAseq.sampleJobs.bamMetrics.targetIntervalsLists.javaXmx">RNAseq.sampleJobs.bamMetrics.targetIntervalsLists.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"3G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="RNAseq.sampleJobs.bamMetrics.targetIntervalsLists.memory"><a href="#RNAseq.sampleJobs.bamMetrics.targetIntervalsLists.memory">RNAseq.sampleJobs.bamMetrics.targetIntervalsLists.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="RNAseq.sampleJobs.bamMetrics.targetIntervalsLists.timeMinutes"><a href="#RNAseq.sampleJobs.bamMetrics.targetIntervalsLists.timeMinutes">RNAseq.sampleJobs.bamMetrics.targetIntervalsLists.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>5</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.sampleJobs.bamMetrics.targetMetrics.javaXmx"><a href="#RNAseq.sampleJobs.bamMetrics.targetMetrics.javaXmx">RNAseq.sampleJobs.bamMetrics.targetMetrics.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"3G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="RNAseq.sampleJobs.bamMetrics.targetMetrics.memory"><a href="#RNAseq.sampleJobs.bamMetrics.targetMetrics.memory">RNAseq.sampleJobs.bamMetrics.targetMetrics.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="RNAseq.sampleJobs.bamMetrics.targetMetrics.timeMinutes"><a href="#RNAseq.sampleJobs.bamMetrics.targetMetrics.timeMinutes">RNAseq.sampleJobs.bamMetrics.targetMetrics.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil((size(inputBam,"G") * 6))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.sampleJobs.hisat2.compressionLevel"><a href="#RNAseq.sampleJobs.hisat2.compressionLevel">RNAseq.sampleJobs.hisat2.compressionLevel</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The compression level of the output BAM.
</dd>
<dt id="RNAseq.sampleJobs.hisat2.downstreamTranscriptomeAssembly"><a href="#RNAseq.sampleJobs.hisat2.downstreamTranscriptomeAssembly">RNAseq.sampleJobs.hisat2.downstreamTranscriptomeAssembly</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    Equivalent to hisat2's `--dta` flag.
</dd>
<dt id="RNAseq.sampleJobs.hisat2.memoryGb"><a href="#RNAseq.sampleJobs.hisat2.memoryGb">RNAseq.sampleJobs.hisat2.memoryGb</a></dt>
<dd>
    <i>Int? </i><br />
    The amount of memory this job will use in gigabytes.
</dd>
<dt id="RNAseq.sampleJobs.hisat2.sortMemoryPerThreadGb"><a href="#RNAseq.sampleJobs.hisat2.sortMemoryPerThreadGb">RNAseq.sampleJobs.hisat2.sortMemoryPerThreadGb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>2</code><br />
    The amount of memory for each sorting thread in gigabytes.
</dd>
<dt id="RNAseq.sampleJobs.hisat2.sortThreads"><a href="#RNAseq.sampleJobs.hisat2.sortThreads">RNAseq.sampleJobs.hisat2.sortThreads</a></dt>
<dd>
    <i>Int? </i><br />
    The number of threads to use for sorting.
</dd>
<dt id="RNAseq.sampleJobs.hisat2.threads"><a href="#RNAseq.sampleJobs.hisat2.threads">RNAseq.sampleJobs.hisat2.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>4</code><br />
    The number of threads to use.
</dd>
<dt id="RNAseq.sampleJobs.hisat2.timeMinutes"><a href="#RNAseq.sampleJobs.hisat2.timeMinutes">RNAseq.sampleJobs.hisat2.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil((size([inputR1, inputR2],"G") * 180 / threads))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.sampleJobs.markDuplicates.compressionLevel"><a href="#RNAseq.sampleJobs.markDuplicates.compressionLevel">RNAseq.sampleJobs.markDuplicates.compressionLevel</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The compression level at which the BAM files are written.
</dd>
<dt id="RNAseq.sampleJobs.markDuplicates.createMd5File"><a href="#RNAseq.sampleJobs.markDuplicates.createMd5File">RNAseq.sampleJobs.markDuplicates.createMd5File</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether to create a md5 file for the created BAM file.
</dd>
<dt id="RNAseq.sampleJobs.markDuplicates.javaXmxMb"><a href="#RNAseq.sampleJobs.markDuplicates.javaXmxMb">RNAseq.sampleJobs.markDuplicates.javaXmxMb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>6656</code><br />
    The maximum memory available to the program in megabytes. Should be lower than `memoryMb` to accommodate JVM overhead.
</dd>
<dt id="RNAseq.sampleJobs.markDuplicates.memoryMb"><a href="#RNAseq.sampleJobs.markDuplicates.memoryMb">RNAseq.sampleJobs.markDuplicates.memoryMb</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>javaXmxMb + 512</code><br />
    The amount of memory this job will use in megabytes.
</dd>
<dt id="RNAseq.sampleJobs.markDuplicates.read_name_regex"><a href="#RNAseq.sampleJobs.markDuplicates.read_name_regex">RNAseq.sampleJobs.markDuplicates.read_name_regex</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to the `READ_NAME_REGEX` option of MarkDuplicates.
</dd>
<dt id="RNAseq.sampleJobs.markDuplicates.timeMinutes"><a href="#RNAseq.sampleJobs.markDuplicates.timeMinutes">RNAseq.sampleJobs.markDuplicates.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil((size(inputBams,"G") * 8))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.sampleJobs.markDuplicates.useJdkDeflater"><a href="#RNAseq.sampleJobs.markDuplicates.useJdkDeflater">RNAseq.sampleJobs.markDuplicates.useJdkDeflater</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    True, uses the java deflator to compress the BAM files. False uses the optimized intel deflater.
</dd>
<dt id="RNAseq.sampleJobs.markDuplicates.useJdkInflater"><a href="#RNAseq.sampleJobs.markDuplicates.useJdkInflater">RNAseq.sampleJobs.markDuplicates.useJdkInflater</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    True, uses the java inflater. False, uses the optimized intel inflater.
</dd>
<dt id="RNAseq.sampleJobs.postUmiDedupMarkDuplicates.compressionLevel"><a href="#RNAseq.sampleJobs.postUmiDedupMarkDuplicates.compressionLevel">RNAseq.sampleJobs.postUmiDedupMarkDuplicates.compressionLevel</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The compression level at which the BAM files are written.
</dd>
<dt id="RNAseq.sampleJobs.postUmiDedupMarkDuplicates.createMd5File"><a href="#RNAseq.sampleJobs.postUmiDedupMarkDuplicates.createMd5File">RNAseq.sampleJobs.postUmiDedupMarkDuplicates.createMd5File</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether to create a md5 file for the created BAM file.
</dd>
<dt id="RNAseq.sampleJobs.postUmiDedupMarkDuplicates.javaXmxMb"><a href="#RNAseq.sampleJobs.postUmiDedupMarkDuplicates.javaXmxMb">RNAseq.sampleJobs.postUmiDedupMarkDuplicates.javaXmxMb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>6656</code><br />
    The maximum memory available to the program in megabytes. Should be lower than `memoryMb` to accommodate JVM overhead.
</dd>
<dt id="RNAseq.sampleJobs.postUmiDedupMarkDuplicates.memoryMb"><a href="#RNAseq.sampleJobs.postUmiDedupMarkDuplicates.memoryMb">RNAseq.sampleJobs.postUmiDedupMarkDuplicates.memoryMb</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>javaXmxMb + 512</code><br />
    The amount of memory this job will use in megabytes.
</dd>
<dt id="RNAseq.sampleJobs.postUmiDedupMarkDuplicates.read_name_regex"><a href="#RNAseq.sampleJobs.postUmiDedupMarkDuplicates.read_name_regex">RNAseq.sampleJobs.postUmiDedupMarkDuplicates.read_name_regex</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to the `READ_NAME_REGEX` option of MarkDuplicates.
</dd>
<dt id="RNAseq.sampleJobs.postUmiDedupMarkDuplicates.timeMinutes"><a href="#RNAseq.sampleJobs.postUmiDedupMarkDuplicates.timeMinutes">RNAseq.sampleJobs.postUmiDedupMarkDuplicates.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil((size(inputBams,"G") * 8))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.sampleJobs.postUmiDedupMarkDuplicates.useJdkDeflater"><a href="#RNAseq.sampleJobs.postUmiDedupMarkDuplicates.useJdkDeflater">RNAseq.sampleJobs.postUmiDedupMarkDuplicates.useJdkDeflater</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    True, uses the java deflator to compress the BAM files. False uses the optimized intel deflater.
</dd>
<dt id="RNAseq.sampleJobs.postUmiDedupMarkDuplicates.useJdkInflater"><a href="#RNAseq.sampleJobs.postUmiDedupMarkDuplicates.useJdkInflater">RNAseq.sampleJobs.postUmiDedupMarkDuplicates.useJdkInflater</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    True, uses the java inflater. False, uses the optimized intel inflater.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.bwa"><a href="#RNAseq.sampleJobs.qc.Cutadapt.bwa">RNAseq.sampleJobs.qc.Cutadapt.bwa</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --bwa flag.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.colorspace"><a href="#RNAseq.sampleJobs.qc.Cutadapt.colorspace">RNAseq.sampleJobs.qc.Cutadapt.colorspace</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --colorspace flag.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.compressionLevel"><a href="#RNAseq.sampleJobs.qc.Cutadapt.compressionLevel">RNAseq.sampleJobs.qc.Cutadapt.compressionLevel</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The compression level if gzipped output is used.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.cores"><a href="#RNAseq.sampleJobs.qc.Cutadapt.cores">RNAseq.sampleJobs.qc.Cutadapt.cores</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>4</code><br />
    The number of cores to use.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.cut"><a href="#RNAseq.sampleJobs.qc.Cutadapt.cut">RNAseq.sampleJobs.qc.Cutadapt.cut</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to cutadapt's --cut option.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.discardTrimmed"><a href="#RNAseq.sampleJobs.qc.Cutadapt.discardTrimmed">RNAseq.sampleJobs.qc.Cutadapt.discardTrimmed</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --quality-cutoff option.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.discardUntrimmed"><a href="#RNAseq.sampleJobs.qc.Cutadapt.discardUntrimmed">RNAseq.sampleJobs.qc.Cutadapt.discardUntrimmed</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --discard-untrimmed option.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.doubleEncode"><a href="#RNAseq.sampleJobs.qc.Cutadapt.doubleEncode">RNAseq.sampleJobs.qc.Cutadapt.doubleEncode</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --double-encode flag.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.errorRate"><a href="#RNAseq.sampleJobs.qc.Cutadapt.errorRate">RNAseq.sampleJobs.qc.Cutadapt.errorRate</a></dt>
<dd>
    <i>Float? </i><br />
    Equivalent to cutadapt's --error-rate option.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.front"><a href="#RNAseq.sampleJobs.qc.Cutadapt.front">RNAseq.sampleJobs.qc.Cutadapt.front</a></dt>
<dd>
    <i>Array[String] </i><i>&mdash; Default:</i> <code>[]</code><br />
    A list of 5' ligated adapter sequences to be cut from the given first or single end fastq file.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.frontRead2"><a href="#RNAseq.sampleJobs.qc.Cutadapt.frontRead2">RNAseq.sampleJobs.qc.Cutadapt.frontRead2</a></dt>
<dd>
    <i>Array[String] </i><i>&mdash; Default:</i> <code>[]</code><br />
    A list of 5' ligated adapter sequences to be cut from the given second end fastq file.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.infoFilePath"><a href="#RNAseq.sampleJobs.qc.Cutadapt.infoFilePath">RNAseq.sampleJobs.qc.Cutadapt.infoFilePath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --info-file option.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.interleaved"><a href="#RNAseq.sampleJobs.qc.Cutadapt.interleaved">RNAseq.sampleJobs.qc.Cutadapt.interleaved</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --interleaved flag.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.length"><a href="#RNAseq.sampleJobs.qc.Cutadapt.length">RNAseq.sampleJobs.qc.Cutadapt.length</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to cutadapt's --length option.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.lengthTag"><a href="#RNAseq.sampleJobs.qc.Cutadapt.lengthTag">RNAseq.sampleJobs.qc.Cutadapt.lengthTag</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --length-tag option.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.maq"><a href="#RNAseq.sampleJobs.qc.Cutadapt.maq">RNAseq.sampleJobs.qc.Cutadapt.maq</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --maq flag.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.maskAdapter"><a href="#RNAseq.sampleJobs.qc.Cutadapt.maskAdapter">RNAseq.sampleJobs.qc.Cutadapt.maskAdapter</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --mask-adapter flag.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.matchReadWildcards"><a href="#RNAseq.sampleJobs.qc.Cutadapt.matchReadWildcards">RNAseq.sampleJobs.qc.Cutadapt.matchReadWildcards</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --match-read-wildcards flag.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.maximumLength"><a href="#RNAseq.sampleJobs.qc.Cutadapt.maximumLength">RNAseq.sampleJobs.qc.Cutadapt.maximumLength</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to cutadapt's --maximum-length option.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.maxN"><a href="#RNAseq.sampleJobs.qc.Cutadapt.maxN">RNAseq.sampleJobs.qc.Cutadapt.maxN</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to cutadapt's --max-n option.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.memory"><a href="#RNAseq.sampleJobs.qc.Cutadapt.memory">RNAseq.sampleJobs.qc.Cutadapt.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"5G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.minimumLength"><a href="#RNAseq.sampleJobs.qc.Cutadapt.minimumLength">RNAseq.sampleJobs.qc.Cutadapt.minimumLength</a></dt>
<dd>
    <i>Int? </i><i>&mdash; Default:</i> <code>2</code><br />
    Equivalent to cutadapt's --minimum-length option.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.nextseqTrim"><a href="#RNAseq.sampleJobs.qc.Cutadapt.nextseqTrim">RNAseq.sampleJobs.qc.Cutadapt.nextseqTrim</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --nextseq-trim option.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.noIndels"><a href="#RNAseq.sampleJobs.qc.Cutadapt.noIndels">RNAseq.sampleJobs.qc.Cutadapt.noIndels</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --no-indels flag.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.noMatchAdapterWildcards"><a href="#RNAseq.sampleJobs.qc.Cutadapt.noMatchAdapterWildcards">RNAseq.sampleJobs.qc.Cutadapt.noMatchAdapterWildcards</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --no-match-adapter-wildcards flag.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.noTrim"><a href="#RNAseq.sampleJobs.qc.Cutadapt.noTrim">RNAseq.sampleJobs.qc.Cutadapt.noTrim</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --no-trim flag.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.noZeroCap"><a href="#RNAseq.sampleJobs.qc.Cutadapt.noZeroCap">RNAseq.sampleJobs.qc.Cutadapt.noZeroCap</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --no-zero-cap flag.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.overlap"><a href="#RNAseq.sampleJobs.qc.Cutadapt.overlap">RNAseq.sampleJobs.qc.Cutadapt.overlap</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to cutadapt's --overlap option.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.pairFilter"><a href="#RNAseq.sampleJobs.qc.Cutadapt.pairFilter">RNAseq.sampleJobs.qc.Cutadapt.pairFilter</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --pair-filter option.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.prefix"><a href="#RNAseq.sampleJobs.qc.Cutadapt.prefix">RNAseq.sampleJobs.qc.Cutadapt.prefix</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --prefix option.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.qualityBase"><a href="#RNAseq.sampleJobs.qc.Cutadapt.qualityBase">RNAseq.sampleJobs.qc.Cutadapt.qualityBase</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to cutadapt's --quality-base option.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.qualityCutoff"><a href="#RNAseq.sampleJobs.qc.Cutadapt.qualityCutoff">RNAseq.sampleJobs.qc.Cutadapt.qualityCutoff</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --quality-cutoff option.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.restFilePath"><a href="#RNAseq.sampleJobs.qc.Cutadapt.restFilePath">RNAseq.sampleJobs.qc.Cutadapt.restFilePath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --rest-file option.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.stripF3"><a href="#RNAseq.sampleJobs.qc.Cutadapt.stripF3">RNAseq.sampleJobs.qc.Cutadapt.stripF3</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --strip-f3 flag.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.stripSuffix"><a href="#RNAseq.sampleJobs.qc.Cutadapt.stripSuffix">RNAseq.sampleJobs.qc.Cutadapt.stripSuffix</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --strip-suffix option.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.suffix"><a href="#RNAseq.sampleJobs.qc.Cutadapt.suffix">RNAseq.sampleJobs.qc.Cutadapt.suffix</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --suffix option.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.timeMinutes"><a href="#RNAseq.sampleJobs.qc.Cutadapt.timeMinutes">RNAseq.sampleJobs.qc.Cutadapt.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil((size([read1, read2],"G") * 12.0 / cores))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.times"><a href="#RNAseq.sampleJobs.qc.Cutadapt.times">RNAseq.sampleJobs.qc.Cutadapt.times</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to cutadapt's --times option.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.tooLongOutputPath"><a href="#RNAseq.sampleJobs.qc.Cutadapt.tooLongOutputPath">RNAseq.sampleJobs.qc.Cutadapt.tooLongOutputPath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --too-long-output option.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.tooLongPairedOutputPath"><a href="#RNAseq.sampleJobs.qc.Cutadapt.tooLongPairedOutputPath">RNAseq.sampleJobs.qc.Cutadapt.tooLongPairedOutputPath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --too-long-paired-output option.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.tooShortOutputPath"><a href="#RNAseq.sampleJobs.qc.Cutadapt.tooShortOutputPath">RNAseq.sampleJobs.qc.Cutadapt.tooShortOutputPath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --too-short-output option.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.tooShortPairedOutputPath"><a href="#RNAseq.sampleJobs.qc.Cutadapt.tooShortPairedOutputPath">RNAseq.sampleJobs.qc.Cutadapt.tooShortPairedOutputPath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --too-short-paired-output option.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.trimN"><a href="#RNAseq.sampleJobs.qc.Cutadapt.trimN">RNAseq.sampleJobs.qc.Cutadapt.trimN</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --trim-n flag.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.untrimmedOutputPath"><a href="#RNAseq.sampleJobs.qc.Cutadapt.untrimmedOutputPath">RNAseq.sampleJobs.qc.Cutadapt.untrimmedOutputPath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --untrimmed-output option.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.untrimmedPairedOutputPath"><a href="#RNAseq.sampleJobs.qc.Cutadapt.untrimmedPairedOutputPath">RNAseq.sampleJobs.qc.Cutadapt.untrimmedPairedOutputPath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --untrimmed-paired-output option.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.wildcardFilePath"><a href="#RNAseq.sampleJobs.qc.Cutadapt.wildcardFilePath">RNAseq.sampleJobs.qc.Cutadapt.wildcardFilePath</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to cutadapt's --wildcard-file option.
</dd>
<dt id="RNAseq.sampleJobs.qc.Cutadapt.zeroCap"><a href="#RNAseq.sampleJobs.qc.Cutadapt.zeroCap">RNAseq.sampleJobs.qc.Cutadapt.zeroCap</a></dt>
<dd>
    <i>Boolean? </i><br />
    Equivalent to cutadapt's --zero-cap flag.
</dd>
<dt id="RNAseq.sampleJobs.qc.extractFastqcZip"><a href="#RNAseq.sampleJobs.qc.extractFastqcZip">RNAseq.sampleJobs.qc.extractFastqcZip</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Whether to extract Fastqc's report zip files.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead1.adapters"><a href="#RNAseq.sampleJobs.qc.FastqcRead1.adapters">RNAseq.sampleJobs.qc.FastqcRead1.adapters</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --adapters option.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead1.casava"><a href="#RNAseq.sampleJobs.qc.FastqcRead1.casava">RNAseq.sampleJobs.qc.FastqcRead1.casava</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --casava flag.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead1.contaminants"><a href="#RNAseq.sampleJobs.qc.FastqcRead1.contaminants">RNAseq.sampleJobs.qc.FastqcRead1.contaminants</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --contaminants option.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead1.dir"><a href="#RNAseq.sampleJobs.qc.FastqcRead1.dir">RNAseq.sampleJobs.qc.FastqcRead1.dir</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --dir option.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead1.format"><a href="#RNAseq.sampleJobs.qc.FastqcRead1.format">RNAseq.sampleJobs.qc.FastqcRead1.format</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --format option.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead1.javaXmx"><a href="#RNAseq.sampleJobs.qc.FastqcRead1.javaXmx">RNAseq.sampleJobs.qc.FastqcRead1.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"1750M"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead1.kmers"><a href="#RNAseq.sampleJobs.qc.FastqcRead1.kmers">RNAseq.sampleJobs.qc.FastqcRead1.kmers</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --kmers option.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead1.limits"><a href="#RNAseq.sampleJobs.qc.FastqcRead1.limits">RNAseq.sampleJobs.qc.FastqcRead1.limits</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --limits option.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead1.memory"><a href="#RNAseq.sampleJobs.qc.FastqcRead1.memory">RNAseq.sampleJobs.qc.FastqcRead1.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"2G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead1.minLength"><a href="#RNAseq.sampleJobs.qc.FastqcRead1.minLength">RNAseq.sampleJobs.qc.FastqcRead1.minLength</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --min_length option.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead1.nano"><a href="#RNAseq.sampleJobs.qc.FastqcRead1.nano">RNAseq.sampleJobs.qc.FastqcRead1.nano</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nano flag.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead1.noFilter"><a href="#RNAseq.sampleJobs.qc.FastqcRead1.noFilter">RNAseq.sampleJobs.qc.FastqcRead1.noFilter</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nofilter flag.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead1.nogroup"><a href="#RNAseq.sampleJobs.qc.FastqcRead1.nogroup">RNAseq.sampleJobs.qc.FastqcRead1.nogroup</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nogroup flag.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead1.threads"><a href="#RNAseq.sampleJobs.qc.FastqcRead1.threads">RNAseq.sampleJobs.qc.FastqcRead1.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of cores to use.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead1.timeMinutes"><a href="#RNAseq.sampleJobs.qc.FastqcRead1.timeMinutes">RNAseq.sampleJobs.qc.FastqcRead1.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil(size(seqFile,"G")) * 4</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead1After.adapters"><a href="#RNAseq.sampleJobs.qc.FastqcRead1After.adapters">RNAseq.sampleJobs.qc.FastqcRead1After.adapters</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --adapters option.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead1After.casava"><a href="#RNAseq.sampleJobs.qc.FastqcRead1After.casava">RNAseq.sampleJobs.qc.FastqcRead1After.casava</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --casava flag.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead1After.contaminants"><a href="#RNAseq.sampleJobs.qc.FastqcRead1After.contaminants">RNAseq.sampleJobs.qc.FastqcRead1After.contaminants</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --contaminants option.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead1After.dir"><a href="#RNAseq.sampleJobs.qc.FastqcRead1After.dir">RNAseq.sampleJobs.qc.FastqcRead1After.dir</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --dir option.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead1After.format"><a href="#RNAseq.sampleJobs.qc.FastqcRead1After.format">RNAseq.sampleJobs.qc.FastqcRead1After.format</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --format option.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead1After.javaXmx"><a href="#RNAseq.sampleJobs.qc.FastqcRead1After.javaXmx">RNAseq.sampleJobs.qc.FastqcRead1After.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"1750M"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead1After.kmers"><a href="#RNAseq.sampleJobs.qc.FastqcRead1After.kmers">RNAseq.sampleJobs.qc.FastqcRead1After.kmers</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --kmers option.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead1After.limits"><a href="#RNAseq.sampleJobs.qc.FastqcRead1After.limits">RNAseq.sampleJobs.qc.FastqcRead1After.limits</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --limits option.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead1After.memory"><a href="#RNAseq.sampleJobs.qc.FastqcRead1After.memory">RNAseq.sampleJobs.qc.FastqcRead1After.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"2G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead1After.minLength"><a href="#RNAseq.sampleJobs.qc.FastqcRead1After.minLength">RNAseq.sampleJobs.qc.FastqcRead1After.minLength</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --min_length option.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead1After.nano"><a href="#RNAseq.sampleJobs.qc.FastqcRead1After.nano">RNAseq.sampleJobs.qc.FastqcRead1After.nano</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nano flag.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead1After.noFilter"><a href="#RNAseq.sampleJobs.qc.FastqcRead1After.noFilter">RNAseq.sampleJobs.qc.FastqcRead1After.noFilter</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nofilter flag.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead1After.nogroup"><a href="#RNAseq.sampleJobs.qc.FastqcRead1After.nogroup">RNAseq.sampleJobs.qc.FastqcRead1After.nogroup</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nogroup flag.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead1After.threads"><a href="#RNAseq.sampleJobs.qc.FastqcRead1After.threads">RNAseq.sampleJobs.qc.FastqcRead1After.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of cores to use.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead1After.timeMinutes"><a href="#RNAseq.sampleJobs.qc.FastqcRead1After.timeMinutes">RNAseq.sampleJobs.qc.FastqcRead1After.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil(size(seqFile,"G")) * 4</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead2.adapters"><a href="#RNAseq.sampleJobs.qc.FastqcRead2.adapters">RNAseq.sampleJobs.qc.FastqcRead2.adapters</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --adapters option.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead2.casava"><a href="#RNAseq.sampleJobs.qc.FastqcRead2.casava">RNAseq.sampleJobs.qc.FastqcRead2.casava</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --casava flag.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead2.contaminants"><a href="#RNAseq.sampleJobs.qc.FastqcRead2.contaminants">RNAseq.sampleJobs.qc.FastqcRead2.contaminants</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --contaminants option.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead2.dir"><a href="#RNAseq.sampleJobs.qc.FastqcRead2.dir">RNAseq.sampleJobs.qc.FastqcRead2.dir</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --dir option.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead2.format"><a href="#RNAseq.sampleJobs.qc.FastqcRead2.format">RNAseq.sampleJobs.qc.FastqcRead2.format</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --format option.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead2.javaXmx"><a href="#RNAseq.sampleJobs.qc.FastqcRead2.javaXmx">RNAseq.sampleJobs.qc.FastqcRead2.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"1750M"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead2.kmers"><a href="#RNAseq.sampleJobs.qc.FastqcRead2.kmers">RNAseq.sampleJobs.qc.FastqcRead2.kmers</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --kmers option.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead2.limits"><a href="#RNAseq.sampleJobs.qc.FastqcRead2.limits">RNAseq.sampleJobs.qc.FastqcRead2.limits</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --limits option.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead2.memory"><a href="#RNAseq.sampleJobs.qc.FastqcRead2.memory">RNAseq.sampleJobs.qc.FastqcRead2.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"2G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead2.minLength"><a href="#RNAseq.sampleJobs.qc.FastqcRead2.minLength">RNAseq.sampleJobs.qc.FastqcRead2.minLength</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --min_length option.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead2.nano"><a href="#RNAseq.sampleJobs.qc.FastqcRead2.nano">RNAseq.sampleJobs.qc.FastqcRead2.nano</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nano flag.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead2.noFilter"><a href="#RNAseq.sampleJobs.qc.FastqcRead2.noFilter">RNAseq.sampleJobs.qc.FastqcRead2.noFilter</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nofilter flag.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead2.nogroup"><a href="#RNAseq.sampleJobs.qc.FastqcRead2.nogroup">RNAseq.sampleJobs.qc.FastqcRead2.nogroup</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nogroup flag.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead2.threads"><a href="#RNAseq.sampleJobs.qc.FastqcRead2.threads">RNAseq.sampleJobs.qc.FastqcRead2.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of cores to use.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead2.timeMinutes"><a href="#RNAseq.sampleJobs.qc.FastqcRead2.timeMinutes">RNAseq.sampleJobs.qc.FastqcRead2.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil(size(seqFile,"G")) * 4</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead2After.adapters"><a href="#RNAseq.sampleJobs.qc.FastqcRead2After.adapters">RNAseq.sampleJobs.qc.FastqcRead2After.adapters</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --adapters option.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead2After.casava"><a href="#RNAseq.sampleJobs.qc.FastqcRead2After.casava">RNAseq.sampleJobs.qc.FastqcRead2After.casava</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --casava flag.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead2After.contaminants"><a href="#RNAseq.sampleJobs.qc.FastqcRead2After.contaminants">RNAseq.sampleJobs.qc.FastqcRead2After.contaminants</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --contaminants option.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead2After.dir"><a href="#RNAseq.sampleJobs.qc.FastqcRead2After.dir">RNAseq.sampleJobs.qc.FastqcRead2After.dir</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --dir option.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead2After.format"><a href="#RNAseq.sampleJobs.qc.FastqcRead2After.format">RNAseq.sampleJobs.qc.FastqcRead2After.format</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to fastqc's --format option.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead2After.javaXmx"><a href="#RNAseq.sampleJobs.qc.FastqcRead2After.javaXmx">RNAseq.sampleJobs.qc.FastqcRead2After.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"1750M"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead2After.kmers"><a href="#RNAseq.sampleJobs.qc.FastqcRead2After.kmers">RNAseq.sampleJobs.qc.FastqcRead2After.kmers</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --kmers option.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead2After.limits"><a href="#RNAseq.sampleJobs.qc.FastqcRead2After.limits">RNAseq.sampleJobs.qc.FastqcRead2After.limits</a></dt>
<dd>
    <i>File? </i><br />
    Equivalent to fastqc's --limits option.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead2After.memory"><a href="#RNAseq.sampleJobs.qc.FastqcRead2After.memory">RNAseq.sampleJobs.qc.FastqcRead2After.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"2G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead2After.minLength"><a href="#RNAseq.sampleJobs.qc.FastqcRead2After.minLength">RNAseq.sampleJobs.qc.FastqcRead2After.minLength</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to fastqc's --min_length option.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead2After.nano"><a href="#RNAseq.sampleJobs.qc.FastqcRead2After.nano">RNAseq.sampleJobs.qc.FastqcRead2After.nano</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nano flag.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead2After.noFilter"><a href="#RNAseq.sampleJobs.qc.FastqcRead2After.noFilter">RNAseq.sampleJobs.qc.FastqcRead2After.noFilter</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nofilter flag.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead2After.nogroup"><a href="#RNAseq.sampleJobs.qc.FastqcRead2After.nogroup">RNAseq.sampleJobs.qc.FastqcRead2After.nogroup</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Equivalent to fastqc's --nogroup flag.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead2After.threads"><a href="#RNAseq.sampleJobs.qc.FastqcRead2After.threads">RNAseq.sampleJobs.qc.FastqcRead2After.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The number of cores to use.
</dd>
<dt id="RNAseq.sampleJobs.qc.FastqcRead2After.timeMinutes"><a href="#RNAseq.sampleJobs.qc.FastqcRead2After.timeMinutes">RNAseq.sampleJobs.qc.FastqcRead2After.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil(size(seqFile,"G")) * 4</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.sampleJobs.qc.runAdapterClipping"><a href="#RNAseq.sampleJobs.qc.runAdapterClipping">RNAseq.sampleJobs.qc.runAdapterClipping</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>defined(adapterForward) || defined(adapterReverse) || length(select_first([contaminations, []])) > 0</code><br />
    Whether or not adapters should be removed from the reads.
</dd>
<dt id="RNAseq.sampleJobs.star.limitBAMsortRAM"><a href="#RNAseq.sampleJobs.star.limitBAMsortRAM">RNAseq.sampleJobs.star.limitBAMsortRAM</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to star's `--limitBAMsortRAM` option.
</dd>
<dt id="RNAseq.sampleJobs.star.memory"><a href="#RNAseq.sampleJobs.star.memory">RNAseq.sampleJobs.star.memory</a></dt>
<dd>
    <i>String? </i><br />
    The amount of memory this job will use.
</dd>
<dt id="RNAseq.sampleJobs.star.outBAMcompression"><a href="#RNAseq.sampleJobs.star.outBAMcompression">RNAseq.sampleJobs.star.outBAMcompression</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The compression level of the output BAM.
</dd>
<dt id="RNAseq.sampleJobs.star.outFilterMatchNmin"><a href="#RNAseq.sampleJobs.star.outFilterMatchNmin">RNAseq.sampleJobs.star.outFilterMatchNmin</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to star's `--outFilterMatchNmin` option.
</dd>
<dt id="RNAseq.sampleJobs.star.outFilterMatchNminOverLread"><a href="#RNAseq.sampleJobs.star.outFilterMatchNminOverLread">RNAseq.sampleJobs.star.outFilterMatchNminOverLread</a></dt>
<dd>
    <i>Float? </i><br />
    Equivalent to star's `--outFilterMatchNminOverLread` option.
</dd>
<dt id="RNAseq.sampleJobs.star.outFilterScoreMin"><a href="#RNAseq.sampleJobs.star.outFilterScoreMin">RNAseq.sampleJobs.star.outFilterScoreMin</a></dt>
<dd>
    <i>Int? </i><br />
    Equivalent to star's `--outFilterScoreMin` option.
</dd>
<dt id="RNAseq.sampleJobs.star.outFilterScoreMinOverLread"><a href="#RNAseq.sampleJobs.star.outFilterScoreMinOverLread">RNAseq.sampleJobs.star.outFilterScoreMinOverLread</a></dt>
<dd>
    <i>Float? </i><br />
    Equivalent to star's `--outFilterScoreMinOverLread` option.
</dd>
<dt id="RNAseq.sampleJobs.star.outSAMunmapped"><a href="#RNAseq.sampleJobs.star.outSAMunmapped">RNAseq.sampleJobs.star.outSAMunmapped</a></dt>
<dd>
    <i>String? </i><i>&mdash; Default:</i> <code>"Within KeepPairs"</code><br />
    Equivalent to star's `--outSAMunmapped` option.
</dd>
<dt id="RNAseq.sampleJobs.star.outStd"><a href="#RNAseq.sampleJobs.star.outStd">RNAseq.sampleJobs.star.outStd</a></dt>
<dd>
    <i>String? </i><br />
    Equivalent to star's `--outStd` option.
</dd>
<dt id="RNAseq.sampleJobs.star.runThreadN"><a href="#RNAseq.sampleJobs.star.runThreadN">RNAseq.sampleJobs.star.runThreadN</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>4</code><br />
    The number of threads to use.
</dd>
<dt id="RNAseq.sampleJobs.star.timeMinutes"><a href="#RNAseq.sampleJobs.star.timeMinutes">RNAseq.sampleJobs.star.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil(size(indexFiles,"G")) + ceil((size(flatten([inputR1, inputR2]),"G") * 300 / runThreadN))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.sampleJobs.star.twopassMode"><a href="#RNAseq.sampleJobs.star.twopassMode">RNAseq.sampleJobs.star.twopassMode</a></dt>
<dd>
    <i>String? </i><i>&mdash; Default:</i> <code>"Basic"</code><br />
    Equivalent to star's `--twopassMode` option.
</dd>
<dt id="RNAseq.sampleJobs.umiDedup.memory"><a href="#RNAseq.sampleJobs.umiDedup.memory">RNAseq.sampleJobs.umiDedup.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"25G"</code><br />
    The amount of memory required for the task.
</dd>
<dt id="RNAseq.sampleJobs.umiDedup.timeMinutes"><a href="#RNAseq.sampleJobs.umiDedup.timeMinutes">RNAseq.sampleJobs.umiDedup.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>30 + ceil((size(inputBam,"G") * 30))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.sampleJobs.umiDedup.tmpDir"><a href="#RNAseq.sampleJobs.umiDedup.tmpDir">RNAseq.sampleJobs.umiDedup.tmpDir</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"./umiToolsDedupTmpDir"</code><br />
    Temporary directory.
</dd>
<dt id="RNAseq.sampleJobs.umiDedup.umiSeparator"><a href="#RNAseq.sampleJobs.umiDedup.umiSeparator">RNAseq.sampleJobs.umiDedup.umiSeparator</a></dt>
<dd>
    <i>String? </i><br />
    Seperator used for UMIs in the read names.
</dd>
<dt id="RNAseq.scatterList.memory"><a href="#RNAseq.scatterList.memory">RNAseq.scatterList.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"256M"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="RNAseq.scatterList.prefix"><a href="#RNAseq.scatterList.prefix">RNAseq.scatterList.prefix</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"scatters/scatter-"</code><br />
    The prefix of the ouput files. Output will be named like: <PREFIX><N>.bed, in which N is an incrementing number. Default 'scatter-'.
</dd>
<dt id="RNAseq.scatterList.splitContigs"><a href="#RNAseq.scatterList.splitContigs">RNAseq.scatterList.splitContigs</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    If set, contigs are allowed to be split up over multiple files.
</dd>
<dt id="RNAseq.scatterList.timeMinutes"><a href="#RNAseq.scatterList.timeMinutes">RNAseq.scatterList.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>2</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.scatterSize"><a href="#RNAseq.scatterSize">RNAseq.scatterSize</a></dt>
<dd>
    <i>Int? </i><br />
    The size of the scattered regions in bases for the GATK subworkflows. Scattering is used to speed up certain processes. The genome will be seperated into multiple chunks (scatters) which will be processed in their own job, allowing for parallel processing. Higher values will result in a lower number of jobs. The optimal value here will depend on the available resources.
</dd>
<dt id="RNAseq.scatterSizeMillions"><a href="#RNAseq.scatterSizeMillions">RNAseq.scatterSizeMillions</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1000</code><br />
    Same as scatterSize, but is multiplied by 1000000 to get scatterSize. This allows for setting larger values more easily.
</dd>
<dt id="RNAseq.variantcalling.callAutosomal.contamination"><a href="#RNAseq.variantcalling.callAutosomal.contamination">RNAseq.variantcalling.callAutosomal.contamination</a></dt>
<dd>
    <i>Float? </i><br />
    Equivalent to HaplotypeCaller's `-contamination` option.
</dd>
<dt id="RNAseq.variantcalling.callAutosomal.emitRefConfidence"><a href="#RNAseq.variantcalling.callAutosomal.emitRefConfidence">RNAseq.variantcalling.callAutosomal.emitRefConfidence</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>if gvcf then "GVCF" else "NONE"</code><br />
    Whether to include reference calls. Three modes: 'NONE', 'BP_RESOLUTION' and 'GVCF'.
</dd>
<dt id="RNAseq.variantcalling.callAutosomal.javaXmxMb"><a href="#RNAseq.variantcalling.callAutosomal.javaXmxMb">RNAseq.variantcalling.callAutosomal.javaXmxMb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>4096</code><br />
    The maximum memory available to the program in megabytes. Should be lower than `memoryMb` to accommodate JVM overhead.
</dd>
<dt id="RNAseq.variantcalling.callAutosomal.memoryMb"><a href="#RNAseq.variantcalling.callAutosomal.memoryMb">RNAseq.variantcalling.callAutosomal.memoryMb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>javaXmxMb + 512</code><br />
    The amount of memory this job will use in megabytes.
</dd>
<dt id="RNAseq.variantcalling.callAutosomal.outputMode"><a href="#RNAseq.variantcalling.callAutosomal.outputMode">RNAseq.variantcalling.callAutosomal.outputMode</a></dt>
<dd>
    <i>String? </i><br />
    Specifies which type of calls we should output. Same as HaplotypeCaller's `--output-mode` option.
</dd>
<dt id="RNAseq.variantcalling.callX.contamination"><a href="#RNAseq.variantcalling.callX.contamination">RNAseq.variantcalling.callX.contamination</a></dt>
<dd>
    <i>Float? </i><br />
    Equivalent to HaplotypeCaller's `-contamination` option.
</dd>
<dt id="RNAseq.variantcalling.callX.emitRefConfidence"><a href="#RNAseq.variantcalling.callX.emitRefConfidence">RNAseq.variantcalling.callX.emitRefConfidence</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>if gvcf then "GVCF" else "NONE"</code><br />
    Whether to include reference calls. Three modes: 'NONE', 'BP_RESOLUTION' and 'GVCF'.
</dd>
<dt id="RNAseq.variantcalling.callX.javaXmxMb"><a href="#RNAseq.variantcalling.callX.javaXmxMb">RNAseq.variantcalling.callX.javaXmxMb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>4096</code><br />
    The maximum memory available to the program in megabytes. Should be lower than `memoryMb` to accommodate JVM overhead.
</dd>
<dt id="RNAseq.variantcalling.callX.memoryMb"><a href="#RNAseq.variantcalling.callX.memoryMb">RNAseq.variantcalling.callX.memoryMb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>javaXmxMb + 512</code><br />
    The amount of memory this job will use in megabytes.
</dd>
<dt id="RNAseq.variantcalling.callX.outputMode"><a href="#RNAseq.variantcalling.callX.outputMode">RNAseq.variantcalling.callX.outputMode</a></dt>
<dd>
    <i>String? </i><br />
    Specifies which type of calls we should output. Same as HaplotypeCaller's `--output-mode` option.
</dd>
<dt id="RNAseq.variantcalling.callY.contamination"><a href="#RNAseq.variantcalling.callY.contamination">RNAseq.variantcalling.callY.contamination</a></dt>
<dd>
    <i>Float? </i><br />
    Equivalent to HaplotypeCaller's `-contamination` option.
</dd>
<dt id="RNAseq.variantcalling.callY.emitRefConfidence"><a href="#RNAseq.variantcalling.callY.emitRefConfidence">RNAseq.variantcalling.callY.emitRefConfidence</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>if gvcf then "GVCF" else "NONE"</code><br />
    Whether to include reference calls. Three modes: 'NONE', 'BP_RESOLUTION' and 'GVCF'.
</dd>
<dt id="RNAseq.variantcalling.callY.javaXmxMb"><a href="#RNAseq.variantcalling.callY.javaXmxMb">RNAseq.variantcalling.callY.javaXmxMb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>4096</code><br />
    The maximum memory available to the program in megabytes. Should be lower than `memoryMb` to accommodate JVM overhead.
</dd>
<dt id="RNAseq.variantcalling.callY.memoryMb"><a href="#RNAseq.variantcalling.callY.memoryMb">RNAseq.variantcalling.callY.memoryMb</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>javaXmxMb + 512</code><br />
    The amount of memory this job will use in megabytes.
</dd>
<dt id="RNAseq.variantcalling.callY.outputMode"><a href="#RNAseq.variantcalling.callY.outputMode">RNAseq.variantcalling.callY.outputMode</a></dt>
<dd>
    <i>String? </i><br />
    Specifies which type of calls we should output. Same as HaplotypeCaller's `--output-mode` option.
</dd>
<dt id="RNAseq.variantcalling.mergeSingleSampleGvcf.intervals"><a href="#RNAseq.variantcalling.mergeSingleSampleGvcf.intervals">RNAseq.variantcalling.mergeSingleSampleGvcf.intervals</a></dt>
<dd>
    <i>Array[File] </i><i>&mdash; Default:</i> <code>[]</code><br />
    Bed files or interval lists describing the regions to operate on.
</dd>
<dt id="RNAseq.variantcalling.mergeSingleSampleGvcf.javaXmx"><a href="#RNAseq.variantcalling.mergeSingleSampleGvcf.javaXmx">RNAseq.variantcalling.mergeSingleSampleGvcf.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="RNAseq.variantcalling.mergeSingleSampleGvcf.memory"><a href="#RNAseq.variantcalling.mergeSingleSampleGvcf.memory">RNAseq.variantcalling.mergeSingleSampleGvcf.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"5G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="RNAseq.variantcalling.mergeSingleSampleGvcf.timeMinutes"><a href="#RNAseq.variantcalling.mergeSingleSampleGvcf.timeMinutes">RNAseq.variantcalling.mergeSingleSampleGvcf.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil((size(gvcfFiles,"G") * 8))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.variantcalling.mergeSingleSampleVcf.compressionLevel"><a href="#RNAseq.variantcalling.mergeSingleSampleVcf.compressionLevel">RNAseq.variantcalling.mergeSingleSampleVcf.compressionLevel</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1</code><br />
    The compression level at which the BAM files are written.
</dd>
<dt id="RNAseq.variantcalling.mergeSingleSampleVcf.javaXmx"><a href="#RNAseq.variantcalling.mergeSingleSampleVcf.javaXmx">RNAseq.variantcalling.mergeSingleSampleVcf.javaXmx</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"4G"</code><br />
    The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</dd>
<dt id="RNAseq.variantcalling.mergeSingleSampleVcf.memory"><a href="#RNAseq.variantcalling.mergeSingleSampleVcf.memory">RNAseq.variantcalling.mergeSingleSampleVcf.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"5G"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="RNAseq.variantcalling.mergeSingleSampleVcf.timeMinutes"><a href="#RNAseq.variantcalling.mergeSingleSampleVcf.timeMinutes">RNAseq.variantcalling.mergeSingleSampleVcf.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + ceil(size(inputVCFs,"G")) * 2</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.variantcalling.mergeSingleSampleVcf.useJdkDeflater"><a href="#RNAseq.variantcalling.mergeSingleSampleVcf.useJdkDeflater">RNAseq.variantcalling.mergeSingleSampleVcf.useJdkDeflater</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    True, uses the java deflator to compress the BAM files. False uses the optimized intel deflater.
</dd>
<dt id="RNAseq.variantcalling.mergeSingleSampleVcf.useJdkInflater"><a href="#RNAseq.variantcalling.mergeSingleSampleVcf.useJdkInflater">RNAseq.variantcalling.mergeSingleSampleVcf.useJdkInflater</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>true</code><br />
    True, uses the java inflater. False, uses the optimized intel inflater.
</dd>
<dt id="RNAseq.variantcalling.Stats.afBins"><a href="#RNAseq.variantcalling.Stats.afBins">RNAseq.variantcalling.Stats.afBins</a></dt>
<dd>
    <i>String? </i><br />
    Allele frequency bins, a list (0.1,0.5,1) or a file (0.1
0.5
1).
</dd>
<dt id="RNAseq.variantcalling.Stats.applyFilters"><a href="#RNAseq.variantcalling.Stats.applyFilters">RNAseq.variantcalling.Stats.applyFilters</a></dt>
<dd>
    <i>String? </i><br />
    Require at least one of the listed FILTER strings (e.g. "PASS,.").
</dd>
<dt id="RNAseq.variantcalling.Stats.collapse"><a href="#RNAseq.variantcalling.Stats.collapse">RNAseq.variantcalling.Stats.collapse</a></dt>
<dd>
    <i>String? </i><br />
    Treat as identical records with <snps|indels|both|all|some|none>, see man page for details.
</dd>
<dt id="RNAseq.variantcalling.Stats.depth"><a href="#RNAseq.variantcalling.Stats.depth">RNAseq.variantcalling.Stats.depth</a></dt>
<dd>
    <i>String? </i><br />
    Depth distribution: min,max,bin size [0,500,1].
</dd>
<dt id="RNAseq.variantcalling.Stats.exclude"><a href="#RNAseq.variantcalling.Stats.exclude">RNAseq.variantcalling.Stats.exclude</a></dt>
<dd>
    <i>String? </i><br />
    Exclude sites for which the expression is true (see man page for details).
</dd>
<dt id="RNAseq.variantcalling.Stats.exons"><a href="#RNAseq.variantcalling.Stats.exons">RNAseq.variantcalling.Stats.exons</a></dt>
<dd>
    <i>File? </i><br />
    Tab-delimited file with exons for indel frameshifts (chr,from,to; 1-based, inclusive, bgzip compressed).
</dd>
<dt id="RNAseq.variantcalling.Stats.firstAlleleOnly"><a href="#RNAseq.variantcalling.Stats.firstAlleleOnly">RNAseq.variantcalling.Stats.firstAlleleOnly</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Include only 1st allele at multiallelic sites.
</dd>
<dt id="RNAseq.variantcalling.Stats.include"><a href="#RNAseq.variantcalling.Stats.include">RNAseq.variantcalling.Stats.include</a></dt>
<dd>
    <i>String? </i><br />
    Select sites for which the expression is true (see man page for details).
</dd>
<dt id="RNAseq.variantcalling.Stats.memory"><a href="#RNAseq.variantcalling.Stats.memory">RNAseq.variantcalling.Stats.memory</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"256M"</code><br />
    The amount of memory this job will use.
</dd>
<dt id="RNAseq.variantcalling.Stats.regions"><a href="#RNAseq.variantcalling.Stats.regions">RNAseq.variantcalling.Stats.regions</a></dt>
<dd>
    <i>String? </i><br />
    Restrict to comma-separated list of regions.
</dd>
<dt id="RNAseq.variantcalling.Stats.samplesFile"><a href="#RNAseq.variantcalling.Stats.samplesFile">RNAseq.variantcalling.Stats.samplesFile</a></dt>
<dd>
    <i>File? </i><br />
    File of samples to include.
</dd>
<dt id="RNAseq.variantcalling.Stats.splitByID"><a href="#RNAseq.variantcalling.Stats.splitByID">RNAseq.variantcalling.Stats.splitByID</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Collect stats for sites with ID separately (known vs novel).
</dd>
<dt id="RNAseq.variantcalling.Stats.targets"><a href="#RNAseq.variantcalling.Stats.targets">RNAseq.variantcalling.Stats.targets</a></dt>
<dd>
    <i>String? </i><br />
    Similar to regions but streams rather than index-jumps.
</dd>
<dt id="RNAseq.variantcalling.Stats.targetsFile"><a href="#RNAseq.variantcalling.Stats.targetsFile">RNAseq.variantcalling.Stats.targetsFile</a></dt>
<dd>
    <i>File? </i><br />
    Similar to regionsFile but streams rather than index-jumps.
</dd>
<dt id="RNAseq.variantcalling.Stats.threads"><a href="#RNAseq.variantcalling.Stats.threads">RNAseq.variantcalling.Stats.threads</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>0</code><br />
    Number of extra decompression threads [0].
</dd>
<dt id="RNAseq.variantcalling.Stats.timeMinutes"><a href="#RNAseq.variantcalling.Stats.timeMinutes">RNAseq.variantcalling.Stats.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>1 + 2 * ceil(size(select_all([inputVcf, compareVcf]),"G"))</code><br />
    The maximum amount of time the job will run in minutes.
</dd>
<dt id="RNAseq.variantcalling.Stats.userTsTv"><a href="#RNAseq.variantcalling.Stats.userTsTv">RNAseq.variantcalling.Stats.userTsTv</a></dt>
<dd>
    <i>String? </i><br />
    <TAG[:min:max:n]>. Collect Ts/Tv stats for any tag using the given binning [0:1:100].
</dd>
<dt id="RNAseq.variantcalling.Stats.verbose"><a href="#RNAseq.variantcalling.Stats.verbose">RNAseq.variantcalling.Stats.verbose</a></dt>
<dd>
    <i>Boolean </i><i>&mdash; Default:</i> <code>false</code><br />
    Produce verbose per-site and per-sample output.
</dd>
<dt id="RNAseq.variantcalling.statsRegions"><a href="#RNAseq.variantcalling.statsRegions">RNAseq.variantcalling.statsRegions</a></dt>
<dd>
    <i>File? </i><br />
    Which regions need to be analysed by the stats tools.
</dd>
<dt id="RNAseq.variantcalling.timeMinutes"><a href="#RNAseq.variantcalling.timeMinutes">RNAseq.variantcalling.timeMinutes</a></dt>
<dd>
    <i>Int </i><i>&mdash; Default:</i> <code>ceil((size(bam,"G") * 120))</code><br />
    The time in minutes expected for each haplotype caller task. Will be exposed as the time_minutes runtime attribute.
</dd>
<dt id="RNAseq.XNonParRegions"><a href="#RNAseq.XNonParRegions">RNAseq.XNonParRegions</a></dt>
<dd>
    <i>File? </i><br />
    Bed file with the non-PAR regions of X for variant calling.
</dd>
<dt id="RNAseq.YNonParRegions"><a href="#RNAseq.YNonParRegions">RNAseq.YNonParRegions</a></dt>
<dd>
    <i>File? </i><br />
    Bed file with the non-PAR regions of Y for variant calling.
</dd>
</dl>
</details>



## Other inputs
<details>
<summary> Show/Hide </summary>
<dl>
<dt id="RNAseq.makeStarIndex.genomeDir"><a href="#RNAseq.makeStarIndex.genomeDir">RNAseq.makeStarIndex.genomeDir</a></dt>
<dd>
    <i>String </i><i>&mdash; Default:</i> <code>"STAR_index"</code><br />
    The directory the STAR index should be written to.
</dd>
</dl>
</details>



## Do not set these inputs!
The following inputs should ***not*** be set, even though womtool may
show them as being available inputs.

* RNAseq.sampleJobs.star.outSAMtype
* RNAseq.sampleJobs.star.readFilesCommand
* RNAseq.sampleJobs.DONOTDEFINE
* RNAseq.sampleJobs.qc.FastqcRead1.noneFile
* RNAseq.sampleJobs.qc.FastqcRead1.noneArray
* RNAseq.sampleJobs.qc.FastqcRead2.noneFile
* RNAseq.sampleJobs.qc.FastqcRead2.noneArray
* RNAseq.sampleJobs.qc.FastqcRead1After.noneFile
* RNAseq.sampleJobs.qc.FastqcRead1After.noneArray
* RNAseq.sampleJobs.qc.FastqcRead2After.noneFile
* RNAseq.sampleJobs.qc.FastqcRead2After.noneArray
* RNAseq.expression.mergeStringtieGtf.noneFile
* RNAseq.GffCompare.noneFile
