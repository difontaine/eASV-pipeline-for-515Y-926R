#!/bin/bash

source activate bbmap-env

mkdir 02-PROKs
mkdir 02-EUKs

mkdir 02-PROKs/00-fastq
mkdir 02-EUKs/00-fastq

mkdir logs/02-bbsplit

for item in `ls 01-trimmed/*.R1.trimmed.fastq`

	do

	filestem=`basename $item .R1.trimmed.fastq`
	R1in=01-trimmed/$filestem.R1.trimmed.fastq
	R2in=01-trimmed/$filestem.R2.trimmed.fastq

	bbsplit.sh usequality=f qtrim=f minratio=0.30 minid=0.30 pairedonly=f \
	ref=/home/db/bbsplit-db/SILVA_132_and_PR2_EUK.cdhit95pc.fasta,/home/db/bbsplit-db/SILVA_132_PROK.cdhit95pc.fasta \
	in=$R1in in2=$R2in basename=$filestem.trimmed.%_#.fastq \
	2>&1 | tee -a logs/02-bbsplit/$filestem.bbsplit_log

done

mv *EUK*fastq 02-EUKs/00-fastq
mv *PROK*fastq 02-PROKs/00-fastq

source deactivate