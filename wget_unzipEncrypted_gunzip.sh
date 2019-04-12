# Download results for https://imputationserver.sph.umich.edu/start.html#!jobs/job-20190411-043730-340 job 
# openSNP file: 8589.23andme.6953.txt
# command for wget c+p from Michigan Imputation Server
# password sent via email after job completion

 wget https://imputationserver.sph.umich.edu/share/results/2ac3812f620d7de0c06abe312e0afc5b/chr_1.zip

 wget https://imputationserver.sph.umich.edu/share/results/73a02e24cfbced29a4c7aa81af80cbb/chr_10.zip

 wget https://imputationserver.sph.umich.edu/share/results/964bb41345016f0e84b2f240d3846a0b/chr_11.zip

 wget https://imputationserver.sph.umich.edu/share/results/46ac0988c4f29b62b6a941e1b9b26edd/chr_12.zip

 wget https://imputationserver.sph.umich.edu/share/results/4ff6be1a224a31086a449a642dc776dc/chr_13.zip

 wget https://imputationserver.sph.umich.edu/share/results/9a033365d4d99cc8862e0189271b6813/chr_14.zip

 wget https://imputationserver.sph.umich.edu/share/results/cc115ffaaba7a7b76482b0ef7bffc942/chr_15.zip

 wget https://imputationserver.sph.umich.edu/share/results/7d4a1a31dd10afcaa863324d8a2b3eac/chr_16.zip

 wget https://imputationserver.sph.umich.edu/share/results/8c7263485e86b4177049b8484d7af5ed/chr_17.zip

 wget https://imputationserver.sph.umich.edu/share/results/ff6eff9744ec5be821b0dfc63b3608b3/chr_18.zip

 wget https://imputationserver.sph.umich.edu/share/results/6bca72237c31faf94a8ec556309699ea/chr_19.zip

 wget https://imputationserver.sph.umich.edu/share/results/cadb634572171a5a1530021e7d945763/chr_2.zip

 wget https://imputationserver.sph.umich.edu/share/results/ae8efa7eb22b101bf05a804373c7a66d/chr_20.zip

 wget https://imputationserver.sph.umich.edu/share/results/2ecc34f4253c9a1f51dd1232a7612594/chr_21.zip

 wget https://imputationserver.sph.umich.edu/share/results/5bae2614cc58604abfa16a7a32b1b2b1/chr_22.zip

 wget https://imputationserver.sph.umich.edu/share/results/cbf8137375d86cca07931b1da5dfab0c/chr_3.zip

 wget https://imputationserver.sph.umich.edu/share/results/522280b369f3facb48475ee209a837a2/chr_4.zip

 wget https://imputationserver.sph.umich.edu/share/results/97cf4c2295de188f17795316c6a35b3d/chr_5.zip

 wget https://imputationserver.sph.umich.edu/share/results/600fceff166119a71b220b38d06c61b9/chr_6.zip

 wget https://imputationserver.sph.umich.edu/share/results/dba4ebd91927539cc7928cfe6f3d97f4/chr_7.zip

 wget https://imputationserver.sph.umich.edu/share/results/1be71a0cb1d9a8a95fa0710e87197932/chr_8.zip

 wget https://imputationserver.sph.umich.edu/share/results/c6dcc03702bb3fb65211dab5698f9046/chr_9.zip

	
for file in *.zip ; do 
unzip -j -P @uvVV5KdagS8PF "$file" &&  rm "$file"  ; done

# Do not keep compressed gz files; if desired use --keep flag
for file in *.gz ; do 
gunzip "$file"; done

# Store header in another document
cat chr1.dose.vcf | grep ^# > header.dose.txt

# Delete from all .dose.vcf files the header
for file in *.dose.vcf ; do
sed -i '/^\s*#/ d' "$file" ; done

# Rename header so that it gets the same suffix as .dose.vcf and will get moved to VCF dir
mv header.dose.txt header.dose.vcf

# Start tidying up files in directories
mkdir VCF
for file in *.vcf ; do
mv  "$file" VCF/"${file}" ; done

mkdir INFO
for file in *.info ; do
mv  "$file" INFO/"${file}" ; done

mkdir TBI
for file in *.tbi ; do
mv  "$file" TBI/"${file}" ; done
