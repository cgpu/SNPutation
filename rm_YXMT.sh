for file in *.txt ; do 
awk '{ if ($2 != 26 && $2 != 25 && $2 != 24 && $2 != 23 && $2 != "Y" && $2 != "X" && $2 != "MT") print $0 }'  "$file" >  "YXMT_${file}"; done

