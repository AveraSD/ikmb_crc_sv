tumor=$1
normal=$2

mkdir -p /data/storage/ikmb_alex_crc/lc_wgs/$tumor/freec

outfile=/data/storage/ikmb_alex_crc/lc_wgs/$tumor/freec/${tumor}.freec.config.txt

echo "[general]" >> $outfile
echo -e "\n" >> $outfile
echo "chrLenFile =/data/database/Homo_sapiens/b37decoy/hs37d5.fa.fai" >> $outfile
echo "ploidy = 2" >> $outfile
echo "breakPointThreshold = .8" >> $outfile
echo "window = 10000" >> $outfile
echo "numberOfProcesses = 32" >> $outfile
echo "outputDir = /data/storage/ikmb_alex_crc/lc_wgs/"$tumor"/freec" >> $outfile

echo -e "\n" >> $outfile
echo "[sample]" >> $outfile
echo -e "\n" >> $outfile
echo "mateFile = /data/storage/ikmb_alex_crc/lc_wgs/"$tumor"/alignment/"$tumor"_realigned_sorted.bam" >> $outfile
echo "inputFormat = BAM" >> $outfile
echo "mateOrientation = FR" >> $outfile

echo -e "\n" >> $outfile
echo "[control]" >> $outfile
echo -e "\n" >> $outfile
echo "mateFile = /data/storage/ikmb_alex_crc/lc_wgs/"$tumor"/alignment/"$normal"_realigned_sorted.bam" >> $outfile
echo "inputFormat = BAM" >> $outfile
echo "mateOrientation = FR" >> $outfile

echo -e "\n" >> $outfile
echo "[BAF]" >> $outfile
echo -e "\n" >> $outfile

echo -e "\n" >> $outfile
echo "[target]" >> $outfile
echo -e "\n" >> $outfile
