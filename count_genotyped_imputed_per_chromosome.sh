# -f8, column 8 contains info for the SNP, genotyped/imputed are the possible metadata categories
for file in *.info ; 
do
echo "$file"   > "${file}.counted"
cut -f8 "$file" | sort | uniq -c >> "${file}.counted" 
done

mkdir IMPU_COUNTED
for file in *.counted ; 
do
mv  "$file" ../IMPU_COUNTED/"${file}" 
done
