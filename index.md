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

The inputs JSON can be generated using WOMtools as described in the [WOMtools
documentation](http://cromwell.readthedocs.io/en/stable/WOMtool/). Note that
not some inputs should not be used! See [this page](inputs.md) for more
information.

The primary inputs are described below, additional inputs (such as precommands
and JAR paths) are available. Please use the above mentioned WOMtools command
to see all available inputs.

| field | type | |
|-|-|-|
| sampleConfigFiles | `Array[File]` | The sample configuration files. See below for more details. |
| sample.library.starAlignment.<br />star.genomeDir | `String` | The STAR index. |
| refFasta | `File` | Reference fasta file. |
| refFastaIndex | `File` | Index for the reference fasta files. |
| refDict | `File` | The dict file for the referene fasta. |
| refRefflat | `File` | Reference annotation Refflat file. This will be used for expression quantification. |
| refGtf | `File` | Reference annotation GTF file. This will be used for expression quantification. |
| dbsnpVCF | `File` | Reference dbSNP VCF file. |
| dbsnpVCFindex | `File` | Index for the reference dbSNP VCF file. |
| strandedness | `String` | Indicates the strandedness of the input data. This should be one of the following: FR (Forward, Reverse),RF (Reverse, Forward) or None: (Unstranded).
| outputDir | `String` | The directory where the output will be placed. |
| sample.library.starAlignment.<br />star.twopassMode | `String?` | The STAR twopassMode argument to be passed to the `--twopassMode` option. If this is not defined twopassMode will not be used. |
| sample.library.readgroup.<br />platform| `String?` | The value to be given to the `PL` BAM flag. |
| sample.library.preprocessing.<br />baseRecalibrator.<br />knownIndelsSitesVCFs | `Array[File]?` | A VCF file containing known indels. |
| JointGenotyping.<br />mergeGvcfFiles | `Boolean?` | Whether or not to produce a multisample gVCF file. |

>All inputs have to be preceded by with `pipeline.`.
Type is indicated according to the WDL data types: `File` should be indicators
of file location (a string in JSON). Types ending in `?` indicate the input is
optional, types ending in `+` indicate they require at least one element.

### Sample configuration
The sample configuration should be a YML file which adheres to the following
structure:
```YML
samples:
  <sample>:
    libraries:
      <library>:
        readgroups:
          <readgroup>:
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
