# Save in new trimmed files the 23andme files from openSNP:
# Filtering applied:
# -- REMOVE dash dash genotype SNPs 
# -- REMOVE non-autosomal chromos
for file in 23andme_downloads_dir/*.23andme.* ; do
filename=`basename "$file"`
awk '$4 !~ /^--/' "$file" | awk '{ if ($2 != 26 && $2 != 25 && $2 != 24 && $2 != 23 && $2 != "Y" && $2 != "X" && $2 != "MT") print $0 }' >  "dashdashless_YXMTless_${filename}" ;
done

# Move newly generated twice trimmed files (no non-autosomal chromos, no -- genotype SNP entries) to sub-directory 
mkdir dashless_YXMTless_23andme_files
mv dashdashless_* dashless_YXMTless_23andme_files
