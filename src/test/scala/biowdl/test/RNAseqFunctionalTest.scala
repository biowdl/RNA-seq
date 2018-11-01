package biowdl.test

import java.io.File

import nl.biopet.utils.biowdl.annotations.Ensembl87
import nl.biopet.utils.biowdl.fixtureFile
import nl.biopet.utils.biowdl.references.GRCh38_no_alt_analysis_set
import nl.biopet.utils.biowdl.samples.{
  Rna1PairedEnd,
  Rna1SingleEnd,
  Rna2PairedEnd,
  Rna2SingleEnd
}

class RNAseqSingleEndFunctionalTest
    extends RNAseqSuccess
    with Rna1SingleEnd
    with Rna2SingleEnd
    with GRCh38_no_alt_analysis_set
    with Ensembl87 {
  def dbsnpFile: File =
    fixtureFile("references",
                "H.sapiens",
                "GRCh38_no_alt_analysis_set",
                "annotation",
                "dbsnp",
                "dbsnp-149.vcf.gz")
  override def functionalTest: Boolean = true
  override def inputs: Map[String, Any] =
    super.inputs ++ Map(
      "pipeline.sample.Sample.library.Library.starAlignment.AlignStar.star.runThreadN" -> 8
    )
  override def strandedness: String = "None"
}

class RNAseqPairedEndFunctionalTest
    extends RNAseqSuccess
    with Rna1PairedEnd
    with Rna2PairedEnd
    with GRCh38_no_alt_analysis_set
    with Ensembl87 {
  def dbsnpFile: File =
    fixtureFile("references",
                "H.sapiens",
                "GRCh38_no_alt_analysis_set",
                "annotation",
                "dbsnp",
                "dbsnp-149.vcf.gz")
  override def functionalTest: Boolean = true
  override def inputs: Map[String, Any] =
    super.inputs ++ Map(
      "pipeline.sample.Sample.library.Library.starAlignment.AlignStar.star.runThreadN" -> 8
    )
  override def strandedness: String = "None"
}
