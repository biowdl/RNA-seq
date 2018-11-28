---
layout: default
title: Inputs
version: develop
latest: true
---

Most inputs which are not discussed in the [usage](index.md#Usage) correspond
to an option or argument for a specific tool and should be self-explanatory
when compared to the relevant tool's documentation.

If something is unclear or an option/argument is unavailable, please file an
[issue](https://github.com/biowdl/rna-seq/issues).

## The input JSON

The inputs JSON can be generated using WOMtools as described in the [WOMtools
documentation](http://cromwell.readthedocs.io/en/stable/WOMtool/). However,
some of the inputs presented in this JSON file should not be used/changed. This
is because certain tools have inputs which are changeable, due to the usage of
reusable tasks definitions for these tools. They were defined in this manner
to allow for the task to be used in different workflows and different
situations. In some cases, though, a specific workflow requires specific values
to be given to some of these options.

Please do not use the following inputs:
- pipeline.config.sample
- pipeline.config.library
- pipeline.config.readgroup
- pipeline.sample.config.library
- pipeline.sample.config.readgroup
- pipeline.sample.library.config.readgroup
- pipeline.sample.library.starAlignment.star.outSAMtype
- pipeline.sample.library.starAlignment.star.readFilesCommand
- pipeline.expression.htSeqCount.format
- pipeline.expression.htSeqCount.order

> DISCLAIMER: Some inputs may have been missed in this list.

Type is indicated according to the WDL data types: `File` should be indicators
of file location (a string in JSON). Types ending in `?` indicate the input is
optional, types ending in `+` indicate they require at least one element.

## Precommands
Many tasks have a `preCommand` input available. This is an input which can be
used to execute some bash code before a tool is run. This could be used to,
for example, activate a Conda environment before running a certain job.

## Java tasks

### JARs
Java tools will have a JAR input available which can be used to set the
location of the JAR file for a certain tool. If this input is not given the
assumption is made that a Conda environment is used in which the tool is
installed and the tool can be run without explicitly calling java. eg.
picard will be run as `picard -Xmx4G ...`, rather than
`java -Xmx4G -jar <picardJar> ...`

### Memory and memory multiplier
Java tools will have a `memory` and `memoryMultiplier` input available. The
first can be used to set the value given to java's `-Xmx` option. The second
is used to determine the actual runtime memory setting, which will equal
`memory * memoryMultiplier`.
