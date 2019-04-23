# Take filenames of the files
cd 23andme_downloads_dir/ && \
wc -l * | grep -v total | sed -e 's/^[ \t]*//' | cut -d' ' -f2 > ../filenames.txt && \
cd ..

# Take line counts of the files as downloaded, no trimming of SNP entries
# Remove leading whitespaces: https://www.cyberciti.biz/tips/delete-leading-spaces-from-front-of-each-word.html
wc -l 23andme_downloads_dir/* | grep -v total | sed -e 's/^[ \t]*//' | cut -d' ' -f1 > filelines.txt

# Take line counts that start with '#' - Expected header from 23andme is 20 lines
for file in 23andme_downloads_dir/*.23andme.* ; do grep "^#" $file | wc -l >> commented_out_lines.txt; done

# Take line counts that DO NOT start with '#' - Expected header from 23andme is 20 lines
for file in 23andme_downloads_dir/*.23andme.* ; do grep -v "^#" $file | wc -l >> not_commented_out_lines.txt; done

# Take line counts of non-autosomal chromos SNPs, aka contain in the second column $2 either X,Y,MT,25,26
for file in 23andme_downloads_dir/*.23andme.* ; do 
awk '{ if ($2 == 26 || $2 == 25 || $2 == 24 || $2 == 23 || $2 == "Y" || $2 == "X" || $2 == "MT") print $0 }' $file | wc -l >> non_autosomal_lines.txt; 
done

# Take line counts of dash dash genotype SNPs, aka $4 column 4 is "--" chromos SNPs
for file in 23andme_downloads_dir/*.23andme.* ; do
awk '$4 ~ /^--/' $file | wc -l >> dashdash_genotype_lines.txt;
done

# Take line counts of != NOT dash dash genotype SNPs NOT non-autosomal chromos
for file in 23andme_downloads_dir/*.23andme.* ; do
awk '$4 !~ /^--/' $file | awk '{ if ($2 != 26 && $2 != 25 && $2 != 24 && $2 != 23 && $2 != "Y" && $2 != "X" && $2 != "MT") print $0 }' | wc -l >> twice_trimmed_files_lines.txt;
done

# Take line counts of entries, aka SNPs being BOTH: dash dash genotype SNPs AND non-autosomal chromos
for file in 23andme_downloads_dir/*.23andme.* ; do
awk '$4 ~ /^--/' $file | awk '{ if ($2 == 26 || $2 == 25 || $2 == 24 || $2 == 23 || $2 == "Y" || $2 == "X" || $2 == "MT") print $0 }' $file | wc -l >> intersect_YXMT_dashdash_lines.txt;
done

# Take line counts of entries, aka SNPs that are either OR: dash dash genotype SNPs OR one of the non-autosomal non-autosomal chromos
for file in 23andme_downloads_dir/*.23andme.* ; do
awk '{ if ($4 ~ /^--/ || $2 == 26 || $2 == 25 || $2 == 24 || $2 == 23 || $2 == "Y" || $2 == "X" || $2 == "MT" ) print $0 }' $file| wc -l >> union_YXMT_dashdash_lines.txt;
done

# Take checksums of the files, 1 column
cd 23andme_downloads_dir/ &&  \
gsha256sum *.23andme.* | cut -d' ' -f1 > ../filechecksums.txt && \
cd ..

# Paste columns into one to have info for the downloaded files
paste -d ",,,,,,,"  filenames.txt filechecksums.txt filelines.txt commented_out_lines.txt  not_commented_out_lines.txt dashdash_genotype_lines.txt non_autosomal_lines.txt intersect_YXMT_dashdash_lines.txt  twice_trimmed_files_lines.txt > info_23andme_downloads.csv 
rm filenames.txt filelines.txt filechecksums.txt commented_out_lines.txt not_commented_out_lines.txt dashdash_genotype_lines.txt non_autosomal_lines.txt twice_trimmed_files_lines.txt intersect_YXMT_dashdash_lines.txt

# Add header with cat 
echo "openSNP_filename,file_checksum_all_lines,all_lines,lines_of_comments,lines_without_comments, dashdash_genotype_lines,non_autosomal_lines,intersect_YXMT_dashdash_lines,twice_trimmed_files_lines" > header.csv
cat header.csv info_23andme_downloads.csv > info_23andme_downloads_header.csv
rm header.csv info_23andme_downloads.csv 


