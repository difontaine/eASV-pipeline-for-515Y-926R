# eASV-pipeline-for-515Y-926R
This is a collection of basic scripts for analyzing mixed 16S/18S amplicon sequences using bbtools, qiime2, deblur, biom, BLAST, and other tools. They are basically wrappers of a wrapper (qiime2), and are designed to make the in silico workflow for the 515Y/926R primer set easier, reproducible, and more accessible.

Scripts are either python or bash scripts, and are designed for the pre-set conda environments on kraken.usc.edu. However, they could easily be used elsewhere by installing the conda environment for qiime2 specified in the scripts and a separate environment (called bbmap-env) that has Brian Bushnell's Bestus Bioinformaticus Tools installed.

If you're following the default Fuhrman Lab pipeline, just pull down the DADA2 branch:

`git clone -b DADA2 --single-branch https://github.com/jcmcnch/eASV-pipeline-for-515Y-926R.git`

You can follow this protocol for the DADA2 default Fuhrman lab pipeline:
https://www.protocols.io/private/C0F9404AB3DAEC96683F142351CEF59C

There may be some cases in which you wish to use Deblur (for example, perhaps you forgot to add mock communities to your run?). In this case, use the Deblur branch:

`git clone -b Deblur --single-branch https://github.com/jcmcnch/eASV-pipeline-for-515Y-926R.git`

You can follow this protocol for the Deblur Fuhrman lab pipeline (non-default but maybe it will be useful):
https://www.protocols.io/private/6C81EC4BC2074A76D7ACF80E2F0603B7

If you'd like to use these scripts as a starting point for your analysis but are not using the Fuhrman lab primers / mock communities, we think it's safer to use Deblur*. YOu can pull down the scripts here which have some changes to make them more generally applihttps://www.protocols.io/private/6C81EC4BC2074A76D7ACF80E2F0603B7cable (they also include some templates for preparing your classfication database):

`git clone -b Deblur-template --single-branch https://github.com/jcmcnch/eASV-pipeline-for-515Y-926R.git`

You can follow this protocol for the Deblur pipeline template (should be enough to get started):
https://www.protocols.io/private/7714BDE068BA6E75FF2B89082009590F

*While DADA2 is superior to Deblur in terms of sequence recovery (especially for our Eukaryotic amplicons - ~80% DADA2 vs ~20% Deblur), we have noticed that it creates spurious eASVs on occasion (a spurious eASV is defined here as an eASV with 1 mismatch to the reference mock community sequence that cannot be accounted for by sample bleedthrough). This seems to be either due to noisy data (e.g. 2x300 PE reads) or due to something that trips up the error model (i.e. it happened once when we had in extra mocks from the same run but different lane that had more reads on average than the first lane). For us, this isn't necessarily a problem since we use the mocks as a way to validate our results, and we can tweak parameters to avoid these potential artifacts. But for those who don't have access to the mocks, or those who are working with data downloaded from the SRA, then it will be easier to use Deblur.
