# SNPutation
SNP imputation utils


## Other useful commands

### Split field with delimiter replacement trick
Solution from SO: https://unix.stackexchange.com/questions/308583/is-there-a-command-acan-do-the-reverse-of-what-the-paste-command-does

![](https://i.imgur.com/9xJgjMo.png)

```
# Fast Imputation output file contains a field with merged metadata, seperated by ;
cat dashdashless_YXMTless_8589.23andme.6953.vcf  | tr ";" "\t" > new.vcf
```


### Split merged vcf to per chromosome
After removing the header:

```
for file in *.vcf ; do

# Remove header
grep -v "^#"  "$file" >  "commentless.vcf"; done
```


```
# Split merged vcf into per chromosome
awk '{if (last != $1) close(last); print >> $1; last = $1}' ../commentless.vcf

# Add chromosome prefix
for f in * ; do mv -- "$f" "chr$f" ; done

# Add suffix
for f in * ; do mv -- "$f" "$f.vcf" ; done
```



### Merge output of Fast imputation to create 1:23456 format (Michigan Imputation Server Style)

```
# take the columns 1 and 2 and substitute g - globally the \t - tab with : - colon
cut -f1,2 merged.vcf | sed 's/\t/:/g'
```

### Count all lines that do not contain

```
grep -vc "Imputed" chr1.info
```
### Retrieve one column with the lines per file in current directory 

-- count lines for all files in current directory: `wc -l *`
-- exclude summary line: `grep -v total`
-- remove leading whitespaces: `sed -e 's/^[ \t]*//' `
-- grab the first column by denoting delim is whitespace: `cut -d' ' -f1`
 (this wouldn't working if leading whitespaces existed since the delimitter is also whitespace for line count and file)

```
wc -l * | grep -v total | sed -e 's/^[ \t]*//' | cut -d' ' -f1
```


### While being on the `ImputationComparison_n30` directory (project parent directory):

To retrieve info for the downloaded input files about:

-- openSNP filename which can be transformed to wgettable URL
eg  `http_PREFIX` + `filename` AKA `https://opensnp.org/data/` + `8589.23andme.6953`

-- number of file lines after download
This will be the sum of header (commnted out with #) and SNP entries (1 SNP is 1 row of the file)

-- the sha256checksum of each downloaded file
For input data integrity verification (reproducibility)

```
# Take filenames of the files
cd 23andme_downloads_dir/ && \
wc -l * | grep -v total | sed -e 's/^[ \t]*//' | cut -d' ' -f2 > ../filenames.txt && \
cd ..

# Take line counts of the files
# Remove leading whitespaces: https://www.cyberciti.biz/tips/delete-leading-spaces-from-front-of-each-word.html
wc -l 23andme_downloads_dir/* | grep -v total | sed -e 's/^[ \t]*//' | cut -d' ' -f1 > filelines.txt

# Take checksums of the files, 1 column
cd 23andme_downloads_dir/ &&  \
gsha256sum *.23andme.* | cut -d' ' -f1 > ../filechecksums.txt && \
cd ..

# Paste columns into one to have info for the downloaded files
paste -d ",," filenames.txt filelines.txt filechecksums.txt > info_23andme_downloads.csv && \
rm filenames.txt filelines.txt filechecksums.txt

# Add header with cat
echo "openSNP_filename,number_of_lines_with_comments,file_checksum" > header.csv
cat header.csv info_23andme_downloads.csv > info_23andme_downloads_header.csv
rm header.csv info_23andme_downloads.csv
```

### Count lines that start with `#` 
 
```
for file in Dropbox/ImputationComparison_n30/23andme_downloads_dir/*.23andme.* ; 
do grep "^#" $file | wc -l  > commented_out_lines_file.txt; 
done
```
  
Or 


### Count new lines and print filename in same line

```
for file in 23andme_downloads_dir/*.23andme.* ; do grep "^#" $file | wc -l | tr "\n" "\t" && echo `basename $file` ; done

```
 
 ## How To: Count number of files in each sub-directory
 
```
# https://stackoverflow.com/questions/15216370/how-to-count-number-of-files-in-each-directory#
 du -a | cut -d/ -f2 | sort | uniq -c | sort -nr
```

### Do ls -l and grab the last column by defining [SPACE] as delim
-- `grep -v total`: do not include the summary `ls -l` line 
-- `grep -o '[^ ]*$'`: grab the last column with [SPACE] as delim
`# https://stackoverflow.com/questions/22727107/how-to-find-the-last-field-using-cut`

```
ls -l dashless_YXMTless_23andme_files/ | grep -v total| grep -o '[^ ]*$' > dashless.txt
```
