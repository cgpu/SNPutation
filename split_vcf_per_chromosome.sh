#!/bin/sh

for file in *.vcf ; do

# Remove header
grep -v "^#"  "$file" >  "commentless.vcf"; done
# Split merged vcf into per chromosome
awk '{if (last != $1) close(last); print >> $1; last = $1}' ../commentless.vcf

# Add chromosome prefix
for f in * ; do mv -- "$f" "chr$f" ; done

# Add suffix
for f in * ; do mv -- "$f" "$f.vcf" ; done