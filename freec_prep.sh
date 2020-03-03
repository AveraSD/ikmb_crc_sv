
tumor=$1
normal=$2

outfile=/data/storage/ikmb_alex_crc/lc_wgs/$tumor/freec/${tumor}.freec.sh

bash /data/storage/ikmb_alex_crc/lc_wgs/ikmb_crc_sv/freec_createconfig.sh $tumor $normal

echo "module load samtools" >> $outfile
echo "cd /data/storage/anu/repos/FREEC-11.5/src && ./freec -conf /data/storage/ikmb_alex_crc/lc_wgs/"$tumor"/freec/"$tumor".freec.config.txt" >> $outfile



