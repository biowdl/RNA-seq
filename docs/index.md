---
layout: default
title: Home
---

This pipeline can be used to process RNA-seq data, starting from FastQ files.
It will perform adapter clipping (using cutadapt), mapping (using STAR) and expression
quantification (using HTSeq-Count and Stringtie). Optionally variantcalling 
(based on the GATK Best Practises) and lncRNA detection (using CPAT) can also be performed.

This pipeline is part of [BioWDL](https://biowdl.github.io/)
developed by the SASC team at [Leiden University Medical Center](https://www.lumc.nl/).

## Usage
This pipeline can be run using
[Cromwell](http://cromwell.readthedocs.io/en/stable/):
```bash
java -jar cromwell-<version>.jar run -i inputs.json pipeline.wdl
```

### Dependency requirements and tool versions
Biowdl pipelines use docker images to ensure  reproducibility. This
means that biowdl pipelines will run on any system that has docker
installed. Alternatively they can be run with singularity.

For more advanced configuration of docker or singularity please check
the [cromwell documentation on containers](
https://cromwell.readthedocs.io/en/stable/tutorials/Containers/).

Images from [biocontainers](https://biocontainers.pro) are preferred for
biowdl pipelines. The list of default images for this pipeline can be
found in the default for the `dockerImages` input.

### Inputs
Inputs are provided through a JSON file. The minimally required inputs are
described below, but additional inputs are available.
A template containing all possible inputs can be generated using
Womtool as described in the
[WOMtool documentation](http://cromwell.readthedocs.io/en/stable/WOMtool/).
See [this page](/inputs.html) for some additional general notes and information
about pipeline inputs.

```JSON
{
 "pipeline.sampleConfigFile":"The sample configuration file. See below for more details.",
 "pipeline.dockerImagesFile": "A file listing the used docker images.",
  "pipeline.starIndex": "A list of star index files.",
  "pipeline.reference": {
    "fasta": "A path to a reference fasta",
    "fai": "The path to the index associated with the reference fasta",
    "dict": "The path to the dict file associated with the reference fasta"
  },
  "pipeline.outputDir": "The path to the output directory",
  "pipeline.refflatFile": "Reference annotation Refflat file. This will be used for expression quantification.",
  "pipeline.referenceGtfFile": "Reference annotation GTF file. This will be used for expression quantification.",
  "pipeline.strandedness": "Indicates the strandedness of the input data. This should be one of the following: FR (Forward, Reverse), RF (Reverse, Forward) or None: (Unstranded)",
}
```
If you wish to use hisat2 instead, set the list of hisat2 index files on
`pipeline.hisat2Index`.

The `referenceGtfFile` may also be omitted, in this case Stringtie will be used to 
perform an unguided assembly, which will then be used for expression quantification.

Optional settings:
```JSON 
{
  "pipeline.sample.Sample.library.Library.readgroupWorkflow.Readgroup.qc.adapterForward": "Used to set a forward read adapter. Default: Illumina Universal Adapter",
  "pipeline.sample.Sample.library.Library.readgroupWorkflow.Readgroup.qc.adapterReverse": "Used to set a reverse read adapter (for paired-end reads). Default: Illumina Universal Adapter"
}
```
#### Sample configuration
The sample configuration should be a YML file which adheres to the following
structure:
```YML
samples:
  - id: <sampleId>
    libraries:
      - id: <libId>
        readgroups:
          - id: <rgId>
            reads:
              R1: <Path to first-end FastQ file.>
              R1_md5: <MD5 checksum of first-end FastQ file.>
              R2: <Path to second-end FastQ file.>
              R2_md5: <MD5 checksum of second-end FastQ file.>
```
Replace the text between `< >` with appropriate values. MD5 values may be
omitted and R2 values may be omitted in the case of single-end data.
Multiple readgroups can be added per library and multiple libraries may be
given per sample.

#### Variantcalling
In order to perform variant calling the following inputs are also required:
```JSON
{
  "pipeline.variantCalling": "Whether or not variantcalling should be performed, defaults to False",
  "pipeline.dbSNP": {
    "file": "A path to a dbSNP VCF file",
    "index": "The path to the index (.tbi) file associated with the dbSNP VCF"
  }
}
```

#### lncRNA detection
In order to perform lncRNA detection the following inputs are also required:
```JSON
{
  "pipeline.lncRNAdetection": "Whether or not lncRNA detection should be performed, defaults to False",
  "pipeline.lncRNAdatabases": "A list of gtf files containing known lncRNAs",
  "pipeline.cpatLogitModel": "The CPAT logitModel to be used",
  "pipeline.cpatHex": "The CPAT hexamer tab file to be used"
}
```

#### Example

The following is an example of what an inputs JSON might look like:
```JSON
{
 "pipeline.sampleConfigFile":"/home/user/analysis/samples.yml",
  "pipeline.starIndex": [
    "/reference/star/chrLength.txt",
    "/reference/star/chrName.txt",
    "/reference/star/chrNameLength.txt",
    "/reference/star/chrStart.txt",
    "/reference/star/Genome",
    "/reference/star/genomeParameters.txt",
    "/reference/star/SA",
    "/reference/star/SAindex"
  ],
  "pipeline.variantCalling": true,
  "pipeline.lncRNAdetection": true,
  "pipeline.reference": {
    "fasta": "/home/user/genomes/human/GRCh38.fasta",
    "fai": "/home/user/genomes/human/GRCh38.fasta.fai",
    "dict": "/home/user/genomes/human/GRCh38.dict"
  },
  "pipeline.dbSNP": {
    "file": "/home/user/genomes/human/dbsnp/dbsnp-151.vcf.gz",
    "index": "/home/user/genomes/human/dbsnp/dbsnp-151.vcf.gz.tbi"
  },
  "pipeline.lncRNAdatabases": ["/home/user/genomes/human/NONCODE.gtf"],
  "pipeline.cpatLogitModel": "/home/user/genomes/human/GRCH38_logit",
  "pipeline.cpatHex": "/home/user/genomes/human/GRCH38_hex.tab",
  "pipeline.outputDir": "/home/user/analysis/results",
  "pipeline.refflatFile": "/home/user/genomes/human/GRCH38_annotation.refflat",
  "pipeline.gtfFile": "/home/user/genomes/human/GRCH38_annotation.gtf",
  "pipeline.strandedness": "RF",
  "pipeline.dockerImagesFile": "dockerImages.yml"
}
```

And the associated sample configuration YML might look like this:
```YAML
samples:
  - id: patient1
    libraries:
      - id: lib1
        readgroups:
          - id: lane1
            reads:
              R1: /home/user/data/patient1/R1.fq.gz
              R1_md5: /home/user/data/patient1/R1.fq.gz.md5
              R2: /home/user/data/patient1/R2.fq.gz
              R2_md5: /home/user/data/patient1/R2.fq.gz.md5
  - id: patient2
    libraries:
      - id: lib1
        readgroups:
          - id: lane1
            reads:
              R1: /home/user/data/patient2/lane1_R1.fq.gz
              R1_md5: /home/user/data/patient2/lane1_R1.fq.gz.md5
              R2: /home/user/data/patient2/lane1_R2.fq.gz
              R2_md5: /home/user/data/patient2/lane1_R2.fq.gz.md5
          - id: lane2
            reads:
              R1: /home/user/data/patient2/lane2_R1.fq.gz
              R1_md5: /home/user/data/patient2/lane2_R1.fq.gz.md5
              R2: /home/user/data/patient2/lane2_R2.fq.gz
              R2_md5: /home/user/data/patient2/lane2_R2.fq.gz.md5
```



### Output
This pipeline will produce a number of directories and files:
- **expression_measures**: Contains a number of directories with expression
measures.
  - **stringtie**: Contains the Stringtie output. Includes two additional files:
    `all_samples.FPKM` and `all_samples.TPM`, which contain the FPKM and TPM values
    for all samples.
    - **fragments_per_gene**: Contains the HTSeq-Count output. Also contains a
    file called `all_samples.fragments_per_gene`, which contains the counts for
    all samples.
- **samples**: Contains a folder per sample.
  - **&lt;sample>**: Contains a variety of files, including the BAM and gVCF
  (if variantcalling is enabled) files for this sample, as well as their indexes.
  It also contains a directory per library.
    - **&lt;library>**: Contains the BAM files for this library
    (`*.markdup.bam`) and a BAM file with additional preprocessing performed
    used for variantcalling (`*.markdup.bsqr.bam`). This second BAM file should
    not be used for expression quantification, because splicing events have
    been split into separate reads to improve variantcalling.  
    This directory also contains a directory per readgroup.
      - **&lt;readgroup>**: Contains QC metrics and preprocessed FastQ files,
      in case preprocessing was necessary.
- **multisample.vcf.gz**: If variantcalling is enabled, a multisample VCF file 
  with the variantcalling results.
- **multiqc**: Contains the multiqc report.

## Contact
<p>
  <!-- Obscure e-mail address for spammers -->
For any question about running this pipeline and feature requests, please use
the
<a href='https://github.com/biowdl/rna-seq/issues'>github issue tracker</a>
or contact
the SASC team
 directly at: 
<a href='&#109;&#97;&#105;&#108;&#116;&#111;&#58;&#115;&#97;&#115;&#99;&#64;&#108;&#117;&#109;&#99;&#46;&#110;&#108;'>
&#115;&#97;&#115;&#99;&#64;&#108;&#117;&#109;&#99;&#46;&#110;&#108;</a>.
</p>
