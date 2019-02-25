from pathlib import Path

import pysam
import pytest

@pytest.mark.workflow("Rna3PairedEndHisat2AndStar")
def test_star_used_for_downstream_analysis(workflow_dir):
    bam_path = workflow_dir / Path("test-output") / Path("samples") / Path("rna3-paired-end") / \
               Path("lib_lib1") / Path("rna3-paired-end-lib1.markdup.bam")
    bam_file = pysam.AlignmentFile(str(bam_path), "rb")
    programs = [ program.get('ID') for program in bam_file.header.get('PG') ]
    assert "STAR" in programs
