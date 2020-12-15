# RNAseq


## Inputs


### Required inputs
<p name="RNAseq.dockerImagesFile">
        <b>RNAseq.dockerImagesFile</b><br />
        <i>File &mdash; Default: None</i><br />
        A YAML file describing the docker image used for the tasks. The dockerImages.yml provided with the pipeline is recommended.
</p>
<p name="RNAseq.hisat2Index">
        <b>RNAseq.hisat2Index</b><br />
        <i>Array[File]+? &mdash; Default: None</i><br />
        The hisat2 index files. Defining this will cause the hisat2 aligner to run. Note that is starIndex is also defined the star results will be used for downstream analyses. May be omitted in starIndex is defined.
</p>
<p name="RNAseq.outputDir">
        <b>RNAseq.outputDir</b><br />
        <i>String &mdash; Default: "."</i><br />
        The output directory.
</p>
<p name="RNAseq.referenceFasta">
        <b>RNAseq.referenceFasta</b><br />
        <i>File &mdash; Default: None</i><br />
        The reference fasta file.
</p>
<p name="RNAseq.referenceFastaDict">
        <b>RNAseq.referenceFastaDict</b><br />
        <i>File &mdash; Default: None</i><br />
        Sequence dictionary (.dict) file of the reference.
</p>
<p name="RNAseq.referenceFastaFai">
        <b>RNAseq.referenceFastaFai</b><br />
        <i>File &mdash; Default: None</i><br />
        Fasta index (.fai) file of the reference.
</p>
<p name="RNAseq.sampleConfigFile">
        <b>RNAseq.sampleConfigFile</b><br />
        <i>File &mdash; Default: None</i><br />
        The samplesheet, including sample ids, library ids, readgroup ids and fastq file locations.
</p>
<p name="RNAseq.starIndex">
        <b>RNAseq.starIndex</b><br />
        <i>Array[File]+? &mdash; Default: None</i><br />
        The star index files. Defining this will cause the star aligner to run and be used for downstream analyses. May be ommited if hisat2Index is defined.
</p>
<p name="RNAseq.strandedness">
        <b>RNAseq.strandedness</b><br />
        <i>String &mdash; Default: None</i><br />
        The strandedness of the RNA sequencing library preparation. One of "None" (unstranded), "FR" (forward-reverse: first read equal transcript) or "RF" (reverse-forward: second read equals transcript).
</p>

### Other common inputs
<p name="RNAseq.adapterForward">
        <b>RNAseq.adapterForward</b><br />
        <i>String? &mdash; Default: "AGATCGGAAGAG"</i><br />
        The adapter to be removed from the reads first or single end reads.
</p>
<p name="RNAseq.adapterReverse">
        <b>RNAseq.adapterReverse</b><br />
        <i>String? &mdash; Default: "AGATCGGAAGAG"</i><br />
        The adapter to be removed from the reads second end reads.
</p>
<p name="RNAseq.cpatHex">
        <b>RNAseq.cpatHex</b><br />
        <i>File? &mdash; Default: None</i><br />
        A hexamer frequency table for CPAT. Required if lncRNAdetection is `true`.
</p>
<p name="RNAseq.cpatLogitModel">
        <b>RNAseq.cpatLogitModel</b><br />
        <i>File? &mdash; Default: None</i><br />
        A logit model for CPAT. Required if lncRNAdetection is `true`.
</p>
<p name="RNAseq.dbsnpVCF">
        <b>RNAseq.dbsnpVCF</b><br />
        <i>File? &mdash; Default: None</i><br />
        dbsnp VCF file used for checking known sites.
</p>
<p name="RNAseq.dbsnpVCFIndex">
        <b>RNAseq.dbsnpVCFIndex</b><br />
        <i>File? &mdash; Default: None</i><br />
        Index (.tbi) file for the dbsnp VCF.
</p>
<p name="RNAseq.detectNovelTranscripts">
        <b>RNAseq.detectNovelTranscripts</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Whether or not a transcripts assembly should be used. If set to true Stringtie will be used to create a new GTF file based on the BAM files. This generated GTF file will be used for expression quantification. If `referenceGtfFile` is also provided this reference GTF will be used to guide the assembly.
</p>
<p name="RNAseq.expression.stringtieAssembly.geneAbundanceFile">
        <b>RNAseq.expression.stringtieAssembly.geneAbundanceFile</b><br />
        <i>String? &mdash; Default: None</i><br />
        Where the abundance file should be written.
</p>
<p name="RNAseq.lncRNAdatabases">
        <b>RNAseq.lncRNAdatabases</b><br />
        <i>Array[File] &mdash; Default: []</i><br />
        A set of GTF files the assembled GTF file should be compared with. Only used if lncRNAdetection is set to `true`.
</p>
<p name="RNAseq.lncRNAdetection">
        <b>RNAseq.lncRNAdetection</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Whether or not lncRNA detection should be run. This will enable detectNovelTranscript (this cannot be disabled by setting detectNovelTranscript to false). This will require cpatLogitModel and cpatHex to be defined.
</p>
<p name="RNAseq.referenceGtfFile">
        <b>RNAseq.referenceGtfFile</b><br />
        <i>File? &mdash; Default: None</i><br />
        A reference GTF file. Used for expression quantification or to guide the transcriptome assembly if detectNovelTranscripts is set to `true` (this GTF won't be be used directly for the expression quantification in that case.
</p>
<p name="RNAseq.refflatFile">
        <b>RNAseq.refflatFile</b><br />
        <i>File? &mdash; Default: None</i><br />
        A refflat files describing the genes. If this is defined RNAseq metrics will be collected.
</p>
<p name="RNAseq.runStringtieQuantification">
        <b>RNAseq.runStringtieQuantification</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        Option to disable running stringtie for quantification. This does not affect the usage of stringtie for novel transcript detection.
</p>
<p name="RNAseq.sampleJobs.bamMetrics.ampliconIntervals">
        <b>RNAseq.sampleJobs.bamMetrics.ampliconIntervals</b><br />
        <i>File? &mdash; Default: None</i><br />
        An interval list describinig the coordinates of the amplicons sequenced. This should only be used for targeted sequencing or WES. Required if `ampliconIntervals` is defined.
</p>
<p name="RNAseq.sampleJobs.bamMetrics.targetIntervals">
        <b>RNAseq.sampleJobs.bamMetrics.targetIntervals</b><br />
        <i>Array[File]+? &mdash; Default: None</i><br />
        An interval list describing the coordinates of the targets sequenced. This should only be used for targeted sequencing or WES. If defined targeted PCR metrics will be collected. Requires `ampliconIntervals` to also be defined.
</p>
<p name="RNAseq.sampleJobs.qc.contaminations">
        <b>RNAseq.sampleJobs.qc.contaminations</b><br />
        <i>Array[String]+? &mdash; Default: None</i><br />
        Contaminants/adapters to be removed from the reads.
</p>
<p name="RNAseq.sampleJobs.qc.readgroupName">
        <b>RNAseq.sampleJobs.qc.readgroupName</b><br />
        <i>String &mdash; Default: sub(basename(read1),"(\.fq)?(\.fastq)?(\.gz)?","")</i><br />
        The name of the readgroup.
</p>
<p name="RNAseq.umiDeduplication">
        <b>RNAseq.umiDeduplication</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Whether or not UMI based deduplication should be performed.
</p>
<p name="RNAseq.variantCalling">
        <b>RNAseq.variantCalling</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Whether or not variantcalling should be performed.
</p>
<p name="RNAseq.variantcalling.callAutosomal.excludeIntervalList">
        <b>RNAseq.variantcalling.callAutosomal.excludeIntervalList</b><br />
        <i>Array[File]+? &mdash; Default: None</i><br />
        Bed files or interval lists describing the regions to NOT operate on.
</p>
<p name="RNAseq.variantcalling.callAutosomal.pedigree">
        <b>RNAseq.variantcalling.callAutosomal.pedigree</b><br />
        <i>File? &mdash; Default: None</i><br />
        Pedigree file for determining the population "founders".
</p>
<p name="RNAseq.variantcalling.callAutosomal.ploidy">
        <b>RNAseq.variantcalling.callAutosomal.ploidy</b><br />
        <i>Int? &mdash; Default: None</i><br />
        The ploidy with which the variants should be called.
</p>
<p name="RNAseq.variantcalling.callX.excludeIntervalList">
        <b>RNAseq.variantcalling.callX.excludeIntervalList</b><br />
        <i>Array[File]+? &mdash; Default: None</i><br />
        Bed files or interval lists describing the regions to NOT operate on.
</p>
<p name="RNAseq.variantcalling.callX.pedigree">
        <b>RNAseq.variantcalling.callX.pedigree</b><br />
        <i>File? &mdash; Default: None</i><br />
        Pedigree file for determining the population "founders".
</p>
<p name="RNAseq.variantcalling.callY.excludeIntervalList">
        <b>RNAseq.variantcalling.callY.excludeIntervalList</b><br />
        <i>Array[File]+? &mdash; Default: None</i><br />
        Bed files or interval lists describing the regions to NOT operate on.
</p>
<p name="RNAseq.variantcalling.callY.pedigree">
        <b>RNAseq.variantcalling.callY.pedigree</b><br />
        <i>File? &mdash; Default: None</i><br />
        Pedigree file for determining the population "founders".
</p>
<p name="RNAseq.variantcalling.gvcf">
        <b>RNAseq.variantcalling.gvcf</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Whether to call in GVCF mode.
</p>
<p name="RNAseq.variantcalling.mergeVcf">
        <b>RNAseq.variantcalling.mergeVcf</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        Whether to merge scattered VCFs.
</p>
<p name="RNAseq.variantcalling.Stats.compareVcf">
        <b>RNAseq.variantcalling.Stats.compareVcf</b><br />
        <i>File? &mdash; Default: None</i><br />
        When inputVcf and compareVCF are given, the program generates separate stats for intersection and the complements. By default only sites are compared, samples must be given to include also sample columns.
</p>
<p name="RNAseq.variantcalling.Stats.compareVcfIndex">
        <b>RNAseq.variantcalling.Stats.compareVcfIndex</b><br />
        <i>File? &mdash; Default: None</i><br />
        Index for the compareVcf.
</p>
<p name="RNAseq.variantCallingRegions">
        <b>RNAseq.variantCallingRegions</b><br />
        <i>File? &mdash; Default: None</i><br />
        A bed file describing the regions to operate on for variant calling.
</p>

### Advanced inputs
<details>
<summary> Show/Hide </summary>
<p name="RNAseq.calculateRegions.intersectAutosomalRegions.memory">
        <b>RNAseq.calculateRegions.intersectAutosomalRegions.memory</b><br />
        <i>String &mdash; Default: "~{512 + ceil(size([regionsA, regionsB],"M"))}M"</i><br />
        The amount of memory needed for the job.
</p>
<p name="RNAseq.calculateRegions.intersectAutosomalRegions.timeMinutes">
        <b>RNAseq.calculateRegions.intersectAutosomalRegions.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil(size([regionsA, regionsB],"G"))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.calculateRegions.intersectX.memory">
        <b>RNAseq.calculateRegions.intersectX.memory</b><br />
        <i>String &mdash; Default: "~{512 + ceil(size([regionsA, regionsB],"M"))}M"</i><br />
        The amount of memory needed for the job.
</p>
<p name="RNAseq.calculateRegions.intersectX.timeMinutes">
        <b>RNAseq.calculateRegions.intersectX.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil(size([regionsA, regionsB],"G"))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.calculateRegions.intersectY.memory">
        <b>RNAseq.calculateRegions.intersectY.memory</b><br />
        <i>String &mdash; Default: "~{512 + ceil(size([regionsA, regionsB],"M"))}M"</i><br />
        The amount of memory needed for the job.
</p>
<p name="RNAseq.calculateRegions.intersectY.timeMinutes">
        <b>RNAseq.calculateRegions.intersectY.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil(size([regionsA, regionsB],"G"))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.calculateRegions.inverseBed.memory">
        <b>RNAseq.calculateRegions.inverseBed.memory</b><br />
        <i>String &mdash; Default: "~{512 + ceil(size([inputBed, faidx],"M"))}M"</i><br />
        The amount of memory needed for the job.
</p>
<p name="RNAseq.calculateRegions.inverseBed.timeMinutes">
        <b>RNAseq.calculateRegions.inverseBed.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil(size([inputBed, faidx],"G"))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.calculateRegions.mergeBeds.memory">
        <b>RNAseq.calculateRegions.mergeBeds.memory</b><br />
        <i>String &mdash; Default: "~{512 + ceil(size(bedFiles,"M"))}M"</i><br />
        The amount of memory needed for the job.
</p>
<p name="RNAseq.calculateRegions.mergeBeds.outputBed">
        <b>RNAseq.calculateRegions.mergeBeds.outputBed</b><br />
        <i>String &mdash; Default: "merged.bed"</i><br />
        The path to write the output to.
</p>
<p name="RNAseq.calculateRegions.mergeBeds.timeMinutes">
        <b>RNAseq.calculateRegions.mergeBeds.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil(size(bedFiles,"G"))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.calculateRegions.scatterAutosomalRegions.memory">
        <b>RNAseq.calculateRegions.scatterAutosomalRegions.memory</b><br />
        <i>String &mdash; Default: "256M"</i><br />
        The amount of memory this job will use.
</p>
<p name="RNAseq.calculateRegions.scatterAutosomalRegions.prefix">
        <b>RNAseq.calculateRegions.scatterAutosomalRegions.prefix</b><br />
        <i>String &mdash; Default: "scatters/scatter-"</i><br />
        The prefix of the ouput files. Output will be named like: <PREFIX><N>.bed, in which N is an incrementing number. Default 'scatter-'.
</p>
<p name="RNAseq.calculateRegions.scatterAutosomalRegions.splitContigs">
        <b>RNAseq.calculateRegions.scatterAutosomalRegions.splitContigs</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        If set, contigs are allowed to be split up over multiple files.
</p>
<p name="RNAseq.calculateRegions.scatterAutosomalRegions.timeMinutes">
        <b>RNAseq.calculateRegions.scatterAutosomalRegions.timeMinutes</b><br />
        <i>Int &mdash; Default: 2</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.collectUmiStats">
        <b>RNAseq.collectUmiStats</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Whether or not UMI deduplication stats should be collected. This will potentially cause a massive increase in memory usage of the deduplication step.
</p>
<p name="RNAseq.convertDockerTagsFile.dockerImage">
        <b>RNAseq.convertDockerTagsFile.dockerImage</b><br />
        <i>String &mdash; Default: "quay.io/biocontainers/biowdl-input-converter:0.2.1--py_0"</i><br />
        The docker image used for this task. Changing this may result in errors which the developers may choose not to address.
</p>
<p name="RNAseq.convertDockerTagsFile.memory">
        <b>RNAseq.convertDockerTagsFile.memory</b><br />
        <i>String &mdash; Default: "128M"</i><br />
        The maximum amount of memory the job will need.
</p>
<p name="RNAseq.convertDockerTagsFile.timeMinutes">
        <b>RNAseq.convertDockerTagsFile.timeMinutes</b><br />
        <i>Int &mdash; Default: 1</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.convertSampleConfig.checkFileMd5sums">
        <b>RNAseq.convertSampleConfig.checkFileMd5sums</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Whether or not the MD5 sums of the files mentioned in the samplesheet should be checked.
</p>
<p name="RNAseq.convertSampleConfig.dockerImage">
        <b>RNAseq.convertSampleConfig.dockerImage</b><br />
        <i>String &mdash; Default: "quay.io/biocontainers/biowdl-input-converter:0.2.1--py_0"</i><br />
        The docker image used for this task. Changing this may result in errors which the developers may choose not to address.
</p>
<p name="RNAseq.convertSampleConfig.memory">
        <b>RNAseq.convertSampleConfig.memory</b><br />
        <i>String &mdash; Default: "128M"</i><br />
        The amount of memory needed for the job.
</p>
<p name="RNAseq.convertSampleConfig.old">
        <b>RNAseq.convertSampleConfig.old</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Whether or not the old samplesheet format should be used.
</p>
<p name="RNAseq.convertSampleConfig.skipFileCheck">
        <b>RNAseq.convertSampleConfig.skipFileCheck</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        Whether or not the existance of the files mentioned in the samplesheet should be checked.
</p>
<p name="RNAseq.convertSampleConfig.timeMinutes">
        <b>RNAseq.convertSampleConfig.timeMinutes</b><br />
        <i>Int &mdash; Default: 1</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.CPAT.startCodons">
        <b>RNAseq.CPAT.startCodons</b><br />
        <i>Array[String]? &mdash; Default: None</i><br />
        Equivalent to CPAT's `--start` option.
</p>
<p name="RNAseq.CPAT.stopCodons">
        <b>RNAseq.CPAT.stopCodons</b><br />
        <i>Array[String]? &mdash; Default: None</i><br />
        Equivalent to CPAT's `--stop` option.
</p>
<p name="RNAseq.CPAT.timeMinutes">
        <b>RNAseq.CPAT.timeMinutes</b><br />
        <i>Int &mdash; Default: 10 + ceil((size(gene,"G") * 30))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.expression.additionalAttributes">
        <b>RNAseq.expression.additionalAttributes</b><br />
        <i>Array[String]+? &mdash; Default: None</i><br />
        Additional attributes which should be taken from the GTF used for quantification and added to the merged expression value tables.
</p>
<p name="RNAseq.expression.htSeqCount.additionalAttributes">
        <b>RNAseq.expression.htSeqCount.additionalAttributes</b><br />
        <i>Array[String] &mdash; Default: []</i><br />
        Equivalent to the --additional-attr option of htseq-count.
</p>
<p name="RNAseq.expression.htSeqCount.featureType">
        <b>RNAseq.expression.htSeqCount.featureType</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to the --type option of htseq-count.
</p>
<p name="RNAseq.expression.htSeqCount.idattr">
        <b>RNAseq.expression.htSeqCount.idattr</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to the --idattr option of htseq-count.
</p>
<p name="RNAseq.expression.htSeqCount.memory">
        <b>RNAseq.expression.htSeqCount.memory</b><br />
        <i>String &mdash; Default: "8G"</i><br />
        The amount of memory the job requires in GB.
</p>
<p name="RNAseq.expression.htSeqCount.nprocesses">
        <b>RNAseq.expression.htSeqCount.nprocesses</b><br />
        <i>Int &mdash; Default: 1</i><br />
        Number of processes to run htseq with.
</p>
<p name="RNAseq.expression.htSeqCount.order">
        <b>RNAseq.expression.htSeqCount.order</b><br />
        <i>String &mdash; Default: "pos"</i><br />
        Equivalent to the -r option of htseq-count.
</p>
<p name="RNAseq.expression.htSeqCount.timeMinutes">
        <b>RNAseq.expression.htSeqCount.timeMinutes</b><br />
        <i>Int &mdash; Default: 10 + ceil((size(inputBams,"G") * 60))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.expression.mergedHTSeqFragmentsPerGenes.featureAttribute">
        <b>RNAseq.expression.mergedHTSeqFragmentsPerGenes.featureAttribute</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to the -F option of collect-columns.
</p>
<p name="RNAseq.expression.mergedHTSeqFragmentsPerGenes.featureColumn">
        <b>RNAseq.expression.mergedHTSeqFragmentsPerGenes.featureColumn</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to the -f option of collect-columns.
</p>
<p name="RNAseq.expression.mergedHTSeqFragmentsPerGenes.header">
        <b>RNAseq.expression.mergedHTSeqFragmentsPerGenes.header</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to the -H flag of collect-columns.
</p>
<p name="RNAseq.expression.mergedHTSeqFragmentsPerGenes.memoryGb">
        <b>RNAseq.expression.mergedHTSeqFragmentsPerGenes.memoryGb</b><br />
        <i>Int &mdash; Default: 4 + ceil((0.5 * length(inputTables)))</i><br />
        The maximum amount of memory the job will need in GB.
</p>
<p name="RNAseq.expression.mergedHTSeqFragmentsPerGenes.separator">
        <b>RNAseq.expression.mergedHTSeqFragmentsPerGenes.separator</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to the -s option of collect-columns.
</p>
<p name="RNAseq.expression.mergedHTSeqFragmentsPerGenes.sumOnDuplicateId">
        <b>RNAseq.expression.mergedHTSeqFragmentsPerGenes.sumOnDuplicateId</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to the -S flag of collect-columns.
</p>
<p name="RNAseq.expression.mergedHTSeqFragmentsPerGenes.timeMinutes">
        <b>RNAseq.expression.mergedHTSeqFragmentsPerGenes.timeMinutes</b><br />
        <i>Int &mdash; Default: 10</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.expression.mergedHTSeqFragmentsPerGenes.valueColumn">
        <b>RNAseq.expression.mergedHTSeqFragmentsPerGenes.valueColumn</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to the -c option of collect-columns.
</p>
<p name="RNAseq.expression.mergedStringtieFPKMs.featureAttribute">
        <b>RNAseq.expression.mergedStringtieFPKMs.featureAttribute</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to the -F option of collect-columns.
</p>
<p name="RNAseq.expression.mergedStringtieFPKMs.featureColumn">
        <b>RNAseq.expression.mergedStringtieFPKMs.featureColumn</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to the -f option of collect-columns.
</p>
<p name="RNAseq.expression.mergedStringtieFPKMs.memoryGb">
        <b>RNAseq.expression.mergedStringtieFPKMs.memoryGb</b><br />
        <i>Int &mdash; Default: 4 + ceil((0.5 * length(inputTables)))</i><br />
        The maximum amount of memory the job will need in GB.
</p>
<p name="RNAseq.expression.mergedStringtieFPKMs.separator">
        <b>RNAseq.expression.mergedStringtieFPKMs.separator</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to the -s option of collect-columns.
</p>
<p name="RNAseq.expression.mergedStringtieFPKMs.timeMinutes">
        <b>RNAseq.expression.mergedStringtieFPKMs.timeMinutes</b><br />
        <i>Int &mdash; Default: 10</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.expression.mergedStringtieTPMs.featureAttribute">
        <b>RNAseq.expression.mergedStringtieTPMs.featureAttribute</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to the -F option of collect-columns.
</p>
<p name="RNAseq.expression.mergedStringtieTPMs.featureColumn">
        <b>RNAseq.expression.mergedStringtieTPMs.featureColumn</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to the -f option of collect-columns.
</p>
<p name="RNAseq.expression.mergedStringtieTPMs.memoryGb">
        <b>RNAseq.expression.mergedStringtieTPMs.memoryGb</b><br />
        <i>Int &mdash; Default: 4 + ceil((0.5 * length(inputTables)))</i><br />
        The maximum amount of memory the job will need in GB.
</p>
<p name="RNAseq.expression.mergedStringtieTPMs.separator">
        <b>RNAseq.expression.mergedStringtieTPMs.separator</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to the -s option of collect-columns.
</p>
<p name="RNAseq.expression.mergedStringtieTPMs.timeMinutes">
        <b>RNAseq.expression.mergedStringtieTPMs.timeMinutes</b><br />
        <i>Int &mdash; Default: 10</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.expression.mergeStringtieGtf.keepMergedTranscriptsWithRetainedIntrons">
        <b>RNAseq.expression.mergeStringtieGtf.keepMergedTranscriptsWithRetainedIntrons</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to the -i flag of 'stringtie --merge'.
</p>
<p name="RNAseq.expression.mergeStringtieGtf.label">
        <b>RNAseq.expression.mergeStringtieGtf.label</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to the -l option of 'stringtie --merge'.
</p>
<p name="RNAseq.expression.mergeStringtieGtf.memory">
        <b>RNAseq.expression.mergeStringtieGtf.memory</b><br />
        <i>String &mdash; Default: "10G"</i><br />
        The amount of memory needed for this task in GB.
</p>
<p name="RNAseq.expression.mergeStringtieGtf.minimumCoverage">
        <b>RNAseq.expression.mergeStringtieGtf.minimumCoverage</b><br />
        <i>Float? &mdash; Default: None</i><br />
        Equivalent to the -c option of 'stringtie --merge'.
</p>
<p name="RNAseq.expression.mergeStringtieGtf.minimumFPKM">
        <b>RNAseq.expression.mergeStringtieGtf.minimumFPKM</b><br />
        <i>Float? &mdash; Default: None</i><br />
        Equivalent to the -F option of 'stringtie --merge'.
</p>
<p name="RNAseq.expression.mergeStringtieGtf.minimumIsoformFraction">
        <b>RNAseq.expression.mergeStringtieGtf.minimumIsoformFraction</b><br />
        <i>Float? &mdash; Default: None</i><br />
        Equivalent to the -f option of 'stringtie --merge'.
</p>
<p name="RNAseq.expression.mergeStringtieGtf.minimumLength">
        <b>RNAseq.expression.mergeStringtieGtf.minimumLength</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to the -m option of 'stringtie --merge'.
</p>
<p name="RNAseq.expression.mergeStringtieGtf.minimumTPM">
        <b>RNAseq.expression.mergeStringtieGtf.minimumTPM</b><br />
        <i>Float? &mdash; Default: None</i><br />
        Equivalent to the -T option of 'stringtie --merge'.
</p>
<p name="RNAseq.expression.mergeStringtieGtf.timeMinutes">
        <b>RNAseq.expression.mergeStringtieGtf.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil((size(gtfFiles,"G") * 20))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.expression.stringtie.memory">
        <b>RNAseq.expression.stringtie.memory</b><br />
        <i>String &mdash; Default: "2G"</i><br />
        The amount of memory needed for this task in GB.
</p>
<p name="RNAseq.expression.stringtie.threads">
        <b>RNAseq.expression.stringtie.threads</b><br />
        <i>Int &mdash; Default: 1</i><br />
        The number of threads to use.
</p>
<p name="RNAseq.expression.stringtie.timeMinutes">
        <b>RNAseq.expression.stringtie.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil((size(bam,"G") * 60 / threads))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.expression.stringtieAssembly.memory">
        <b>RNAseq.expression.stringtieAssembly.memory</b><br />
        <i>String &mdash; Default: "2G"</i><br />
        The amount of memory needed for this task in GB.
</p>
<p name="RNAseq.expression.stringtieAssembly.threads">
        <b>RNAseq.expression.stringtieAssembly.threads</b><br />
        <i>Int &mdash; Default: 1</i><br />
        The number of threads to use.
</p>
<p name="RNAseq.expression.stringtieAssembly.timeMinutes">
        <b>RNAseq.expression.stringtieAssembly.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil((size(bam,"G") * 60 / threads))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.GffCompare.A">
        <b>RNAseq.GffCompare.A</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to gffcompare's `-A` flag.
</p>
<p name="RNAseq.GffCompare.C">
        <b>RNAseq.GffCompare.C</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to gffcompare's `-C` flag.
</p>
<p name="RNAseq.GffCompare.debugMode">
        <b>RNAseq.GffCompare.debugMode</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to gffcompare's `-D` flag.
</p>
<p name="RNAseq.GffCompare.discardSingleExonReferenceTranscripts">
        <b>RNAseq.GffCompare.discardSingleExonReferenceTranscripts</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to gffcompare's `-N` flag.
</p>
<p name="RNAseq.GffCompare.discardSingleExonTransfragsAndReferenceTranscripts">
        <b>RNAseq.GffCompare.discardSingleExonTransfragsAndReferenceTranscripts</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to gffcompare's `-M` flag.
</p>
<p name="RNAseq.GffCompare.genomeSequences">
        <b>RNAseq.GffCompare.genomeSequences</b><br />
        <i>File? &mdash; Default: None</i><br />
        Equivalent to gffcompare's `-s` option.
</p>
<p name="RNAseq.GffCompare.inputGtfList">
        <b>RNAseq.GffCompare.inputGtfList</b><br />
        <i>File? &mdash; Default: None</i><br />
        Equivalent to gffcompare's `-i` option.
</p>
<p name="RNAseq.GffCompare.K">
        <b>RNAseq.GffCompare.K</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to gffcompare's `-K` flag.
</p>
<p name="RNAseq.GffCompare.maxDistanceFreeEndsTerminalExons">
        <b>RNAseq.GffCompare.maxDistanceFreeEndsTerminalExons</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to gffcompare's `-e` option.
</p>
<p name="RNAseq.GffCompare.maxDistanceGroupingTranscriptStartSites">
        <b>RNAseq.GffCompare.maxDistanceGroupingTranscriptStartSites</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to gffcompare's `-d` option.
</p>
<p name="RNAseq.GffCompare.namePrefix">
        <b>RNAseq.GffCompare.namePrefix</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to gffcompare's `-p` option.
</p>
<p name="RNAseq.GffCompare.noTmap">
        <b>RNAseq.GffCompare.noTmap</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to gffcompare's `-T` flag.
</p>
<p name="RNAseq.GffCompare.outPrefix">
        <b>RNAseq.GffCompare.outPrefix</b><br />
        <i>String &mdash; Default: "gffcmp"</i><br />
        The prefix for the output.
</p>
<p name="RNAseq.GffCompare.precisionCorrection">
        <b>RNAseq.GffCompare.precisionCorrection</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to gffcompare's `-Q` flag.
</p>
<p name="RNAseq.GffCompare.snCorrection">
        <b>RNAseq.GffCompare.snCorrection</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to gffcompare's `-R` flag.
</p>
<p name="RNAseq.GffCompare.timeMinutes">
        <b>RNAseq.GffCompare.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil((size(inputGtfFiles,"G") * 30))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.GffCompare.verbose">
        <b>RNAseq.GffCompare.verbose</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to gffcompare's `-V` flag.
</p>
<p name="RNAseq.GffCompare.X">
        <b>RNAseq.GffCompare.X</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to gffcompare's `-X` flag.
</p>
<p name="RNAseq.gffreadTask.CDSFastaPath">
        <b>RNAseq.gffreadTask.CDSFastaPath</b><br />
        <i>String? &mdash; Default: None</i><br />
        The location the CDS fasta should be written to.
</p>
<p name="RNAseq.gffreadTask.filteredGffPath">
        <b>RNAseq.gffreadTask.filteredGffPath</b><br />
        <i>String? &mdash; Default: None</i><br />
        The location the filtered GFF should be written to.
</p>
<p name="RNAseq.gffreadTask.outputGtfFormat">
        <b>RNAseq.gffreadTask.outputGtfFormat</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to gffread's `-T` flag.
</p>
<p name="RNAseq.gffreadTask.proteinFastaPath">
        <b>RNAseq.gffreadTask.proteinFastaPath</b><br />
        <i>String? &mdash; Default: None</i><br />
        The location the protein fasta should be written to.
</p>
<p name="RNAseq.gffreadTask.timeMinutes">
        <b>RNAseq.gffreadTask.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil((size(inputGff,"G") * 10))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.makeStarIndex.memory">
        <b>RNAseq.makeStarIndex.memory</b><br />
        <i>String &mdash; Default: "32G"</i><br />
        The amount of memory this job will use.
</p>
<p name="RNAseq.makeStarIndex.sjdbOverhang">
        <b>RNAseq.makeStarIndex.sjdbOverhang</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to STAR's `--sjdbOverhang` option.
</p>
<p name="RNAseq.makeStarIndex.threads">
        <b>RNAseq.makeStarIndex.threads</b><br />
        <i>Int &mdash; Default: 4</i><br />
        The number of threads to use.
</p>
<p name="RNAseq.makeStarIndex.timeMinutes">
        <b>RNAseq.makeStarIndex.timeMinutes</b><br />
        <i>Int &mdash; Default: ceil((size(referenceFasta,"G") * 240 / threads))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.multiqcTask.clConfig">
        <b>RNAseq.multiqcTask.clConfig</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to MultiQC's `--cl-config` option.
</p>
<p name="RNAseq.multiqcTask.comment">
        <b>RNAseq.multiqcTask.comment</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to MultiQC's `--comment` option.
</p>
<p name="RNAseq.multiqcTask.config">
        <b>RNAseq.multiqcTask.config</b><br />
        <i>File? &mdash; Default: None</i><br />
        Equivalent to MultiQC's `--config` option.
</p>
<p name="RNAseq.multiqcTask.dataDir">
        <b>RNAseq.multiqcTask.dataDir</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Whether to output a data dir. Sets `--data-dir` or `--no-data-dir` flag.
</p>
<p name="RNAseq.multiqcTask.dataFormat">
        <b>RNAseq.multiqcTask.dataFormat</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to MultiQC's `--data-format` option.
</p>
<p name="RNAseq.multiqcTask.dirs">
        <b>RNAseq.multiqcTask.dirs</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to MultiQC's `--dirs` flag.
</p>
<p name="RNAseq.multiqcTask.dirsDepth">
        <b>RNAseq.multiqcTask.dirsDepth</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to MultiQC's `--dirs-depth` option.
</p>
<p name="RNAseq.multiqcTask.exclude">
        <b>RNAseq.multiqcTask.exclude</b><br />
        <i>Array[String]+? &mdash; Default: None</i><br />
        Equivalent to MultiQC's `--exclude` option.
</p>
<p name="RNAseq.multiqcTask.export">
        <b>RNAseq.multiqcTask.export</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to MultiQC's `--export` flag.
</p>
<p name="RNAseq.multiqcTask.fileList">
        <b>RNAseq.multiqcTask.fileList</b><br />
        <i>File? &mdash; Default: None</i><br />
        Equivalent to MultiQC's `--file-list` option.
</p>
<p name="RNAseq.multiqcTask.fileName">
        <b>RNAseq.multiqcTask.fileName</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to MultiQC's `--filename` option.
</p>
<p name="RNAseq.multiqcTask.flat">
        <b>RNAseq.multiqcTask.flat</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to MultiQC's `--flat` flag.
</p>
<p name="RNAseq.multiqcTask.force">
        <b>RNAseq.multiqcTask.force</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to MultiQC's `--force` flag.
</p>
<p name="RNAseq.multiqcTask.fullNames">
        <b>RNAseq.multiqcTask.fullNames</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to MultiQC's `--fullnames` flag.
</p>
<p name="RNAseq.multiqcTask.ignore">
        <b>RNAseq.multiqcTask.ignore</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to MultiQC's `--ignore` option.
</p>
<p name="RNAseq.multiqcTask.ignoreSamples">
        <b>RNAseq.multiqcTask.ignoreSamples</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to MultiQC's `--ignore-samples` option.
</p>
<p name="RNAseq.multiqcTask.interactive">
        <b>RNAseq.multiqcTask.interactive</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        Equivalent to MultiQC's `--interactive` flag.
</p>
<p name="RNAseq.multiqcTask.lint">
        <b>RNAseq.multiqcTask.lint</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to MultiQC's `--lint` flag.
</p>
<p name="RNAseq.multiqcTask.megaQCUpload">
        <b>RNAseq.multiqcTask.megaQCUpload</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Opposite to MultiQC's `--no-megaqc-upload` flag.
</p>
<p name="RNAseq.multiqcTask.memory">
        <b>RNAseq.multiqcTask.memory</b><br />
        <i>String? &mdash; Default: None</i><br />
        The amount of memory this job will use.
</p>
<p name="RNAseq.multiqcTask.module">
        <b>RNAseq.multiqcTask.module</b><br />
        <i>Array[String]+? &mdash; Default: None</i><br />
        Equivalent to MultiQC's `--module` option.
</p>
<p name="RNAseq.multiqcTask.pdf">
        <b>RNAseq.multiqcTask.pdf</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to MultiQC's `--pdf` flag.
</p>
<p name="RNAseq.multiqcTask.sampleNames">
        <b>RNAseq.multiqcTask.sampleNames</b><br />
        <i>File? &mdash; Default: None</i><br />
        Equivalent to MultiQC's `--sample-names` option.
</p>
<p name="RNAseq.multiqcTask.tag">
        <b>RNAseq.multiqcTask.tag</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to MultiQC's `--tag` option.
</p>
<p name="RNAseq.multiqcTask.template">
        <b>RNAseq.multiqcTask.template</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to MultiQC's `--template` option.
</p>
<p name="RNAseq.multiqcTask.timeMinutes">
        <b>RNAseq.multiqcTask.timeMinutes</b><br />
        <i>Int &mdash; Default: 2 + ceil((size(reports,"G") * 8))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.multiqcTask.title">
        <b>RNAseq.multiqcTask.title</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to MultiQC's `--title` option.
</p>
<p name="RNAseq.multiqcTask.zipDataDir">
        <b>RNAseq.multiqcTask.zipDataDir</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        Equivalent to MultiQC's `--zip-data-dir` flag.
</p>
<p name="RNAseq.platform">
        <b>RNAseq.platform</b><br />
        <i>String &mdash; Default: "illumina"</i><br />
        The platform used for sequencing.
</p>
<p name="RNAseq.preprocessing.applyBqsr.javaXmxMb">
        <b>RNAseq.preprocessing.applyBqsr.javaXmxMb</b><br />
        <i>Int &mdash; Default: 2048</i><br />
        The maximum memory available to the program in megabytes. Should be lower than `memoryMb` to accommodate JVM overhead.
</p>
<p name="RNAseq.preprocessing.applyBqsr.memoryMb">
        <b>RNAseq.preprocessing.applyBqsr.memoryMb</b><br />
        <i>Int &mdash; Default: javaXmxMb + 512</i><br />
        The amount of memory this job will use in megabytes.
</p>
<p name="RNAseq.preprocessing.baseRecalibrator.javaXmxMb">
        <b>RNAseq.preprocessing.baseRecalibrator.javaXmxMb</b><br />
        <i>Int &mdash; Default: 1024</i><br />
        The maximum memory available to the program in megabytes. Should be lower than `memoryMb` to accommodate JVM overhead.
</p>
<p name="RNAseq.preprocessing.baseRecalibrator.knownIndelsSitesVCFIndexes">
        <b>RNAseq.preprocessing.baseRecalibrator.knownIndelsSitesVCFIndexes</b><br />
        <i>Array[File] &mdash; Default: []</i><br />
        The indexed for the known variant VCFs.
</p>
<p name="RNAseq.preprocessing.baseRecalibrator.knownIndelsSitesVCFs">
        <b>RNAseq.preprocessing.baseRecalibrator.knownIndelsSitesVCFs</b><br />
        <i>Array[File] &mdash; Default: []</i><br />
        VCF files with known indels.
</p>
<p name="RNAseq.preprocessing.baseRecalibrator.memoryMb">
        <b>RNAseq.preprocessing.baseRecalibrator.memoryMb</b><br />
        <i>Int &mdash; Default: javaXmxMb + 512</i><br />
        The amount of memory this job will use in megabytes.
</p>
<p name="RNAseq.preprocessing.gatherBamFiles.compressionLevel">
        <b>RNAseq.preprocessing.gatherBamFiles.compressionLevel</b><br />
        <i>Int? &mdash; Default: None</i><br />
        The compression level of the output BAM.
</p>
<p name="RNAseq.preprocessing.gatherBamFiles.createMd5File">
        <b>RNAseq.preprocessing.gatherBamFiles.createMd5File</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        ???
</p>
<p name="RNAseq.preprocessing.gatherBamFiles.javaXmxMb">
        <b>RNAseq.preprocessing.gatherBamFiles.javaXmxMb</b><br />
        <i>Int &mdash; Default: 1024</i><br />
        The maximum memory available to the program in megabytes. Should be lower than `memoryMb` to accommodate JVM overhead.
</p>
<p name="RNAseq.preprocessing.gatherBamFiles.memoryMb">
        <b>RNAseq.preprocessing.gatherBamFiles.memoryMb</b><br />
        <i>Int &mdash; Default: javaXmxMb + 512</i><br />
        The amount of memory this job will use in megabytes.
</p>
<p name="RNAseq.preprocessing.gatherBamFiles.timeMinutes">
        <b>RNAseq.preprocessing.gatherBamFiles.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil((size(inputBams,"G") * 1))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.preprocessing.gatherBqsr.javaXmxMb">
        <b>RNAseq.preprocessing.gatherBqsr.javaXmxMb</b><br />
        <i>Int &mdash; Default: 256</i><br />
        The maximum memory available to the program in megabytes. Should be lower than `memory` to accommodate JVM overhead.
</p>
<p name="RNAseq.preprocessing.gatherBqsr.memoryMb">
        <b>RNAseq.preprocessing.gatherBqsr.memoryMb</b><br />
        <i>Int &mdash; Default: 256 + javaXmxMb</i><br />
        The amount of memory this job will use in megabytes.
</p>
<p name="RNAseq.preprocessing.gatherBqsr.timeMinutes">
        <b>RNAseq.preprocessing.gatherBqsr.timeMinutes</b><br />
        <i>Int &mdash; Default: 1</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.preprocessing.splitNCigarReads.javaXmx">
        <b>RNAseq.preprocessing.splitNCigarReads.javaXmx</b><br />
        <i>String &mdash; Default: "4G"</i><br />
        The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</p>
<p name="RNAseq.preprocessing.splitNCigarReads.memory">
        <b>RNAseq.preprocessing.splitNCigarReads.memory</b><br />
        <i>String &mdash; Default: "5G"</i><br />
        The amount of memory this job will use.
</p>
<p name="RNAseq.sampleJobs.bamMetrics.ampliconIntervalsLists.javaXmx">
        <b>RNAseq.sampleJobs.bamMetrics.ampliconIntervalsLists.javaXmx</b><br />
        <i>String &mdash; Default: "3G"</i><br />
        The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</p>
<p name="RNAseq.sampleJobs.bamMetrics.ampliconIntervalsLists.memory">
        <b>RNAseq.sampleJobs.bamMetrics.ampliconIntervalsLists.memory</b><br />
        <i>String &mdash; Default: "4G"</i><br />
        The amount of memory this job will use.
</p>
<p name="RNAseq.sampleJobs.bamMetrics.ampliconIntervalsLists.timeMinutes">
        <b>RNAseq.sampleJobs.bamMetrics.ampliconIntervalsLists.timeMinutes</b><br />
        <i>Int &mdash; Default: 5</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.sampleJobs.bamMetrics.collectAlignmentSummaryMetrics">
        <b>RNAseq.sampleJobs.bamMetrics.collectAlignmentSummaryMetrics</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        Equivalent to the `PROGRAM=CollectAlignmentSummaryMetrics` argument in Picard.
</p>
<p name="RNAseq.sampleJobs.bamMetrics.Flagstat.memory">
        <b>RNAseq.sampleJobs.bamMetrics.Flagstat.memory</b><br />
        <i>String &mdash; Default: "256M"</i><br />
        The amount of memory needed for the job.
</p>
<p name="RNAseq.sampleJobs.bamMetrics.Flagstat.timeMinutes">
        <b>RNAseq.sampleJobs.bamMetrics.Flagstat.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil(size(inputBam,"G"))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.sampleJobs.bamMetrics.meanQualityByCycle">
        <b>RNAseq.sampleJobs.bamMetrics.meanQualityByCycle</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        Equivalent to the `PROGRAM=MeanQualityByCycle` argument in Picard.
</p>
<p name="RNAseq.sampleJobs.bamMetrics.picardMetrics.collectBaseDistributionByCycle">
        <b>RNAseq.sampleJobs.bamMetrics.picardMetrics.collectBaseDistributionByCycle</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        Equivalent to the `PROGRAM=CollectBaseDistributionByCycle` argument.
</p>
<p name="RNAseq.sampleJobs.bamMetrics.picardMetrics.collectGcBiasMetrics">
        <b>RNAseq.sampleJobs.bamMetrics.picardMetrics.collectGcBiasMetrics</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        Equivalent to the `PROGRAM=CollectGcBiasMetrics` argument.
</p>
<p name="RNAseq.sampleJobs.bamMetrics.picardMetrics.collectInsertSizeMetrics">
        <b>RNAseq.sampleJobs.bamMetrics.picardMetrics.collectInsertSizeMetrics</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        Equivalent to the `PROGRAM=CollectInsertSizeMetrics` argument.
</p>
<p name="RNAseq.sampleJobs.bamMetrics.picardMetrics.collectQualityYieldMetrics">
        <b>RNAseq.sampleJobs.bamMetrics.picardMetrics.collectQualityYieldMetrics</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        Equivalent to the `PROGRAM=CollectQualityYieldMetrics` argument.
</p>
<p name="RNAseq.sampleJobs.bamMetrics.picardMetrics.collectSequencingArtifactMetrics">
        <b>RNAseq.sampleJobs.bamMetrics.picardMetrics.collectSequencingArtifactMetrics</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        Equivalent to the `PROGRAM=CollectSequencingArtifactMetrics` argument.
</p>
<p name="RNAseq.sampleJobs.bamMetrics.picardMetrics.javaXmxMb">
        <b>RNAseq.sampleJobs.bamMetrics.picardMetrics.javaXmxMb</b><br />
        <i>Int &mdash; Default: 3072</i><br />
        The maximum memory available to the program in megabytes. Should be lower than `memoryMb` to accommodate JVM overhead.
</p>
<p name="RNAseq.sampleJobs.bamMetrics.picardMetrics.memoryMb">
        <b>RNAseq.sampleJobs.bamMetrics.picardMetrics.memoryMb</b><br />
        <i>Int &mdash; Default: javaXmxMb + 512</i><br />
        The amount of memory this job will use in megabytes.
</p>
<p name="RNAseq.sampleJobs.bamMetrics.picardMetrics.qualityScoreDistribution">
        <b>RNAseq.sampleJobs.bamMetrics.picardMetrics.qualityScoreDistribution</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        Equivalent to the `PROGRAM=QualityScoreDistribution` argument.
</p>
<p name="RNAseq.sampleJobs.bamMetrics.picardMetrics.timeMinutes">
        <b>RNAseq.sampleJobs.bamMetrics.picardMetrics.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil((size(referenceFasta,"G") * 3 * 2)) + ceil((size(inputBam,"G") * 6))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.sampleJobs.bamMetrics.rnaSeqMetrics.javaXmx">
        <b>RNAseq.sampleJobs.bamMetrics.rnaSeqMetrics.javaXmx</b><br />
        <i>String &mdash; Default: "8G"</i><br />
        The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</p>
<p name="RNAseq.sampleJobs.bamMetrics.rnaSeqMetrics.memory">
        <b>RNAseq.sampleJobs.bamMetrics.rnaSeqMetrics.memory</b><br />
        <i>String &mdash; Default: "9G"</i><br />
        The amount of memory this job will use.
</p>
<p name="RNAseq.sampleJobs.bamMetrics.rnaSeqMetrics.timeMinutes">
        <b>RNAseq.sampleJobs.bamMetrics.rnaSeqMetrics.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil((size(inputBam,"G") * 12))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.sampleJobs.bamMetrics.targetIntervalsLists.javaXmx">
        <b>RNAseq.sampleJobs.bamMetrics.targetIntervalsLists.javaXmx</b><br />
        <i>String &mdash; Default: "3G"</i><br />
        The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</p>
<p name="RNAseq.sampleJobs.bamMetrics.targetIntervalsLists.memory">
        <b>RNAseq.sampleJobs.bamMetrics.targetIntervalsLists.memory</b><br />
        <i>String &mdash; Default: "4G"</i><br />
        The amount of memory this job will use.
</p>
<p name="RNAseq.sampleJobs.bamMetrics.targetIntervalsLists.timeMinutes">
        <b>RNAseq.sampleJobs.bamMetrics.targetIntervalsLists.timeMinutes</b><br />
        <i>Int &mdash; Default: 5</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.sampleJobs.bamMetrics.targetMetrics.javaXmx">
        <b>RNAseq.sampleJobs.bamMetrics.targetMetrics.javaXmx</b><br />
        <i>String &mdash; Default: "3G"</i><br />
        The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</p>
<p name="RNAseq.sampleJobs.bamMetrics.targetMetrics.memory">
        <b>RNAseq.sampleJobs.bamMetrics.targetMetrics.memory</b><br />
        <i>String &mdash; Default: "4G"</i><br />
        The amount of memory this job will use.
</p>
<p name="RNAseq.sampleJobs.bamMetrics.targetMetrics.timeMinutes">
        <b>RNAseq.sampleJobs.bamMetrics.targetMetrics.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil((size(inputBam,"G") * 6))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.sampleJobs.hisat2.compressionLevel">
        <b>RNAseq.sampleJobs.hisat2.compressionLevel</b><br />
        <i>Int &mdash; Default: 1</i><br />
        The compression level of the output BAM.
</p>
<p name="RNAseq.sampleJobs.hisat2.downstreamTranscriptomeAssembly">
        <b>RNAseq.sampleJobs.hisat2.downstreamTranscriptomeAssembly</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        Equivalent to hisat2's `--dta` flag.
</p>
<p name="RNAseq.sampleJobs.hisat2.memoryGb">
        <b>RNAseq.sampleJobs.hisat2.memoryGb</b><br />
        <i>Int? &mdash; Default: None</i><br />
        The amount of memory this job will use in gigabytes.
</p>
<p name="RNAseq.sampleJobs.hisat2.sortMemoryPerThreadGb">
        <b>RNAseq.sampleJobs.hisat2.sortMemoryPerThreadGb</b><br />
        <i>Int &mdash; Default: 2</i><br />
        The amount of memory for each sorting thread in gigabytes.
</p>
<p name="RNAseq.sampleJobs.hisat2.sortThreads">
        <b>RNAseq.sampleJobs.hisat2.sortThreads</b><br />
        <i>Int? &mdash; Default: None</i><br />
        The number of threads to use for sorting.
</p>
<p name="RNAseq.sampleJobs.hisat2.threads">
        <b>RNAseq.sampleJobs.hisat2.threads</b><br />
        <i>Int &mdash; Default: 4</i><br />
        The number of threads to use.
</p>
<p name="RNAseq.sampleJobs.hisat2.timeMinutes">
        <b>RNAseq.sampleJobs.hisat2.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil((size([inputR1, inputR2],"G") * 180 / threads))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.sampleJobs.markDuplicates.compressionLevel">
        <b>RNAseq.sampleJobs.markDuplicates.compressionLevel</b><br />
        <i>Int &mdash; Default: 1</i><br />
        The compression level at which the BAM files are written.
</p>
<p name="RNAseq.sampleJobs.markDuplicates.createMd5File">
        <b>RNAseq.sampleJobs.markDuplicates.createMd5File</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Whether to create a md5 file for the created BAM file.
</p>
<p name="RNAseq.sampleJobs.markDuplicates.javaXmxMb">
        <b>RNAseq.sampleJobs.markDuplicates.javaXmxMb</b><br />
        <i>Int &mdash; Default: 6656</i><br />
        The maximum memory available to the program in megabytes. Should be lower than `memoryMb` to accommodate JVM overhead.
</p>
<p name="RNAseq.sampleJobs.markDuplicates.memoryMb">
        <b>RNAseq.sampleJobs.markDuplicates.memoryMb</b><br />
        <i>String &mdash; Default: javaXmxMb + 512</i><br />
        The amount of memory this job will use in megabytes.
</p>
<p name="RNAseq.sampleJobs.markDuplicates.read_name_regex">
        <b>RNAseq.sampleJobs.markDuplicates.read_name_regex</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to the `READ_NAME_REGEX` option of MarkDuplicates.
</p>
<p name="RNAseq.sampleJobs.markDuplicates.timeMinutes">
        <b>RNAseq.sampleJobs.markDuplicates.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil((size(inputBams,"G") * 8))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.sampleJobs.markDuplicates.useJdkDeflater">
        <b>RNAseq.sampleJobs.markDuplicates.useJdkDeflater</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        True, uses the java deflator to compress the BAM files. False uses the optimized intel deflater.
</p>
<p name="RNAseq.sampleJobs.markDuplicates.useJdkInflater">
        <b>RNAseq.sampleJobs.markDuplicates.useJdkInflater</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        True, uses the java inflater. False, uses the optimized intel inflater.
</p>
<p name="RNAseq.sampleJobs.postUmiDedupMarkDuplicates.compressionLevel">
        <b>RNAseq.sampleJobs.postUmiDedupMarkDuplicates.compressionLevel</b><br />
        <i>Int &mdash; Default: 1</i><br />
        The compression level at which the BAM files are written.
</p>
<p name="RNAseq.sampleJobs.postUmiDedupMarkDuplicates.createMd5File">
        <b>RNAseq.sampleJobs.postUmiDedupMarkDuplicates.createMd5File</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Whether to create a md5 file for the created BAM file.
</p>
<p name="RNAseq.sampleJobs.postUmiDedupMarkDuplicates.javaXmxMb">
        <b>RNAseq.sampleJobs.postUmiDedupMarkDuplicates.javaXmxMb</b><br />
        <i>Int &mdash; Default: 6656</i><br />
        The maximum memory available to the program in megabytes. Should be lower than `memoryMb` to accommodate JVM overhead.
</p>
<p name="RNAseq.sampleJobs.postUmiDedupMarkDuplicates.memoryMb">
        <b>RNAseq.sampleJobs.postUmiDedupMarkDuplicates.memoryMb</b><br />
        <i>String &mdash; Default: javaXmxMb + 512</i><br />
        The amount of memory this job will use in megabytes.
</p>
<p name="RNAseq.sampleJobs.postUmiDedupMarkDuplicates.read_name_regex">
        <b>RNAseq.sampleJobs.postUmiDedupMarkDuplicates.read_name_regex</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to the `READ_NAME_REGEX` option of MarkDuplicates.
</p>
<p name="RNAseq.sampleJobs.postUmiDedupMarkDuplicates.timeMinutes">
        <b>RNAseq.sampleJobs.postUmiDedupMarkDuplicates.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil((size(inputBams,"G") * 8))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.sampleJobs.postUmiDedupMarkDuplicates.useJdkDeflater">
        <b>RNAseq.sampleJobs.postUmiDedupMarkDuplicates.useJdkDeflater</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        True, uses the java deflator to compress the BAM files. False uses the optimized intel deflater.
</p>
<p name="RNAseq.sampleJobs.postUmiDedupMarkDuplicates.useJdkInflater">
        <b>RNAseq.sampleJobs.postUmiDedupMarkDuplicates.useJdkInflater</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        True, uses the java inflater. False, uses the optimized intel inflater.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.bwa">
        <b>RNAseq.sampleJobs.qc.Cutadapt.bwa</b><br />
        <i>Boolean? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --bwa flag.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.colorspace">
        <b>RNAseq.sampleJobs.qc.Cutadapt.colorspace</b><br />
        <i>Boolean? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --colorspace flag.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.compressionLevel">
        <b>RNAseq.sampleJobs.qc.Cutadapt.compressionLevel</b><br />
        <i>Int &mdash; Default: 1</i><br />
        The compression level if gzipped output is used.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.cores">
        <b>RNAseq.sampleJobs.qc.Cutadapt.cores</b><br />
        <i>Int &mdash; Default: 4</i><br />
        The number of cores to use.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.cut">
        <b>RNAseq.sampleJobs.qc.Cutadapt.cut</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --cut option.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.discardTrimmed">
        <b>RNAseq.sampleJobs.qc.Cutadapt.discardTrimmed</b><br />
        <i>Boolean? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --quality-cutoff option.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.discardUntrimmed">
        <b>RNAseq.sampleJobs.qc.Cutadapt.discardUntrimmed</b><br />
        <i>Boolean? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --discard-untrimmed option.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.doubleEncode">
        <b>RNAseq.sampleJobs.qc.Cutadapt.doubleEncode</b><br />
        <i>Boolean? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --double-encode flag.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.errorRate">
        <b>RNAseq.sampleJobs.qc.Cutadapt.errorRate</b><br />
        <i>Float? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --error-rate option.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.front">
        <b>RNAseq.sampleJobs.qc.Cutadapt.front</b><br />
        <i>Array[String] &mdash; Default: []</i><br />
        A list of 5' ligated adapter sequences to be cut from the given first or single end fastq file.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.frontRead2">
        <b>RNAseq.sampleJobs.qc.Cutadapt.frontRead2</b><br />
        <i>Array[String] &mdash; Default: []</i><br />
        A list of 5' ligated adapter sequences to be cut from the given second end fastq file.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.infoFilePath">
        <b>RNAseq.sampleJobs.qc.Cutadapt.infoFilePath</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --info-file option.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.interleaved">
        <b>RNAseq.sampleJobs.qc.Cutadapt.interleaved</b><br />
        <i>Boolean? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --interleaved flag.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.length">
        <b>RNAseq.sampleJobs.qc.Cutadapt.length</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --length option.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.lengthTag">
        <b>RNAseq.sampleJobs.qc.Cutadapt.lengthTag</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --length-tag option.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.maq">
        <b>RNAseq.sampleJobs.qc.Cutadapt.maq</b><br />
        <i>Boolean? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --maq flag.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.maskAdapter">
        <b>RNAseq.sampleJobs.qc.Cutadapt.maskAdapter</b><br />
        <i>Boolean? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --mask-adapter flag.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.matchReadWildcards">
        <b>RNAseq.sampleJobs.qc.Cutadapt.matchReadWildcards</b><br />
        <i>Boolean? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --match-read-wildcards flag.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.maximumLength">
        <b>RNAseq.sampleJobs.qc.Cutadapt.maximumLength</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --maximum-length option.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.maxN">
        <b>RNAseq.sampleJobs.qc.Cutadapt.maxN</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --max-n option.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.memory">
        <b>RNAseq.sampleJobs.qc.Cutadapt.memory</b><br />
        <i>String &mdash; Default: "~{300 + 100 * cores}M"</i><br />
        The amount of memory this job will use.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.minimumLength">
        <b>RNAseq.sampleJobs.qc.Cutadapt.minimumLength</b><br />
        <i>Int? &mdash; Default: 2</i><br />
        Equivalent to cutadapt's --minimum-length option.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.nextseqTrim">
        <b>RNAseq.sampleJobs.qc.Cutadapt.nextseqTrim</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --nextseq-trim option.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.noIndels">
        <b>RNAseq.sampleJobs.qc.Cutadapt.noIndels</b><br />
        <i>Boolean? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --no-indels flag.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.noMatchAdapterWildcards">
        <b>RNAseq.sampleJobs.qc.Cutadapt.noMatchAdapterWildcards</b><br />
        <i>Boolean? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --no-match-adapter-wildcards flag.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.noTrim">
        <b>RNAseq.sampleJobs.qc.Cutadapt.noTrim</b><br />
        <i>Boolean? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --no-trim flag.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.noZeroCap">
        <b>RNAseq.sampleJobs.qc.Cutadapt.noZeroCap</b><br />
        <i>Boolean? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --no-zero-cap flag.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.overlap">
        <b>RNAseq.sampleJobs.qc.Cutadapt.overlap</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --overlap option.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.pairFilter">
        <b>RNAseq.sampleJobs.qc.Cutadapt.pairFilter</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --pair-filter option.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.prefix">
        <b>RNAseq.sampleJobs.qc.Cutadapt.prefix</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --prefix option.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.qualityBase">
        <b>RNAseq.sampleJobs.qc.Cutadapt.qualityBase</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --quality-base option.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.qualityCutoff">
        <b>RNAseq.sampleJobs.qc.Cutadapt.qualityCutoff</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --quality-cutoff option.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.restFilePath">
        <b>RNAseq.sampleJobs.qc.Cutadapt.restFilePath</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --rest-file option.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.stripF3">
        <b>RNAseq.sampleJobs.qc.Cutadapt.stripF3</b><br />
        <i>Boolean? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --strip-f3 flag.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.stripSuffix">
        <b>RNAseq.sampleJobs.qc.Cutadapt.stripSuffix</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --strip-suffix option.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.suffix">
        <b>RNAseq.sampleJobs.qc.Cutadapt.suffix</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --suffix option.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.timeMinutes">
        <b>RNAseq.sampleJobs.qc.Cutadapt.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil((size([read1, read2],"G") * 12.0 / cores))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.times">
        <b>RNAseq.sampleJobs.qc.Cutadapt.times</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --times option.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.tooLongOutputPath">
        <b>RNAseq.sampleJobs.qc.Cutadapt.tooLongOutputPath</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --too-long-output option.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.tooLongPairedOutputPath">
        <b>RNAseq.sampleJobs.qc.Cutadapt.tooLongPairedOutputPath</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --too-long-paired-output option.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.tooShortOutputPath">
        <b>RNAseq.sampleJobs.qc.Cutadapt.tooShortOutputPath</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --too-short-output option.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.tooShortPairedOutputPath">
        <b>RNAseq.sampleJobs.qc.Cutadapt.tooShortPairedOutputPath</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --too-short-paired-output option.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.trimN">
        <b>RNAseq.sampleJobs.qc.Cutadapt.trimN</b><br />
        <i>Boolean? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --trim-n flag.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.untrimmedOutputPath">
        <b>RNAseq.sampleJobs.qc.Cutadapt.untrimmedOutputPath</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --untrimmed-output option.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.untrimmedPairedOutputPath">
        <b>RNAseq.sampleJobs.qc.Cutadapt.untrimmedPairedOutputPath</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --untrimmed-paired-output option.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.wildcardFilePath">
        <b>RNAseq.sampleJobs.qc.Cutadapt.wildcardFilePath</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --wildcard-file option.
</p>
<p name="RNAseq.sampleJobs.qc.Cutadapt.zeroCap">
        <b>RNAseq.sampleJobs.qc.Cutadapt.zeroCap</b><br />
        <i>Boolean? &mdash; Default: None</i><br />
        Equivalent to cutadapt's --zero-cap flag.
</p>
<p name="RNAseq.sampleJobs.qc.extractFastqcZip">
        <b>RNAseq.sampleJobs.qc.extractFastqcZip</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Whether to extract Fastqc's report zip files.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead1.adapters">
        <b>RNAseq.sampleJobs.qc.FastqcRead1.adapters</b><br />
        <i>File? &mdash; Default: None</i><br />
        Equivalent to fastqc's --adapters option.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead1.casava">
        <b>RNAseq.sampleJobs.qc.FastqcRead1.casava</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to fastqc's --casava flag.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead1.contaminants">
        <b>RNAseq.sampleJobs.qc.FastqcRead1.contaminants</b><br />
        <i>File? &mdash; Default: None</i><br />
        Equivalent to fastqc's --contaminants option.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead1.dir">
        <b>RNAseq.sampleJobs.qc.FastqcRead1.dir</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to fastqc's --dir option.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead1.format">
        <b>RNAseq.sampleJobs.qc.FastqcRead1.format</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to fastqc's --format option.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead1.javaXmx">
        <b>RNAseq.sampleJobs.qc.FastqcRead1.javaXmx</b><br />
        <i>String &mdash; Default: "1750M"</i><br />
        The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead1.kmers">
        <b>RNAseq.sampleJobs.qc.FastqcRead1.kmers</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to fastqc's --kmers option.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead1.limits">
        <b>RNAseq.sampleJobs.qc.FastqcRead1.limits</b><br />
        <i>File? &mdash; Default: None</i><br />
        Equivalent to fastqc's --limits option.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead1.memory">
        <b>RNAseq.sampleJobs.qc.FastqcRead1.memory</b><br />
        <i>String &mdash; Default: "2G"</i><br />
        The amount of memory this job will use.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead1.minLength">
        <b>RNAseq.sampleJobs.qc.FastqcRead1.minLength</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to fastqc's --min_length option.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead1.nano">
        <b>RNAseq.sampleJobs.qc.FastqcRead1.nano</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to fastqc's --nano flag.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead1.noFilter">
        <b>RNAseq.sampleJobs.qc.FastqcRead1.noFilter</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to fastqc's --nofilter flag.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead1.nogroup">
        <b>RNAseq.sampleJobs.qc.FastqcRead1.nogroup</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to fastqc's --nogroup flag.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead1.threads">
        <b>RNAseq.sampleJobs.qc.FastqcRead1.threads</b><br />
        <i>Int &mdash; Default: 1</i><br />
        The number of cores to use.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead1.timeMinutes">
        <b>RNAseq.sampleJobs.qc.FastqcRead1.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil(size(seqFile,"G")) * 4</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead1After.adapters">
        <b>RNAseq.sampleJobs.qc.FastqcRead1After.adapters</b><br />
        <i>File? &mdash; Default: None</i><br />
        Equivalent to fastqc's --adapters option.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead1After.casava">
        <b>RNAseq.sampleJobs.qc.FastqcRead1After.casava</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to fastqc's --casava flag.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead1After.contaminants">
        <b>RNAseq.sampleJobs.qc.FastqcRead1After.contaminants</b><br />
        <i>File? &mdash; Default: None</i><br />
        Equivalent to fastqc's --contaminants option.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead1After.dir">
        <b>RNAseq.sampleJobs.qc.FastqcRead1After.dir</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to fastqc's --dir option.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead1After.format">
        <b>RNAseq.sampleJobs.qc.FastqcRead1After.format</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to fastqc's --format option.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead1After.javaXmx">
        <b>RNAseq.sampleJobs.qc.FastqcRead1After.javaXmx</b><br />
        <i>String &mdash; Default: "1750M"</i><br />
        The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead1After.kmers">
        <b>RNAseq.sampleJobs.qc.FastqcRead1After.kmers</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to fastqc's --kmers option.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead1After.limits">
        <b>RNAseq.sampleJobs.qc.FastqcRead1After.limits</b><br />
        <i>File? &mdash; Default: None</i><br />
        Equivalent to fastqc's --limits option.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead1After.memory">
        <b>RNAseq.sampleJobs.qc.FastqcRead1After.memory</b><br />
        <i>String &mdash; Default: "2G"</i><br />
        The amount of memory this job will use.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead1After.minLength">
        <b>RNAseq.sampleJobs.qc.FastqcRead1After.minLength</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to fastqc's --min_length option.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead1After.nano">
        <b>RNAseq.sampleJobs.qc.FastqcRead1After.nano</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to fastqc's --nano flag.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead1After.noFilter">
        <b>RNAseq.sampleJobs.qc.FastqcRead1After.noFilter</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to fastqc's --nofilter flag.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead1After.nogroup">
        <b>RNAseq.sampleJobs.qc.FastqcRead1After.nogroup</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to fastqc's --nogroup flag.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead1After.threads">
        <b>RNAseq.sampleJobs.qc.FastqcRead1After.threads</b><br />
        <i>Int &mdash; Default: 1</i><br />
        The number of cores to use.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead1After.timeMinutes">
        <b>RNAseq.sampleJobs.qc.FastqcRead1After.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil(size(seqFile,"G")) * 4</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead2.adapters">
        <b>RNAseq.sampleJobs.qc.FastqcRead2.adapters</b><br />
        <i>File? &mdash; Default: None</i><br />
        Equivalent to fastqc's --adapters option.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead2.casava">
        <b>RNAseq.sampleJobs.qc.FastqcRead2.casava</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to fastqc's --casava flag.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead2.contaminants">
        <b>RNAseq.sampleJobs.qc.FastqcRead2.contaminants</b><br />
        <i>File? &mdash; Default: None</i><br />
        Equivalent to fastqc's --contaminants option.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead2.dir">
        <b>RNAseq.sampleJobs.qc.FastqcRead2.dir</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to fastqc's --dir option.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead2.format">
        <b>RNAseq.sampleJobs.qc.FastqcRead2.format</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to fastqc's --format option.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead2.javaXmx">
        <b>RNAseq.sampleJobs.qc.FastqcRead2.javaXmx</b><br />
        <i>String &mdash; Default: "1750M"</i><br />
        The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead2.kmers">
        <b>RNAseq.sampleJobs.qc.FastqcRead2.kmers</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to fastqc's --kmers option.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead2.limits">
        <b>RNAseq.sampleJobs.qc.FastqcRead2.limits</b><br />
        <i>File? &mdash; Default: None</i><br />
        Equivalent to fastqc's --limits option.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead2.memory">
        <b>RNAseq.sampleJobs.qc.FastqcRead2.memory</b><br />
        <i>String &mdash; Default: "2G"</i><br />
        The amount of memory this job will use.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead2.minLength">
        <b>RNAseq.sampleJobs.qc.FastqcRead2.minLength</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to fastqc's --min_length option.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead2.nano">
        <b>RNAseq.sampleJobs.qc.FastqcRead2.nano</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to fastqc's --nano flag.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead2.noFilter">
        <b>RNAseq.sampleJobs.qc.FastqcRead2.noFilter</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to fastqc's --nofilter flag.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead2.nogroup">
        <b>RNAseq.sampleJobs.qc.FastqcRead2.nogroup</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to fastqc's --nogroup flag.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead2.threads">
        <b>RNAseq.sampleJobs.qc.FastqcRead2.threads</b><br />
        <i>Int &mdash; Default: 1</i><br />
        The number of cores to use.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead2.timeMinutes">
        <b>RNAseq.sampleJobs.qc.FastqcRead2.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil(size(seqFile,"G")) * 4</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead2After.adapters">
        <b>RNAseq.sampleJobs.qc.FastqcRead2After.adapters</b><br />
        <i>File? &mdash; Default: None</i><br />
        Equivalent to fastqc's --adapters option.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead2After.casava">
        <b>RNAseq.sampleJobs.qc.FastqcRead2After.casava</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to fastqc's --casava flag.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead2After.contaminants">
        <b>RNAseq.sampleJobs.qc.FastqcRead2After.contaminants</b><br />
        <i>File? &mdash; Default: None</i><br />
        Equivalent to fastqc's --contaminants option.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead2After.dir">
        <b>RNAseq.sampleJobs.qc.FastqcRead2After.dir</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to fastqc's --dir option.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead2After.format">
        <b>RNAseq.sampleJobs.qc.FastqcRead2After.format</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to fastqc's --format option.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead2After.javaXmx">
        <b>RNAseq.sampleJobs.qc.FastqcRead2After.javaXmx</b><br />
        <i>String &mdash; Default: "1750M"</i><br />
        The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead2After.kmers">
        <b>RNAseq.sampleJobs.qc.FastqcRead2After.kmers</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to fastqc's --kmers option.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead2After.limits">
        <b>RNAseq.sampleJobs.qc.FastqcRead2After.limits</b><br />
        <i>File? &mdash; Default: None</i><br />
        Equivalent to fastqc's --limits option.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead2After.memory">
        <b>RNAseq.sampleJobs.qc.FastqcRead2After.memory</b><br />
        <i>String &mdash; Default: "2G"</i><br />
        The amount of memory this job will use.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead2After.minLength">
        <b>RNAseq.sampleJobs.qc.FastqcRead2After.minLength</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to fastqc's --min_length option.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead2After.nano">
        <b>RNAseq.sampleJobs.qc.FastqcRead2After.nano</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to fastqc's --nano flag.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead2After.noFilter">
        <b>RNAseq.sampleJobs.qc.FastqcRead2After.noFilter</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to fastqc's --nofilter flag.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead2After.nogroup">
        <b>RNAseq.sampleJobs.qc.FastqcRead2After.nogroup</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Equivalent to fastqc's --nogroup flag.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead2After.threads">
        <b>RNAseq.sampleJobs.qc.FastqcRead2After.threads</b><br />
        <i>Int &mdash; Default: 1</i><br />
        The number of cores to use.
</p>
<p name="RNAseq.sampleJobs.qc.FastqcRead2After.timeMinutes">
        <b>RNAseq.sampleJobs.qc.FastqcRead2After.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil(size(seqFile,"G")) * 4</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.sampleJobs.qc.runAdapterClipping">
        <b>RNAseq.sampleJobs.qc.runAdapterClipping</b><br />
        <i>Boolean &mdash; Default: defined(adapterForward) || defined(adapterReverse) || length(select_first([contaminations, []])) > 0</i><br />
        Whether or not adapters should be removed from the reads.
</p>
<p name="RNAseq.sampleJobs.star.limitBAMsortRAM">
        <b>RNAseq.sampleJobs.star.limitBAMsortRAM</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to star's `--limitBAMsortRAM` option.
</p>
<p name="RNAseq.sampleJobs.star.memory">
        <b>RNAseq.sampleJobs.star.memory</b><br />
        <i>String? &mdash; Default: None</i><br />
        The amount of memory this job will use.
</p>
<p name="RNAseq.sampleJobs.star.outBAMcompression">
        <b>RNAseq.sampleJobs.star.outBAMcompression</b><br />
        <i>Int &mdash; Default: 1</i><br />
        The compression level of the output BAM.
</p>
<p name="RNAseq.sampleJobs.star.outFilterMatchNmin">
        <b>RNAseq.sampleJobs.star.outFilterMatchNmin</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to star's `--outFilterMatchNmin` option.
</p>
<p name="RNAseq.sampleJobs.star.outFilterMatchNminOverLread">
        <b>RNAseq.sampleJobs.star.outFilterMatchNminOverLread</b><br />
        <i>Float? &mdash; Default: None</i><br />
        Equivalent to star's `--outFilterMatchNminOverLread` option.
</p>
<p name="RNAseq.sampleJobs.star.outFilterScoreMin">
        <b>RNAseq.sampleJobs.star.outFilterScoreMin</b><br />
        <i>Int? &mdash; Default: None</i><br />
        Equivalent to star's `--outFilterScoreMin` option.
</p>
<p name="RNAseq.sampleJobs.star.outFilterScoreMinOverLread">
        <b>RNAseq.sampleJobs.star.outFilterScoreMinOverLread</b><br />
        <i>Float? &mdash; Default: None</i><br />
        Equivalent to star's `--outFilterScoreMinOverLread` option.
</p>
<p name="RNAseq.sampleJobs.star.outSAMunmapped">
        <b>RNAseq.sampleJobs.star.outSAMunmapped</b><br />
        <i>String? &mdash; Default: "Within KeepPairs"</i><br />
        Equivalent to star's `--outSAMunmapped` option.
</p>
<p name="RNAseq.sampleJobs.star.outStd">
        <b>RNAseq.sampleJobs.star.outStd</b><br />
        <i>String? &mdash; Default: None</i><br />
        Equivalent to star's `--outStd` option.
</p>
<p name="RNAseq.sampleJobs.star.runThreadN">
        <b>RNAseq.sampleJobs.star.runThreadN</b><br />
        <i>Int &mdash; Default: 4</i><br />
        The number of threads to use.
</p>
<p name="RNAseq.sampleJobs.star.timeMinutes">
        <b>RNAseq.sampleJobs.star.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil(size(indexFiles,"G")) + ceil((size(flatten([inputR1, inputR2]),"G") * 300 / runThreadN))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.sampleJobs.star.twopassMode">
        <b>RNAseq.sampleJobs.star.twopassMode</b><br />
        <i>String? &mdash; Default: "Basic"</i><br />
        Equivalent to star's `--twopassMode` option.
</p>
<p name="RNAseq.sampleJobs.umiDedup.memory">
        <b>RNAseq.sampleJobs.umiDedup.memory</b><br />
        <i>String &mdash; Default: "25G"</i><br />
        The amount of memory required for the task.
</p>
<p name="RNAseq.sampleJobs.umiDedup.timeMinutes">
        <b>RNAseq.sampleJobs.umiDedup.timeMinutes</b><br />
        <i>Int &mdash; Default: 30 + ceil((size(inputBam,"G") * 30))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.sampleJobs.umiDedup.umiSeparator">
        <b>RNAseq.sampleJobs.umiDedup.umiSeparator</b><br />
        <i>String? &mdash; Default: None</i><br />
        Seperator used for UMIs in the read names.
</p>
<p name="RNAseq.scatterList.memory">
        <b>RNAseq.scatterList.memory</b><br />
        <i>String &mdash; Default: "256M"</i><br />
        The amount of memory this job will use.
</p>
<p name="RNAseq.scatterList.prefix">
        <b>RNAseq.scatterList.prefix</b><br />
        <i>String &mdash; Default: "scatters/scatter-"</i><br />
        The prefix of the ouput files. Output will be named like: <PREFIX><N>.bed, in which N is an incrementing number. Default 'scatter-'.
</p>
<p name="RNAseq.scatterList.splitContigs">
        <b>RNAseq.scatterList.splitContigs</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        If set, contigs are allowed to be split up over multiple files.
</p>
<p name="RNAseq.scatterList.timeMinutes">
        <b>RNAseq.scatterList.timeMinutes</b><br />
        <i>Int &mdash; Default: 2</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.scatterSize">
        <b>RNAseq.scatterSize</b><br />
        <i>Int? &mdash; Default: None</i><br />
        The size of the scattered regions in bases for the GATK subworkflows. Scattering is used to speed up certain processes. The genome will be seperated into multiple chunks (scatters) which will be processed in their own job, allowing for parallel processing. Higher values will result in a lower number of jobs. The optimal value here will depend on the available resources.
</p>
<p name="RNAseq.scatterSizeMillions">
        <b>RNAseq.scatterSizeMillions</b><br />
        <i>Int &mdash; Default: 1000</i><br />
        Same as scatterSize, but is multiplied by 1000000 to get scatterSize. This allows for setting larger values more easily.
</p>
<p name="RNAseq.variantcalling.callAutosomal.contamination">
        <b>RNAseq.variantcalling.callAutosomal.contamination</b><br />
        <i>Float? &mdash; Default: None</i><br />
        Equivalent to HaplotypeCaller's `-contamination` option.
</p>
<p name="RNAseq.variantcalling.callAutosomal.emitRefConfidence">
        <b>RNAseq.variantcalling.callAutosomal.emitRefConfidence</b><br />
        <i>String &mdash; Default: if gvcf then "GVCF" else "NONE"</i><br />
        Whether to include reference calls. Three modes: 'NONE', 'BP_RESOLUTION' and 'GVCF'.
</p>
<p name="RNAseq.variantcalling.callAutosomal.javaXmxMb">
        <b>RNAseq.variantcalling.callAutosomal.javaXmxMb</b><br />
        <i>Int &mdash; Default: 4096</i><br />
        The maximum memory available to the program in megabytes. Should be lower than `memoryMb` to accommodate JVM overhead.
</p>
<p name="RNAseq.variantcalling.callAutosomal.memoryMb">
        <b>RNAseq.variantcalling.callAutosomal.memoryMb</b><br />
        <i>Int &mdash; Default: javaXmxMb + 512</i><br />
        The amount of memory this job will use in megabytes.
</p>
<p name="RNAseq.variantcalling.callAutosomal.outputMode">
        <b>RNAseq.variantcalling.callAutosomal.outputMode</b><br />
        <i>String? &mdash; Default: None</i><br />
        Specifies which type of calls we should output. Same as HaplotypeCaller's `--output-mode` option.
</p>
<p name="RNAseq.variantcalling.callX.contamination">
        <b>RNAseq.variantcalling.callX.contamination</b><br />
        <i>Float? &mdash; Default: None</i><br />
        Equivalent to HaplotypeCaller's `-contamination` option.
</p>
<p name="RNAseq.variantcalling.callX.emitRefConfidence">
        <b>RNAseq.variantcalling.callX.emitRefConfidence</b><br />
        <i>String &mdash; Default: if gvcf then "GVCF" else "NONE"</i><br />
        Whether to include reference calls. Three modes: 'NONE', 'BP_RESOLUTION' and 'GVCF'.
</p>
<p name="RNAseq.variantcalling.callX.javaXmxMb">
        <b>RNAseq.variantcalling.callX.javaXmxMb</b><br />
        <i>Int &mdash; Default: 4096</i><br />
        The maximum memory available to the program in megabytes. Should be lower than `memoryMb` to accommodate JVM overhead.
</p>
<p name="RNAseq.variantcalling.callX.memoryMb">
        <b>RNAseq.variantcalling.callX.memoryMb</b><br />
        <i>Int &mdash; Default: javaXmxMb + 512</i><br />
        The amount of memory this job will use in megabytes.
</p>
<p name="RNAseq.variantcalling.callX.outputMode">
        <b>RNAseq.variantcalling.callX.outputMode</b><br />
        <i>String? &mdash; Default: None</i><br />
        Specifies which type of calls we should output. Same as HaplotypeCaller's `--output-mode` option.
</p>
<p name="RNAseq.variantcalling.callY.contamination">
        <b>RNAseq.variantcalling.callY.contamination</b><br />
        <i>Float? &mdash; Default: None</i><br />
        Equivalent to HaplotypeCaller's `-contamination` option.
</p>
<p name="RNAseq.variantcalling.callY.emitRefConfidence">
        <b>RNAseq.variantcalling.callY.emitRefConfidence</b><br />
        <i>String &mdash; Default: if gvcf then "GVCF" else "NONE"</i><br />
        Whether to include reference calls. Three modes: 'NONE', 'BP_RESOLUTION' and 'GVCF'.
</p>
<p name="RNAseq.variantcalling.callY.javaXmxMb">
        <b>RNAseq.variantcalling.callY.javaXmxMb</b><br />
        <i>Int &mdash; Default: 4096</i><br />
        The maximum memory available to the program in megabytes. Should be lower than `memoryMb` to accommodate JVM overhead.
</p>
<p name="RNAseq.variantcalling.callY.memoryMb">
        <b>RNAseq.variantcalling.callY.memoryMb</b><br />
        <i>Int &mdash; Default: javaXmxMb + 512</i><br />
        The amount of memory this job will use in megabytes.
</p>
<p name="RNAseq.variantcalling.callY.outputMode">
        <b>RNAseq.variantcalling.callY.outputMode</b><br />
        <i>String? &mdash; Default: None</i><br />
        Specifies which type of calls we should output. Same as HaplotypeCaller's `--output-mode` option.
</p>
<p name="RNAseq.variantcalling.mergeSingleSampleGvcf.intervals">
        <b>RNAseq.variantcalling.mergeSingleSampleGvcf.intervals</b><br />
        <i>Array[File] &mdash; Default: []</i><br />
        Bed files or interval lists describing the regions to operate on.
</p>
<p name="RNAseq.variantcalling.mergeSingleSampleGvcf.javaXmx">
        <b>RNAseq.variantcalling.mergeSingleSampleGvcf.javaXmx</b><br />
        <i>String &mdash; Default: "4G"</i><br />
        The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</p>
<p name="RNAseq.variantcalling.mergeSingleSampleGvcf.memory">
        <b>RNAseq.variantcalling.mergeSingleSampleGvcf.memory</b><br />
        <i>String &mdash; Default: "5G"</i><br />
        The amount of memory this job will use.
</p>
<p name="RNAseq.variantcalling.mergeSingleSampleGvcf.timeMinutes">
        <b>RNAseq.variantcalling.mergeSingleSampleGvcf.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil((size(gvcfFiles,"G") * 8))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.variantcalling.mergeSingleSampleVcf.compressionLevel">
        <b>RNAseq.variantcalling.mergeSingleSampleVcf.compressionLevel</b><br />
        <i>Int &mdash; Default: 1</i><br />
        The compression level at which the BAM files are written.
</p>
<p name="RNAseq.variantcalling.mergeSingleSampleVcf.javaXmx">
        <b>RNAseq.variantcalling.mergeSingleSampleVcf.javaXmx</b><br />
        <i>String &mdash; Default: "4G"</i><br />
        The maximum memory available to the program. Should be lower than `memory` to accommodate JVM overhead.
</p>
<p name="RNAseq.variantcalling.mergeSingleSampleVcf.memory">
        <b>RNAseq.variantcalling.mergeSingleSampleVcf.memory</b><br />
        <i>String &mdash; Default: "5G"</i><br />
        The amount of memory this job will use.
</p>
<p name="RNAseq.variantcalling.mergeSingleSampleVcf.timeMinutes">
        <b>RNAseq.variantcalling.mergeSingleSampleVcf.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + ceil(size(inputVCFs,"G")) * 2</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.variantcalling.mergeSingleSampleVcf.useJdkDeflater">
        <b>RNAseq.variantcalling.mergeSingleSampleVcf.useJdkDeflater</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        True, uses the java deflator to compress the BAM files. False uses the optimized intel deflater.
</p>
<p name="RNAseq.variantcalling.mergeSingleSampleVcf.useJdkInflater">
        <b>RNAseq.variantcalling.mergeSingleSampleVcf.useJdkInflater</b><br />
        <i>Boolean &mdash; Default: true</i><br />
        True, uses the java inflater. False, uses the optimized intel inflater.
</p>
<p name="RNAseq.variantcalling.Stats.afBins">
        <b>RNAseq.variantcalling.Stats.afBins</b><br />
        <i>String? &mdash; Default: None</i><br />
        Allele frequency bins, a list (0.1,0.5,1) or a file (0.1
0.5
1).
</p>
<p name="RNAseq.variantcalling.Stats.applyFilters">
        <b>RNAseq.variantcalling.Stats.applyFilters</b><br />
        <i>String? &mdash; Default: None</i><br />
        Require at least one of the listed FILTER strings (e.g. "PASS,.").
</p>
<p name="RNAseq.variantcalling.Stats.collapse">
        <b>RNAseq.variantcalling.Stats.collapse</b><br />
        <i>String? &mdash; Default: None</i><br />
        Treat as identical records with <snps|indels|both|all|some|none>, see man page for details.
</p>
<p name="RNAseq.variantcalling.Stats.depth">
        <b>RNAseq.variantcalling.Stats.depth</b><br />
        <i>String? &mdash; Default: None</i><br />
        Depth distribution: min,max,bin size [0,500,1].
</p>
<p name="RNAseq.variantcalling.Stats.exclude">
        <b>RNAseq.variantcalling.Stats.exclude</b><br />
        <i>String? &mdash; Default: None</i><br />
        Exclude sites for which the expression is true (see man page for details).
</p>
<p name="RNAseq.variantcalling.Stats.exons">
        <b>RNAseq.variantcalling.Stats.exons</b><br />
        <i>File? &mdash; Default: None</i><br />
        Tab-delimited file with exons for indel frameshifts (chr,from,to; 1-based, inclusive, bgzip compressed).
</p>
<p name="RNAseq.variantcalling.Stats.firstAlleleOnly">
        <b>RNAseq.variantcalling.Stats.firstAlleleOnly</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Include only 1st allele at multiallelic sites.
</p>
<p name="RNAseq.variantcalling.Stats.include">
        <b>RNAseq.variantcalling.Stats.include</b><br />
        <i>String? &mdash; Default: None</i><br />
        Select sites for which the expression is true (see man page for details).
</p>
<p name="RNAseq.variantcalling.Stats.memory">
        <b>RNAseq.variantcalling.Stats.memory</b><br />
        <i>String &mdash; Default: "256M"</i><br />
        The amount of memory this job will use.
</p>
<p name="RNAseq.variantcalling.Stats.regions">
        <b>RNAseq.variantcalling.Stats.regions</b><br />
        <i>String? &mdash; Default: None</i><br />
        Restrict to comma-separated list of regions.
</p>
<p name="RNAseq.variantcalling.Stats.samplesFile">
        <b>RNAseq.variantcalling.Stats.samplesFile</b><br />
        <i>File? &mdash; Default: None</i><br />
        File of samples to include.
</p>
<p name="RNAseq.variantcalling.Stats.splitByID">
        <b>RNAseq.variantcalling.Stats.splitByID</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Collect stats for sites with ID separately (known vs novel).
</p>
<p name="RNAseq.variantcalling.Stats.targets">
        <b>RNAseq.variantcalling.Stats.targets</b><br />
        <i>String? &mdash; Default: None</i><br />
        Similar to regions but streams rather than index-jumps.
</p>
<p name="RNAseq.variantcalling.Stats.targetsFile">
        <b>RNAseq.variantcalling.Stats.targetsFile</b><br />
        <i>File? &mdash; Default: None</i><br />
        Similar to regionsFile but streams rather than index-jumps.
</p>
<p name="RNAseq.variantcalling.Stats.threads">
        <b>RNAseq.variantcalling.Stats.threads</b><br />
        <i>Int &mdash; Default: 0</i><br />
        Number of extra decompression threads [0].
</p>
<p name="RNAseq.variantcalling.Stats.timeMinutes">
        <b>RNAseq.variantcalling.Stats.timeMinutes</b><br />
        <i>Int &mdash; Default: 1 + 2 * ceil(size(select_all([inputVcf, compareVcf]),"G"))</i><br />
        The maximum amount of time the job will run in minutes.
</p>
<p name="RNAseq.variantcalling.Stats.userTsTv">
        <b>RNAseq.variantcalling.Stats.userTsTv</b><br />
        <i>String? &mdash; Default: None</i><br />
        <TAG[:min:max:n]>. Collect Ts/Tv stats for any tag using the given binning [0:1:100].
</p>
<p name="RNAseq.variantcalling.Stats.verbose">
        <b>RNAseq.variantcalling.Stats.verbose</b><br />
        <i>Boolean &mdash; Default: false</i><br />
        Produce verbose per-site and per-sample output.
</p>
<p name="RNAseq.variantcalling.statsRegions">
        <b>RNAseq.variantcalling.statsRegions</b><br />
        <i>File? &mdash; Default: None</i><br />
        Which regions need to be analysed by the stats tools.
</p>
<p name="RNAseq.variantcalling.timeMinutes">
        <b>RNAseq.variantcalling.timeMinutes</b><br />
        <i>Int &mdash; Default: ceil((size(bam,"G") * 120))</i><br />
        The time in minutes expected for each haplotype caller task. Will be exposed as the time_minutes runtime attribute.
</p>
<p name="RNAseq.XNonParRegions">
        <b>RNAseq.XNonParRegions</b><br />
        <i>File? &mdash; Default: None</i><br />
        Bed file with the non-PAR regions of X for variant calling.
</p>
<p name="RNAseq.YNonParRegions">
        <b>RNAseq.YNonParRegions</b><br />
        <i>File? &mdash; Default: None</i><br />
        Bed file with the non-PAR regions of Y for variant calling.
</p>
</details>



### Other inputs
<details>
<summary> Show/Hide </summary>
<p name="RNAseq.makeStarIndex.genomeDir">
        <b>RNAseq.makeStarIndex.genomeDir</b><br />
        <i>String &mdash; Default: "STAR_index"</i><br />
        The directory the STAR index should be written to.
</p>
</details>






<hr />

> Generated using WDL AID (0.1.1)
