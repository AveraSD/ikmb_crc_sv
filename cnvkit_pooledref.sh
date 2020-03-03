#!/bin/bash

# create target and antitarget bed files
/opt/software/miniconda2/bin/cnvkit.py target /data/storage/ikmb_alex_crc/lc_wgs_old/hs37d5.bed -o /data/storage/ikmb_alex_crc/lc_wgs/cnvkit_pooledref/hs37d5.cnvkit.targets.bed
/opt/software/miniconda2/bin/cnvkit.py antitarget /data/storage/ikmb_alex_crc/lc_wgs_old/hs37d5.bed -o /data/storage/ikmb_alex_crc/lc_wgs/cnvkit_pooledref/hs37d5.cnvkit.antitargets.bed

# coverage command to create target and antitarget cnn files
while read tumor normal
do
/opt/software/miniconda2/bin/cnvkit.py coverage /data/storage/ikmb_alex_crc/lc_wgs/${tumor}/alignment/${normal}_realigned_sorted.bam /data/storage/ikmb_alex_crc/lc_wgs/cnvkit_pooledref/hs37d5.cnvkit.targets.bed -o /data/storage/ikmb_alex_crc/lc_wgs/cnvkit_pooledref/${normal}.targetcoverage.cnn -p 32
/opt/software/miniconda2/bin/cnvkit.py coverage /data/storage/ikmb_alex_crc/lc_wgs/${tumor}/alignment/${normal}_realigned_sorted.bam /data/storage/ikmb_alex_crc/lc_wgs/cnvkit_pooledref/hs37d5.cnvkit.antitargets.bed -o /data/storage/ikmb_alex_crc/lc_wgs/cnvkit_pooledref/${normal}.antitargetcoverage.cnn -p 32
done < /data/storage/ikmb_alex_crc/lc_wgs/samples_tn_all54.txt
#done < /data/storage/ikmb_alex_crc/lc_wgs/nml_only_G_samples.txt

# reference command to create the pooled reference
/opt/software/miniconda2/bin/cnvkit.py reference /data/storage/ikmb_alex_crc/lc_wgs/cnvkit_pooledref/*coverage.cnn  -f /data/database/Homo_sapiens/b37decoy/hs37d5.fa -o /data/storage/ikmb_alex_crc/lc_wgs/cnvkit_pooledref/pooledref.cnn

