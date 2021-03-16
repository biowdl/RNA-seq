---
layout: default
title: Home
---

This workflow can be used to process RNA-seq data, starting from FastQ files.
It will perform quality control (using FastQC and MultiQC), adapter
clipping (using cutadapt), mapping (using STAR or HISAT2) and expression
quantification an transcript assembly (using HTSeq-Count and Stringtie).
Optionally variantcalling (based on the GATK Best Practises) and lncRNA
detection (using CPAT) can also be performed.

This workflow is part of [BioWDL](https://biowdl.github.io/)
developed by the SASC team
at [Leiden University Medical Center](https://www.lumc.nl/).

## Usage
This workflow can be run using
[Cromwell](http://cromwell.readthedocs.io/en/stable/):

First download the latest version of the workflow wdl file(s) and 
zip imports package from
the [releases page](https://github.com/biowdl/RNA-seq/releases).

The workflow can then be started with the following command:
```bash
java \
    -jar cromwell-<version>.jar \
    run \
    -o options.json \
    -i inputs.json \
    --imports RNA-seq_v<version>.zip \
    RNA-seq_<version>.wdl
```

Where `options.json` contains the following json:
```json
{
    "final_workflow_outputs_dir": "/path/to/outputs",
    "use_relative_output_paths": true,
    "final_workflow_log_dir": "/path/to/logs/folder"
}
```

The `options.json` will make sure all outputs end up in `/path/to/outputs` in
an easy to navigate folder structure.

### Inputs
Inputs are provided through a JSON file. The minimally required inputs are
described below, but additional inputs are available.
A template containing all possible inputs can be generated using
Womtool as described in the
[WOMtool documentation](http://cromwell.readthedocs.io/en/stable/WOMtool/).
For an overview of all available inputs, see [this page](./inputs.html).

```json
{
    "RNAseq.sampleConfigFile":"The sample configuration file. See below for more details.",
    "RNAseq.dockerImagesFile": "A file listing the used docker images.",
    "RNAseq.starIndex": "A list of star index files.",
    "RNAseq.referenceFasta": "A path to a reference fasta.",
    "RNAseq.referenceFastaFai": "The path to the index associated with the reference fasta.",
    "RNAseq.referenceFastaDict": "The path to the dict file associated with the reference fasta.",
    "RNAseq.refflatFile": "Reference annotation Refflat file. This will be used for expression quantification.",
    "RNAseq.referenceGtfFile": "Reference annotation GTF file. This will be used for expression quantification.",
    "RNAseq.strandedness": "Indicates the strandedness of the input data. This should be one of the following: FR (Forward, Reverse), RF (Reverse, Forward) or None: (Unstranded)."
}
```

If you wish to use hisat2 instead, set the list of hisat2 index files on
`RNAseq.hisat2Index`.

If neither a `starIndex` nor a `hisat2Index` is provided, then a STAR index
will be generated on the fly using the provided GTF file and reference Fasta.

The `referenceGtfFile` may also be omitted, in this case Stringtie will be
used to perform an unguided assembly, which will then be used for
expression quantification.

Optional settings:
```json
{
    "RNAseq.adapterForward": "Used to set a forward read adapter. Default: Illumina Universal Adapter  AGATCGGAAGAG.",
    "RNAseq.adapterReverse": "Used to set a reverse read adapter (for paired-end reads). Default: Illumina Universal Adapter  AGATCGGAAGAG.",
    "RNAseq.umiDeduplication": "Whether or not UMI based deduplication should be run. See the notes below on UMIs.",
    "RNAseq.scatterSizeMillions": "The size of the scattered regions in million bases for the GATK subworkflows. Scattering is used to speed up certain processes. The genome will be seperated into multiple chunks (scatters) which will be processed in their own job, allowing for parallel processing. Higher values will result in a lower number of jobs. The optimal value here will depend on the available resources."
}
```

UMIs are expected to have been extracted from the input fastq files and
added to the headers of the reads. A tool
like [UMI-tools](https://umi-tools.readthedocs.io/en/latest/) may be used to
do so. Please be aware that different library preparation protocols
will put the UMIs in different locations in your reads, so be careful
when extracting the UMIs!

#### Sample configuration
##### Verification
All samplesheet formats can be verified using `biowdl-input-converter`.
It can be installed with `pip install biowdl-input-converter` or
`conda install biowdl-input-converter` (from the bioconda channel).
Python 3.7 or higher is required.

With `biowdl-input-converter --validate samplesheet.csv` The file
"samplesheet.csv" will be checked. Also the presence of all files in
the samplesheet will be checked to ensure no typos were made. For more
information check out the [biowdl-input-converter readthedocs page](
https://biowdl-input-converter.readthedocs.io).

##### CSV format
The sample configuration can be given as a csv file with the following
columns: sample, library, readgroup, R1, R1_md5, R2, R2_md5.

column name | function
---|---
sample | sample ID
library | library ID. These are the libraries that are sequenced. Usually
there is only one library per sample.
readgroup | readgroup ID. Usually a library is sequenced on multiple lanes in
the sequencer, which gives multiple fastq files (referred to as readgroups).
Each readgroup pair should have an ID.
R1| The fastq file containing the first reads of the read pairs.
R1_md5 | Optional: md5sum for the R1 file.
R2| Optional: The fastq file containing the reverse reads.
R2_md5| Optional: md5sum for the R2 file.

The easiest way to create a samplesheet is to use a spreadsheet program
such as LibreOffice Calc or Microsoft Excel, and create a table:

sample | library | readgroup | R1 | R1_md5 | R2 | R2_md5
-------|---------|------|----|--------|----|-------
sample1|lib1|rg1|data/s1-l1-rg1-r1.fastq|||
sample2|lib1|rg1|data/s1-l1-rg1-r2.fastq|||

NOTE: R1_md5, R2 and R2_md5 are optional do not have to be filled. And
additional fields may be added (eg. for documentation purposes), these will be
ignored by the workflow.

After creating the table in a spreadsheet program it can be saved in 
csv format.
 
##### YAML format
The sample configuration can also be a YML file which adheres to the following
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
```json
{
    "RNAseq.variantCalling": "Whether or not variantcalling should be performed, defaults to False.",
    "RNAseq.dbsnpVCF": "A VCF file to aid in the variantcalling.",
    "RNAseq.dbsnpVCFIndex": "The index for the dbsnpVCF."
}
```

And these settings are optional when variant calling is performed:
```json
{
    "RNAseq.variantCallingRegions": "A BED file that describes the regions where variants should be called."
}
```

#### lncRNA detection
In order to perform lncRNA detection the following inputs are also required:
```json
{
    "RNAseq.lncRNAdetection": "Whether or not lncRNA detection should be performed, defaults to False",
    "RNAseq.lncRNAdatabases": "A list of gtf files containing known lncRNAs",
    "RNAseq.cpatLogitModel": "The CPAT logitModel to be used",
    "RNAseq.cpatHex": "The CPAT hexamer tab file to be used"
}
```

#### Example
The following is an example of what an inputs JSON might look like:
```json
{
    "RNAseq.sampleConfigFile":"/home/user/analysis/samples.yml",
    "RNAseq.starIndex": [
        "/reference/star/chrLength.txt",
        "/reference/star/chrName.txt",
        "/reference/star/chrNameLength.txt",
        "/reference/star/chrStart.txt",
        "/reference/star/Genome",
        "/reference/star/genomeParameters.txt",
        "/reference/star/SA",
        "/reference/star/SAindex"
    ],
    "RNAseq.variantCalling": true,
    "RNAseq.lncRNAdetection": true,
    "RNAseq.referenceFasta": "/home/user/genomes/human/GRCh38.fasta",
    "RNAseq.referenceFastaFai": "/home/user/genomes/human/GRCh38.fasta.fai",
    "RNAseq.referenceFastaDict": "/home/user/genomes/human/GRCh38.dict",
    "RNAseq.dbsnpVCF": "/home/user/genomes/human/dbsnp/dbsnp-151.vcf.gz",
    "RNAseq.dbsnpVCFIndex": "/home/user/genomes/human/dbsnp/dbsnp-151.vcf.gz.tbi",
    "RNAseq.lncRNAdatabases": ["/home/user/genomes/human/NONCODE.gtf"],
    "RNAseq.cpatLogitModel": "/home/user/genomes/human/GRCH38_logit",
    "RNAseq.cpatHex": "/home/user/genomes/human/GRCH38_hex.tab",
    "RNAseq.refflatFile": "/home/user/genomes/human/GRCH38_annotation.refflat",
    "RNAseq.gtfFile": "/home/user/genomes/human/GRCH38_annotation.gtf",
    "RNAseq.strandedness": "RF",
    "RNAseq.dockerImagesFile": "dockerImages.yml"
}
```

And the associated samplesheet might look like this:

sample | library | readgroup | R1 | R1_md5 | R2 | R2_md5
-------|---------|------|----|--------|----|-------
patient1|lib1|lane1|/home/user/data/patient1/R1.fq.gz|181a657e3f9c3cde2d3bb14ee7e894a3|/home/user/data/patient1/R2.fq.gz|ebe473b62926dcf6b38548851715820e
patient2|lib1|lane1|/home/user/data/patient2/lane1_R1.fq.gz|7e79b87d95573b06ff2c5e49508e9dbf|/home/user/data/patient2/lane1_R2.fq.gz|dc2776dc3a07c4f468455bae1a8ff872
patient2|lib1|lane2|/home/user/data/patient2/lane2_R1.fq.gz|18e9b2fef67f6c69396760c09af8e778|/home/user/data/patient2/lane2_R2.fq.gz|72209cc64510827bc3f849bab00dfe7d

Saved as csv format it will look like this.

```csv
"sample","library","readgroup","R1","R1_md5","R2","R2_md5"
"patient1","lib1","lane1","/home/user/data/patient1/R1.fq.gz","181a657e3f9c3cde2d3bb14ee7e894a3","/home/user/data/patient1/R2.fq.gz","ebe473b62926dcf6b38548851715820e"
"patient2","lib1","lane1","/home/user/data/patient2/lane1_R1.fq.gz","7e79b87d95573b06ff2c5e49508e9dbf","/home/user/data/patient2/lane1_R2.fq.gz","dc2776dc3a07c4f468455bae1a8ff872"
"patient2","lib1","lane2","/home/user/data/patient2/lane2_R1.fq.gz","18e9b2fef67f6c69396760c09af8e778","/home/user/data/patient2/lane2_R2.fq.gz","72209cc64510827bc3f849bab00dfe7d"
```

The workflow also supports tab- and ;-delimited files.

## Dependency requirements and tool versions
Biowdl workflows use docker images to ensure reproducibility. This
means that biowdl workflows will run on any system that has docker
installed. Alternatively they can be run with singularity.

For more advanced configuration of docker or singularity please check
the [cromwell documentation on containers](
https://cromwell.readthedocs.io/en/stable/tutorials/Containers/).

Images from [biocontainers](https://biocontainers.pro) are preferred for
biowdl workflows. The list of default images for this workflow can be
found in the default for the `dockerImages` input.

## Output
This workflow will produce a number of directories and files:
- **expression_measures**: Contains a number of directories with expression
measures.
  - **stringtie**: Contains the Stringtie output. Includes two additional files:
    `all_samples.FPKM` and `all_samples.TPM`, which contain the FPKM and TPM
    values for all samples.
  - **fragments_per_gene**: Contains the HTSeq-Count output. Also contains a
    file called `all_samples.fragments_per_gene`, which contains the counts for
    all samples.
- **samples**: Contains a folder per sample.
  - **&lt;sample>**: Contains a variety of files, including the BAM and its
    index (`*.markdup.bam`) and (if variant calling is enabled) a BAM file
    with additional preprocessing performed used for
    variantcalling (`*.markdup.bsqr.bam`). This second BAM file should not be
    used for expression quantification, because splicing events have been
    split into separate reads to improve variantcalling. It also contains a
    directory per library. The vcf files for each sample are also here.
    - **&lt;library--readgroup>**: Contains QC metrics and preprocessed
      FastQ files, in case preprocessing was necessary. Also contains
      alignment reports for the individual readgroup.
- **lncrna**: contains all the files for detecting long non-coding
  RNA transcripts.
  - **coding-potential**. Contains a transcripts.fasta file with transcripts
    from the GFF. In cpat.tsv these transcripts are rated for their
    coding potential.
  - **&lt;reference.gtf.d>** Folders where the found transcripts are compared
    to gtf files from databases.
- **multiqc_report.html**: The multiqc report.

## Contact
<p>
  <!-- Obscure e-mail address for spammers -->
For any questions about running this workflow and feature requests (such as
adding additional tools and options), please use the
<a href="https://github.com/biowdl/rna-seq/issues">github issue tracker</a>
or contact the SASC team directly at: 
<a href="&#109;&#97;&#105;&#108;&#116;&#111;&#58;&#115;&#97;&#115;&#99;&#64;&#108;&#117;&#109;&#99;&#46;&#110;&#108;">
&#115;&#97;&#115;&#99;&#64;&#108;&#117;&#109;&#99;&#46;&#110;&#108;</a>.
</p>
