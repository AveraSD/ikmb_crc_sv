#!/bin/bash

while read s
do
echo $s
cat /data/s3/averaikmb/alex_crc_low-coverage-wgs/${s}*R1*gz > /data/s3/averaikmb/alex_crc_low-coverage-wgs/merged/${s}_1.fastq.gz
cat /data/s3/averaikmb/alex_crc_low-coverage-wgs/${s}*R2*gz > /data/s3/averaikmb/alex_crc_low-coverage-wgs/merged/${s}_2.fastq.gz
done < samples_round2.txt
