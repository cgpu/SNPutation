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


### While being on the `ImputationComparison_n30` directory:

```
# Take filenames of the files

# Take line counts of the files
# Remove leading whiotespaces: https://www.cyberciti.biz/tips/delete-leading-spaces-from-front-of-each-word.html
wc -l 23andme_downloads_dir/* | grep -v total | sed -e 's/^[ \t]*//' | cut -d' ' -f1 > filelines.txt

# Take checksuyms of the files, 1 column
cd 23andme_downloads_dir/ && gsha256sum *.23andme.* | cut -d' ' -f1 > ../filechecksums.txt && cd ..
```
