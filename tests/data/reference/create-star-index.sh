#!/usr/bin/env bash

# See STAR Manual for more information on running STAR on small genomes
STAR \
--runMode genomeGenerate \
--genomeDir star \
--genomeFastaFiles reference.fasta \
--genomeSAindexNbases 7
