#!/bin/bash

while read tumor normal
do
echo $tumor, $normal
bash /home/anu/panceqdocker/preprocess.sh $tumor $normal /data/s3/averaikmb/alex_crc_low-coverage-wgs/merged /data/storage/ikmb_alex_crc/lc_wgs/${tumor}
cd /data/storage/ikmb_alex_crc/lc_wgs/${tumor} && qsub -cwd -pe local 32 -l h_vmem=58G ${tumor}.panceq.sh
done < /data/storage/ikmb_alex_crc/lc_wgs/samples_tn_wgs.txt


