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

import nl.biopet.utils.biowdl.PipelineSuccess

trait RNAseqSuccess extends RNAseq with PipelineSuccess {
  addConditionalFile(variantCalling, "multisample_variants/multisample.vcf.gz")
  addConditionalFile(variantCalling,
                     "multisample_variants/multisample.vcf.gz.tbi")
  addMustHaveFile("expression_measures/stringtie/TPM/all_samples.TPM")
  addMustHaveFile("expression_measures/stringtie/FPKM/all_samples.FPKM")
  //addMustHaveFile(
  //  "expression_measures/BaseCounter/all_samples.base.gene.counts")
  addMustHaveFile(
    "expression_measures/fragments_per_gene/all_samples.fragments_per_gene")
  addMustHaveFile("multisample_variants/stats")
}
