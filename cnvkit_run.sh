# cnvkit refFlat - gene annotation database required for the wgs mode
#wget http://hgdownload.cse.ucsc.edu/goldenpath/hg19/database/refFlat.txt.gz
#zcat refFlat.txt.gz | sed -e 's|chr||g' > b37.refflat.txt

# run cnvkit on all available tumor samples

while read tumor normal
do
echo $tumor
/opt/software/miniconda2/bin/cnvkit.py batch -p 0 /data/storage/ikmb_alex_crc/lc_wgs/$tumor/alignment/${tumor}_realigned_sorted.bam -r /data/storage/ikmb_alex_crc/lc_wgs/cnvkit_pooledref/pooledref.cnn -m wgs --output-dir /data/storage/ikmb_alex_crc/lc_wgs/$tumor/cnv --scatter 
done < /data/storage/ikmb_alex_crc/lc_wgs/tumors_wgs.txt
