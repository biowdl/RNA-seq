---
layout: default
title: Home
version: develop
latest: false
---

This pipeline can be used to process RNA-seq data, starting from FastQ files.
It will perform adapter clipping (using cutadapt), mapping (using STAR),
variantcalling (based on the GATK Best Practises) and expression
quantification (using HTSeq-Count and Stringtie).

This pipeline is part of [BioWDL](https://biowdl.github.io/)
developed by [the SASC team](http://sasc.lumc.nl/).

## Usage
This pipeline can be run using
[Cromwell](http://cromwell.readthedocs.io/en/stable/):
```bash
java -jar cromwell-<version>.jar run -i inputs.json pipeline.wdl
```

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
  "pipeline.starIndexDir": "The STAR index.",
  "pipeline.reference": {
    "fasta": "A path to a reference fasta",
    "fai": "The path to the index associated with the reference fasta",
    "dict": "The path to the dict file associated with the reference fasta"
  },
  "pipeline.dbSNP": {
    "file": "A path to a dbSNP VCF file",
    "index": "The path to the index (.tbi) file associated with the dbSNP VCF"
  },
  "pipeline.outputDir": "The path to the output directory",
  "pipeline.refflatFile": "Reference annotation Refflat file. This will be used for expression quantification.",
  "pipeline.gtfFile": "Reference annotation GTF file. This will be used for expression quantification.",
  "pipeline.strandedness": "Indicates the strandedness of the input data. This should be one of the following: FR (Forward, Reverse),RF (Reverse, Forward) or None: (Unstranded)"
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

#### Example

The following is an example of what an inputs JSON might look like:
```JSON
{
 "pipeline.sampleConfigFile":"/home/user/analysis/samples.yml",
  "pipeline.starIndexDir": "/home/user/genomes/human/bwa/GRCh38/star",
  "pipeline.reference": {
    "fasta": "/home/user/genomes/human/GRCh38.fasta",
    "fai": "/home/user/genomes/human/GRCh38.fasta.fai",
    "dict": "/home/user/genomes/human/GRCh38.dict"
  },
  "pipeline.dbSNP": {
    "file": "/home/user/genomes/human/dbsnp/dbsnp-151.vcf.gz",
    "index": "/home/user/genomes/human/dbsnp/dbsnp-151.vcf.gz.tbi"
  },
  "pipeline.outputDir": "/home/user/analysis/results",
  "pipeline.refflatFile": "/home/user/genomes/human/GRCH38_annotation.refflat",
  "pipeline.gtfFile": "/home/user/genomes/human/GRCH38_annotation.gtf",
  "pipeline.strandedness": "FR"
}
```

And the associated sample configuration YML might look like this:
```YAML
samples:
  - id: patient1:
    libraries:
      - id: lib1:
        readgroups:
          - id: lane1:
            reads:
              R1: /home/user/data/patient1/R1.fq.gz
              R1_md5: /home/user/data/patient1/R1.fq.gz.md5
              R2: /home/user/data/patient1/R2.fq.gz
              R2_md5: /home/user/data/patient1/R2.fq.gz.md5
  - id: patient2:
    libraries:
      - id: lib1:
        readgroups:
          - id: lane1:
            reads:
              R1: /home/user/data/patient2/lane1_R1.fq.gz
              R1_md5: /home/user/data/patient2/lane1_R1.fq.gz.md5
              R2: /home/user/data/patient2/lane1_R2.fq.gz
              R2_md5: /home/user/data/patient2/lane1_R2.fq.gz.md5
          - id: lane2:
            reads:
              R1: /home/user/data/patient2/lane2_R1.fq.gz
              R1_md5: /home/user/data/patient2/lane2_R1.fq.gz.md5
              R2: /home/user/data/patient2/lane2_R2.fq.gz
              R2_md5: /home/user/data/patient2/lane2_R2.fq.gz.md5
```

### Dependency requirements and tool versions
Included in the repository is an `environment.yml` file. This file includes
all the tool version on which the workflow was tested. You can use conda and
this file to create an environment with all the correct tools.

### Output
This pipeline will produce a number of directories and files:
- **expression_measures**: Contains a number of directories with expression
measures.
  - **stringtie**: Contains the stringtie output. Includes two additional
  folder:
    - **FPKM**: Contains per sample FPKM counts, extracted from the stringtie
    abundance output. Also contains a file called `all_samples.FPKM`, which
    contains the FPKM values for all samples.
    - **TPM**: Contains per sample TPM counts, extracted from the stringtie
    abundance output. Also contains a file called `all_samples.TPM`, which
    contains the TPM values for all samples.
  - **fragments_per_gene**: Contains the HTSeq-Count output. Also contains a
  file called `all_samples.fragments_per_gene`, which contains the counts for
  all samples.
- **samples**: Contains a folder per sample.
  - **&lt;sample>**: Contains a variety of files, including the BAM and gVCF
  files for this sample, as well as their indexes. It also contains a directory
  per library.
    - **&lt;library>**: Contains the BAM files for this library
    (`*.markdup.bam`) and a BAM file with additional preprocessing performed
    used for variantcalling (`*.markdup.bsqr.bam`). This second BAM file should
    not be used for expression quantification, because splicing events have
    been split into separate reads to improve variantcalling.  
    This directory also contains a directory per readgroup.
      - **&lt;readgroup>**: Contains QC metrics and preprocessed FastQ files,
      in case preprocessing was necessary.
- **multisample.vcf.gz**: A multisample VCF file with the variantcalling
  results.
- **multiqc**: Contains the multiqc report.

## Contact
<p>
  <!-- Obscure e-mail address for spammers -->
For any question about running this pipeline and feature requests, please use
the
<a href='https://github.com/biowdl/rna-seq/issues'>github issue tracker</a>
or contact
<a href='http://sasc.lumc.nl/'>the SASC team</a> directly at: <a href='&#109;&#97;&#105;&#108;&#116;&#111;&#58;&#115;&#97;&#115;&#99;&#64;&#108;&#117;&#109;&#99;&#46;&#110;&#108;'>
&#115;&#97;&#115;&#99;&#64;&#108;&#117;&#109;&#99;&#46;&#110;&#108;</a>.
</p>
