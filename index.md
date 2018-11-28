---
layout: default
title: Home
version: develop
latest: true
---

This pipeline can be used to process RNA-seq data, starting from FastQ files.
It will perform adapter clipping (using cutadapt), mapping (using STAR),
variantcalling (based on the GATK Best Practises) and expression
quantification (using HTSeq-Count, Stringtie and BaseCounter).

## Usage
In order to run the complete multisample pipeline, you can
run `pipeline.wdl` using
[Cromwell](http://cromwell.readthedocs.io/en/stable/):
```bash
java -jar cromwell-<version>.jar run -i inputs.json pipeline.wdl
```

The inputs.json possible inputs are listed below. 
Additional inputs are available. 
These can be generated using WOMtools as described in the 
[WOMtools-documentation](http://cromwell.readthedocs.io/en/stable/WOMtool/).
Beware that this will generate inputs for all the subworkflows and each task 
that is executed. Unless you have a specific requirement that needs a changed parameter
in a task somewhere, we recommend using this guide for defining your inputs.


| field | type | |
|-|-|-|
| sampleConfigFile | `File` | The sample configuration file. See below for more details. |
| starIndexDir | `String` | The STAR index. |
| reference | `Dict` | A dictionary containing the following fields <br>"fasta": a fasta file<br>"fai": The fasta index file<br>"dict": the picard index file |
| refflatFile | `File` | Reference annotation Refflat file. This will be used for expression quantification. |
| gtfFile | `File` | Reference annotation GTF file. This will be used for expression quantification. |
| dbsnp| `Dict` | Reference dbSNP VCF file. A dictionary containing the following fields: <br>"file": the dbsnp vcf file  <br>"index": the vcf index file  <br>"md5": Optional(not needed for operation) a md5 file for the vcf file.|
| dbstrandedness | `String` | Indicates the strandedness of the input data. This should be one of the following: FR (Forward, Reverse),RF (Reverse, Forward) or None: (Unstranded).

>All inputs have to be preceded by `pipeline.`.

### Sample configuration
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

## Tool versions
Included in the repository is an `environment.yml` file. This file includes
all the tool version on which the workflow was tested. You can use conda and
this file to create an environment with all the correct tools.

## Output
This pipeline will produce a number of directories and files:
- **expression_measures**: Contains a number of directories with expression
measures.
  - **BaseCounter**: Contains BaseCounter ouput. Includes a file called
  `all_samples.base.gene.counts`, which contains the counts for all samples.
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
- **multiqc**: Contains the multiqc report.
results.

## About
This pipeline is part of [BioWDL](https://biowdl.github.io/)
developed by [the SASC team](http://sasc.lumc.nl/).

## Contact
<p>
  <!-- Obscure e-mail address for spammers -->
For any question related to this pipeline, please use the
<a href='https://github.com/biowdl/rna-seq/issues'>github issue tracker</a>
or contact
 <a href='http://sasc.lumc.nl/'>the SASC team</a> directly at: <a href='&#109;&#97;&#105;&#108;&#116;&#111;&#58;&#115;&#97;&#115;&#99;&#64;&#108;&#117;&#109;&#99;&#46;&#110;&#108;'>
&#115;&#97;&#115;&#99;&#64;&#108;&#117;&#109;&#99;&#46;&#110;&#108;</a>.
</p>
