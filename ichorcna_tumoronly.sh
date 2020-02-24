#!/bin/bash

tumorBAM=$1 #~/AWS/storage/ikmb_alex_crc/lc_wgs/G17606/alignment/G17606_realigned_sorted.bam
tumorWIG=$2 #~/AWS/storage/ikmb_alex_crc/lc_wgs/G17606/alignment/G17606_realigned_sorted.wig
windowSize=$3

ID=$(basename $tumorBAM | cut -d _ -f 1)

HMMreadCounter=~/bin/hmmcopy_utils/bin/readCounter
IchorCNA=~/bin/ichorCNA/scripts/runIchorCNA.R
IchorDATA=~/bin/ichorCNA/inst/extdata

outDir=~/AWS/storage/ikmb_alex_crc/lc_wgs/$ID/IchorCNA_$windowSize

if [ -d $outDir ]; then
  rm -r $outDir
fi

mkdir -p $outDir

## generate read count data
$HMMreadCounter \
	--window $((1000*windowSize)) \
	--quality 20 \
	--chromosome "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,X,Y" \
	$tumorBAM > $tumorWIG


Rscript $IchorCNA --id $ID \
	--WIG $tumorWIG \
	--normalPanel /home/tobias/AWS/storage/ikmb_alex_crc/lc_wgs/${windowSize}kb.pon_median.rds \
	--ploidy "c(2,3)" \
	--normal "c(0.5,0.6,0.7,0.8,0.9)" \
	--gcWig $IchorDATA/gc_hg19_${windowSize}kb.wig \
	--mapWig $IchorDATA/map_hg19_${windowSize}kb.wig \
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
	--plotYLim="c(-3,3)" \
	--outDir $outDir

exit 0

