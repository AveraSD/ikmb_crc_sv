#!/bin/bash

ID=H28658

tumorBAM=~/AWS/storage/ikmb_alex_crc/lc_wgs/H28658/alignment/H28658_realigned_sorted.bam
normalBAM=~/AWS/storage/ikmb_alex_crc/lc_wgs/H28658/alignment/H28650_realigned_sorted.bam

tumorWIG=~/AWS/storage/ikmb_alex_crc/lc_wgs/H28658/alignment/H28658_realigned_sorted.wig
normalWIG=~/AWS/storage/ikmb_alex_crc/lc_wgs/H28658/alignment/H28650_realigned_sorted.wig

HMMreadCounter=~/bin/hmmcopy_utils/bin/readCounter
IchorCNA=~/bin/ichorCNA/scripts/runIchorCNA.R
IchorDATA=~/bin/ichorCNA/inst/extdata

outDir=~/AWS/storage/ikmb_alex_crc/lc_wgs/H28658/IchorCNA

if [ -d $outDir ]; then
  rm -r $outDir
fi

mkdir -p $outDir

## generate read count data
$HMMreadCounter \
	--window 10000 \
	--quality 20 \
	--chromosome "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,X,Y" \
	$tumorBAM > $tumorWIG

$HMMreadCounter \
	--window 10000 \
	--quality 20 \
	--chromosome "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,X,Y" \
	$normalBAM > $normalWIG

Rscript $IchorCNA --id $ID \
	--WIG $tumorWIG \
	--NORMWIG=$normalWIG \
	--ploidy "c(2,3)" \
	--normal "c(0.5,0.6,0.7,0.8,0.9)" \
	--gcWig $IchorDATA/gc_hg19_10kb.wig \
	--mapWig $IchorDATA/map_hg19_10kb.wig \
	--centromere $IchorDATA/GRCh37.p13_centromere_UCSC-gapTable.txt \
	--includeHOMD False \
	--chrs "c(1:22, \"X\")" \
	--chrTrain "c(1:22)" \
	--estimateNormal True \
	--estimatePloidy True \
	--estimateScPrevalence True \
	--scStates "c(1,3)" \
	--txnE 0.9999 \
	--txnStrength 10000 \
	--outDir $outDir

exit 0