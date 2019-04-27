# pwd > /Users/admin/Dropbox/23andme_Thu/FastImputaion_8589_6953_23andme/PER_CHROM 

for file in *.vcf; do 
cat  "$file" |  grep IMP | tr ";" "\t" > "${file}.imputed"

