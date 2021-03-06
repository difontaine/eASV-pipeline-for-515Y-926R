#!/bin/bash

source activate bbmap-env

#we normally add in our in-silico mocks to check the denoising pipeline's performance, but this is only relevant if you actually have real mocks as well
#cp /home/db/in-silico-mocks/*fastq 01-trimmed/

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

	bbsplit.sh usequality=f qtrim=f minratio=0.30 minid=0.30 pairedonly=f threads=20 -Xmx100g \
	path=/home/db/bbsplit-db/EUK-PROK-bbsplit-db/ \
	in=$R1in in2=$R2in basename=$filestem.trimmed.%_#.fastq \
	2>&1 | tee -a logs/02-bbsplit/$filestem.bbsplit_log

done

mv *EUK*fastq 02-EUKs/00-fastq
mv *PROK*fastq 02-PROKs/00-fastq

rm -rf ref

conda deactivate
