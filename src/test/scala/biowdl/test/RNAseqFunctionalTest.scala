/*
 * Copyright (c) 2018 Biowdl
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

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
