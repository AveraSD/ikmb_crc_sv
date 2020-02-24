#!/bin/bash

## create panel of normals

windowSize=10

HMMreadCounter=~/bin/hmmcopy_utils/bin/readCounter
IchorCNA=~/bin/ichorCNA/scripts
IchorDATA=~/bin/ichorCNA/inst/extdata

while read p; do
  ID=($p)
  normalBAM=/home/tobias/AWS/storage/ikmb_alex_crc/lc_wgs/${ID[0]}/alignment/${ID[1]}_realigned_sorted.bam
  normalWIG=$(echo $normalBAM | sed s/bam/${windowSize}kb.wig/)

  ## generate read count data
  $HMMreadCounter \
	--window $((1000*windowSize)) \
	--quality 20 \
	--chromosome "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,X,Y" \
	$normalBAM > $normalWIG

done </home/tobias/AWS/storage/ikmb_alex_crc/lc_wgs/samples.txt

while read p; do
  ID=($p)
  normalBAM=/home/tobias/AWS/storage/ikmb_alex_crc/lc_wgs/${ID[0]}/alignment/${ID[1]}_realigned_sorted.bam
  normalWIG=$(echo $normalBAM | sed s/bam/${windowSize}kb.wig/)
  echo $normalWIG
done </home/tobias/AWS/storage/ikmb_alex_crc/lc_wgs/samples.txt > /home/tobias/AWS/storage/ikmb_alex_crc/lc_wgs/${windowSize}kb.files.txt

Rscript $IchorCNA/createPanelOfNormals.R \
    --filelist /home/tobias/AWS/storage/ikmb_alex_crc/lc_wgs/${windowSize}kb.files.txt \
    --gcWig $IchorDATA/gc_hg19_${windowSize}kb.wig \
    --mapWig $IchorDATA/map_hg19_${windowSize}kb.wig \
    --centromere $IchorDATA/GRCh37.p13_centromere_UCSC-gapTable.txt \
    --outfile /home/tobias/AWS/storage/ikmb_alex_crc/lc_wgs/${windowSize}kb.pon

exit 0

 