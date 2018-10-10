#!/bin/bash

source activate qiime2-2018.8

mkdir 01-trimmed
mkdir 01-trimmed/logs

for item in `ls 00-raw/*.R1.fastq.gz` 

	do

	filestem=`basename $item .R1.fastq.gz`
	R1=00-raw/$filestem.R1.fastq.gz
	R2=00-raw/$filestem.R2.fastq.gz

        cutadapt --pair-filter=both --error-rate=0.2 --discard-untrimmed \
	-g ^GTGYCAGCMGCCGCGGTAA -G ^CCGYCAATTYMTTTRAGTTT \
	-o 01-trimmed/${filestem}.R1.trimmed.fastq \
	-p 01-trimmed/${filestem}.R2.trimmed.fastq $R1 $R2 \
	2>&1 | tee -a 01-trimmed/logs/${filestem}.cutadapt.stderrout

done

source deactivate
