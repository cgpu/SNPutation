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
