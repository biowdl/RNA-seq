Changelog
==========

<!--
Newest changes should be on top.

This document is user facing. Please word the changes in such a way
that users understand how the changes affect the new version.
-->

version 5.0.0
---------------------------
+ Update default CPAT version to 3.0.4.
+ Use gffcompare to merge stringtie assembly GTF files, rather than stringtie merge.
+ Add call to create annotation file for shiny app.
+ Add call to create design matrix template for shiny app.
+ Add predex v0.9.2 container to dockerImages.
+ dockerImages.yml: update umitools (v1.1.1) image with correct version of samtools (1.10).
+ test/cromwell_options.json: add memory attribute.
+ dockerImages.yml: update umitools to version 1.1.1 (multi-package including samtools).
+ Replace travis with github CI.
+ Add the dockerImages to the output section.
+ Make running stringtie optional by exposing the boolean
  `runStringtieQuantification`.
+ Downgrade stringtie to version 1.3.6, as version 2 returns unstranded
  transcripts which is incompatible with htseq-count.
+ When multiple TPM/FPKM values are returned for a single gene by
  stringtie, they will now be added together in the multi-sample
  expression tables. Previously only the last value encountered would be
  used.
+ Updated default docker image for collect-columns (now uses version 1.0.0
  instead of 0.2.0).

version 4.0.0
---------------------------
+ Default docker images for various tools have been updated.
+ Changes in Cromwell 48 made it impossible to use the wide array of inputs
  in our documentation (such as
  `RNAseq.sampleJobs.qc.Cutadapt.minimumLength`). Fixes have been made
  upstream and in the pipeline. From Cromwell 52 onwards these options will be
  available again.
+ Bam files are no longer indexed after alignment, saving compute time.
+ WDL files and imports zip packages are now provided each release to make
  running pipelines easier.
+ The output directory was simplified. All files related to a sample are now
  in the `samples/<sample_id>` directory.
+ Use the scatter-regions tool to replace biopet-scatterregions.
+ The pipeline was renamed from "pipeline" to "RNAseq".
+ Tasks were updated to contain the `time_minutes` runtime attribute and
  associated `timeMinutes` input, describing the maximum time the task will
  take to run.
+ Added a step to generate the STAR index, if neither a STAR nor a Hisat2
  index is provided.
+ Document the use of cromwell's `final_workflow_outputs_dir` feature which
  makes the RNA-seq pipeline usable on all of Cromwell's supported backends.
  Users are encouraged to use this feature. `outputDir` references are 
  removed from the documentation.
+ Make the MultiQC task suitable for use with a `final_workflow_outputs_dir`
  so it can be used on all of Cromwell's supported backends.
+ Added a picard markduplicates step after UMI deduplication.
+ Move common optional inputs to top-level workflow, so nested inputs are not
  required anymore for the majority of configurations.
+ The pipeline has been altered so it starts the variant calling jobs in a
  more efficient way.
+ Major bug fix: The --dont-use-soft-clipped-reads is now used on
  HaplotypeCaller in concordance with GATK best practices.

version 3.0.0
---------------------------
In version 3.0.0 the RNA-seq pipeline was brought up to date with the
GATK best practices pipeline. Several errors in the variant calling part of
the pipeline were fixed.

+ UMI deduplication stats collection is now optional.
+ Add scatterSize option to centrally control the scatter size.
+ Multisample VCFs are no longer generated for RNA-seq by default as this is
  not GATK best practice. It can optionally be turned on again.
+ Add proper copyright headers to WDL files. So the free software license
  is clear to end users who wish to adapt and modify.
+ Added UMI based deduplication as an optional step.
+ Major fix: Joint genotyping is not performed on RNA-seq reads. Instead, each
  sample is genotyped seperately by the HaplotypeCaller.
+ Major fix: base recalibration is now applied after splitting the cigar reads.
  previously this was done in an erroneous manner.
+ Structs are removed from the input.
+ Fixed a typo in the inputs: detectNovelTranscipts -> detectNovelTranscripts.
+ Removed a number of unused inputs ("dbsnp", "targetIntervals",
  "ampliconIntervals" and "variantCalling") from the sample workflow.
+ Added input overview to docs.
+ Added WDL-AID to linting.
+ Update default htseq image version to 0.11.2.

version 2.0.0
---------------------------
+ Replace the bam-to-gvcf and jointgenotyping pipelines with a
  gatk-variantcalling pipeline. This reduces complexity, allows for
  more efficient running of the pipeline and uses less filesystem
  storage.
+ Update biowdl-input-converter tot the latest bugfix release (0.2.1).
+ Update STAR version to 2.7.3a.
+ Simplify the pipeline so it uses much less subworkflows. This reduces
  the complexity for cromwell and reduces inefficiencies that are caused
  by waiting for the subworkflows to finish.
  It also makes configuring memory or cpu requirements for tasks in the
  workflow a lot easier, as these are not as deeply nested anymore.

version 1.1.0
---------------------------
+ Allow using csv table format samplesheet as input format.
+ Update tasks so they pass the correct memory requirements to the
  execution engine. Memory requirements are set on a per-task (not
  per-core) basis.

version 1.0.0
---------------------------
+ Make sure documentation is up to date with the latest pipeline.
+ Update documentation to reflect changes in QC pipeline.
+ Picard updated to 2.20.5. Picard+r container not necessary anymore.
+ Update cutadapt version to 2.4.
