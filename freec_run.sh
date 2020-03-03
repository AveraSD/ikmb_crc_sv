#!/bin/bash

# create freec scripts for each sample
#while read tumor normal
#do
#echo $tumor,$normal && bash /data/storage/ikmb_alex_crc/lc_wgs/ikmb_crc_sv/freec_prep.sh $tumor $normal
#done < /data/storage/ikmb_alex_crc/lc_wgs/samples_tn_wgs.txt

# submit jobs for each sample
while read tumor normal
do
cd /data/storage/ikmb_alex_crc/lc_wgs/$tumor/freec && qsub  -cwd -pe local 32 -l h_vmem=58G -l hostname=node002 ${tumor}.freec.sh
done < /data/storage/ikmb_alex_crc/lc_wgs/samples_tn_wgs.txt
