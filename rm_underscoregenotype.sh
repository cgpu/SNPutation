for file in *.txt ; do 
awk '$4 !~ /^--/'  "$file" >  "dashdashless_${file}"; done

