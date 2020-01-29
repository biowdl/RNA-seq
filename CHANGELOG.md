Changelog
==========

<!--

Newest changes should be on top.

This document is user facing. Please word the changes in such a way
that users understand how the changes affect the new version.
-->

version 2.1.0-dev
-----------------
+ Fixed typo in index.md for dbsnp input.
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
+ Update biowdl-input-converter tot the latest bugfix release (0.2.1)
+ Update STAR version to 2.7.3a
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
+ Update cutadapt version to 2.4
