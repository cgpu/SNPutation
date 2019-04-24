#!/bin/bash

# DESCRIPTION:
# Script for retrieving information about 23andme files retrieved from https://opensnp.org/genotypes

# INPUT & REQUIRED FILENAMES AND DIRECTORY STRUCTURE:
# To run the script you must have the following (required)
# - a subdirectory of your current working directory named "23andme_downloads_dir"
# - inside the subdirectory, 23andme files retrieved from  https://opensnp.org/genotypes
# - the 23andme filenames must contain this pattern: ".23andme."; Indicative filename: 8596.23andme.6958	
# The curated .csv file with the openSNP URLs can be found here: https://s3-eu-west-1.amazonaws.com/deploit-tutorial/openSNP_23andme_txt_n30.csv

# OUTPUT 
# A .csv file with the following columns; header == TRUE
# openSNP_filenames
# checksums
# all_lines
# commented_out_lines
# not_commented_out_lines
# non_autosomal_SNPs
# dashdash_genotype_SNPs
# non_dashdash_only_autosomal_SNPs
# intersect_YXMT_dashdash_SNP
# union_YXMT_dashdash_SNPs
# internal_23andme_specific_SNPs
# intersect_YXMT_dashdash_internal_SNPs
# thrice_trimmed_SNPs__autosomal_only_no_dash_no_internal_ID

# You can import the output .csv in Rstudio by using the following command:
#library(readr)
#info_23andme_downloads_header <- read_csv("Dropbox/ImputationComparison_n30/info_23andme_downloads_header.csv", 
#    col_types = cols(  all_lines                                                  = col_integer(), 
#                       commented_out_lines                                        = col_integer(), 
#                       dashdash_genotype_SNPs                                     = col_integer(), 
#                       internal_23andme_specific_SNPs                             = col_integer(), 
#                       intersect_YXMT_dashdash_SNPs                               = col_integer(), 
#                       intersect_YXMT_dashdash_internal_SNPs                      = col_integer(), 
#                       non_autosomal_SNPs                                         = col_integer(), 
#                       non_dashdash_only_autosomal_SNPs                           = col_integer(), 
#                       not_commented_out_lines                                    = col_integer(), 
#                       thrice_trimmed_SNPs__autosomal_only_no_dash_no_internal_ID = col_integer(), 
#                       union_YXMT_dashdash_SNPs                                   = col_integer()))







# COLUMN 1
# Take filenames of the files; cd and `wc -l *` is prefered from `wc -l 23andme_downloads-dir/*`
# bc I haven't found an elegant alt solution for using sth similar to`basename` with pipe output or multi files w/o looping
cd 23andme_downloads_dir/ && \
wc -l * | grep -v total | sed -e 's/^[ \t]*//' | cut -d' ' -f2 > ../openSNP_filenames.txt && \
cd ..

# COLUMN 2
# Take checksums of the raw input 23andme files; before any filtering out is performed
cd 23andme_downloads_dir/ &&  \
gsha256sum *.23andme.* | cut -d' ' -f1 > ../checksums.txt && \
cd ..

# COLUMN 3
# Take line counts of the files as downloaded from openSNP; do not count the 'total' line outputed by wc -l
# Remove leading whitespaces with `sed -e` command found here:  https://www.cyberciti.biz/tips/delete-leading-spaces-from-front-of-each-word.html
wc -l 23andme_downloads_dir/* | grep -v total | sed -e 's/^[ \t]*//' | cut -d' ' -f1 > all_lines.txt

# COLUMN 4
# Take line counts that start with '#' - Expected header from 23andme is 20 lines
for file in 23andme_downloads_dir/*.23andme.* ; do grep "^#" $file | wc -l >> commented_out_lines.txt; done

# COLUMN 5
# Take line counts that DO NOT start with '#', essentially only the SNPs - SNPset size varies, approx 600,000 SNPs for this curated list
for file in 23andme_downloads_dir/*.23andme.* ; do grep -v "^#" $file | wc -l >> not_commented_out_lines.txt; done

# COLUMN 6
# Take line counts of SNPs that reside on non-autosomal chromos; aka the second column, $2 , IS EITHER OR equal to "X","Y","M"T, "22", "23", "24","25","26"
# grep -v "^#" to omit header of the file
for file in 23andme_downloads_dir/*.23andme.* ; do 
awk '{ if ($2 == 26 || $2 == 25 || $2 == 24 || $2 == 23 || $2 == "Y" || $2 == "X" || $2 == "MT") print $0 }' $file | grep -v "^#" | wc -l >> non_autosomal_SNPs.txt; 
done

# COLUMN 7
# Take line counts of '--' dash dash genotype SNPs, aka $4 column 4 is "--" chromos SNPs
# grep -v "^#" to omit header of the file; redundant but safe
for file in 23andme_downloads_dir/*.23andme.* ; do
awk '$4 ~ /^--/' $file | grep -v "^#" | wc -l >> dashdash_genotype_SNPs.txt;
done

# COLUMN 8
# Take line counts of != NOT dash dash genotype SNPs NOT non-autosomal chromos
# grep -v "^#" to omit header of the file; needed
for file in 23andme_downloads_dir/*.23andme.* ; do
awk '$4 !~ /^--/' $file | grep -v "^#" | awk '{ if ($2 != 26 && $2 != 25 && $2 != 24 && $2 != 23 && $2 != "Y" && $2 != "X" && $2 != "MT") print $0 }' | wc -l >> non_dashdash_only_autosomal_SNPs.txt;
done

# COLUMN 9
# Take line counts of: dash dash genotype SNPs AND non-autosomal chromos SNPs combined
# grep -v "^#" to omit header of the file; needed
for file in 23andme_downloads_dir/*.23andme.* ; do
awk '$4 ~ /^--/' $file | awk '{ if ($2 == 26 || $2 == 25 || $2 == 24 || $2 == 23 || $2 == "Y" || $2 == "X" || $2 == "MT") print $0 }' | grep -v "^#" | wc -l >> intersect_YXMT_dashdash_SNPs.txt;
done

# COLUMN 10
# Take line counts of SNPs, aka SNPs that are either OR: dash dash genotype SNPs OR one of the non-autosomal chromos
# grep -v "^#" to omit header of the file; needed
for file in 23andme_downloads_dir/*.23andme.* ; do
awk '{ if ($4 ~ /^--/ || $2 == 26 || $2 == 25 || $2 == 24 || $2 == 23 || $2 == "Y" || $2 == "X" || $2 == "MT" ) print $0 }' $file| wc -l >> union_YXMT_dashdash_SNPs.txt;
done

# COLUMN 11
# Take line counts of 23andme specific SNPs; denoted as "internal", they have ixxxxxx ID instead of rsID
# 23andme internal SNPs probably won't have literature references so they are not so useful for associating with Phenotypes
# more info here: https://customercare.23andme.com/hc/en-us/articles/115004459928-Raw-Data-Technical-Details#genotype
# grep -v "^#" to omit header of the file; needed
for file in 23andme_downloads_dir/*.23andme.* ; do 
awk '$1 ~ /^i/' $file | wc -l >> internal_23andme_specific_SNPs.txt; 
done

# COLUMN 12
# Take line counts of entries, aka SNPs being ALL THREE: internal SNP (no rsID) AND dash dash genotype SNPs AND non-autosomal chromos
# grep -v "^#" to omit header of the file; redendant but safe
for file in 23andme_downloads_dir/*.23andme.* ; do
awk '$4 ~ /^--/' $file | awk '$1 ~ /^i/' | awk '{ if ($2 == 26 || $2 == 25 || $2 == 24 || $2 == 23 || $2 == "Y" || $2 == "X" || $2 == "MT") print $0 }' | grep -v "^#" | wc -l >> intersect_YXMT_dashdash_internal_SNPs.txt;
done

# COLUMN 13
# Take line counts of thrice filtered out SNPs; 
# --NO 23andme internal SNPs probably won't have literature references so they are not so useful for associating with Phenotypes
# --NO SNPs with genotype=='--'
# --NO SNPs that reside in non-autosomal chromosomes (aka Mitochondrial and Sex chromosomes excluded)
# more info here: https://customercare.23andme.com/hc/en-us/articles/115004459928-Raw-Data-Technical-Details#genotype
for file in 23andme_downloads_dir/*.23andme.* ; do 
awk '$4 !~ /^--/' $file | awk '{ if ($2 != 26 && $2 != 25 && $2 != 24 && $2 != 23 && $2 != "Y" && $2 != "X" && $2 != "MT") print $0 }' | awk '$1 !~ /^i/' | wc -l >> thrice_trimmed_SNPs__autosomal_only_no_dash_no_internal_ID.txt; 
done

# Paste columns into one to have info for the downloaded files
# set delimiter with paste -d '' ; for n columns, add (n-1) delimiters, here 13 columns, 12 commas
paste -d ',,,,,,,,,,,,'  openSNP_filenames.txt  checksums.txt all_lines.txt commented_out_lines.txt not_commented_out_lines.txt non_autosomal_SNPs.txt dashdash_genotype_SNPs.txt non_dashdash_only_autosomal_SNPs.txt intersect_YXMT_dashdash_SNPs.txt union_YXMT_dashdash_SNPs.txt internal_23andme_specific_SNPs.txt intersect_YXMT_dashdash_internal_SNPs.txt thrice_trimmed_SNPs__autosomal_only_no_dash_no_internal_ID.txt > info_23andme_downloads.csv 
rm                       openSNP_filenames.txt  checksums.txt all_lines.txt commented_out_lines.txt not_commented_out_lines.txt non_autosomal_SNPs.txt dashdash_genotype_SNPs.txt non_dashdash_only_autosomal_SNPs.txt intersect_YXMT_dashdash_SNPs.txt union_YXMT_dashdash_SNPs.txt internal_23andme_specific_SNPs.txt intersect_YXMT_dashdash_internal_SNPs.txt thrice_trimmed_SNPs__autosomal_only_no_dash_no_internal_ID.txt 

# Create Header & Add header with `cat` 
echo "openSNP_filenames,checksums,all_lines,commented_out_lines,not_commented_out_lines,non_autosomal_SNPs,dashdash_genotype_SNPs,non_dashdash_only_autosomal_SNPs,intersect_YXMT_dashdash_SNPs,union_YXMT_dashdash_SNPs,internal_23andme_specific_SNPs,intersect_YXMT_dashdash_internal_SNPs,thrice_trimmed_SNPs__autosomal_only_no_dash_no_internal_ID" > header.csv
cat header.csv info_23andme_downloads.csv > info_23andme_downloads_header.csv
rm header.csv info_23andme_downloads.csv 




