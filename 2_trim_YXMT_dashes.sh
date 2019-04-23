for file in 23andme_downloads_dir/*.23andme.* ; do 
filename=`basename "$file"`
awk '{ if ($2 != 26 && $2 != 25 && $2 != 24 && $2 != 23 && $2 != "Y" && $2 != "X" && $2 != "MT") print $0 }'  "$file" >  "YXMT_${filename}"; 
done

for file in *YXMT* ; do 
filename=`basename "$file"`
awk '$4 !~ /^--/'  "$file" >  "dashdashless_${filename}"; 
done

# Move newly created once trimmed files (no non-autosomal chromos) to sub-directory 
mkdir YXMTless_23andme_files_dir
mv YXMT_*  YXMTless_23andme_files_dir/

# Move newly created twice trimmed files (no non-autosomal chromos, no -- genotype SNP entries) to sub-directory 
mkdir dashless_YXMTless_23andme_files
mv dashdashless_* dashless_YXMTless_23andme_files
