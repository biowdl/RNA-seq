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

import nl.biopet.utils.biowdl.fixtureFile
import nl.biopet.utils.biowdl.annotations.TestAnnotation
import nl.biopet.utils.biowdl.references.TestReference
import nl.biopet.utils.biowdl.samples.{Rna3PairedEnd, Rna3SingleEnd}

class RNAseqTestSingleEndLncRNA
    extends RNAseqSuccess
    with TestReference
    with TestAnnotation
    with Rna3SingleEnd {
  def strandedness: String = "None"
  def dbsnpFile: File = fixtureFile("samples", "wgs2", "wgs2.vcf.gz")
  override def lncRNAdetection: Boolean = true
  override def inputs = super.inputs ++ Map(
    "pipeline.cpatLogitModel" -> fixtureFile("cpat", "Human_logitModel.RData"),
    "pipeline.cpatHex" -> fixtureFile("cpat", "Human_Hexamer.tsv")
  )
}

class RNAseqTestPairedEndLncRNA
    extends RNAseqSuccess
    with TestReference
    with TestAnnotation
    with Rna3PairedEnd {
  def strandedness: String = "None"
  def dbsnpFile: File = fixtureFile("samples", "wgs2", "wgs2.vcf.gz")

  override def lncRNAdetection: Boolean = true
  override def inputs = super.inputs ++ Map(
    "pipeline.cpatLogitModel" -> fixtureFile("cpat", "Human_logitModel.RData"),
    "pipeline.cpatHex" -> fixtureFile("cpat", "Human_Hexamer.tsv")
  )
}

class RNAseqTestSingleEndVariantCalling
    extends RNAseqSuccess
    with TestReference
    with TestAnnotation
    with Rna3SingleEnd {
  def strandedness: String = "None"
  def dbsnpFile: File = fixtureFile("samples", "wgs2", "wgs2.vcf.gz")
  override def variantCalling = true
}

class RNAseqTestPairedEndVariantCalling
    extends RNAseqSuccess
    with TestReference
    with TestAnnotation
    with Rna3PairedEnd {
  def strandedness: String = "None"
  def dbsnpFile: File = fixtureFile("samples", "wgs2", "wgs2.vcf.gz")
  override def variantCalling = true
}
