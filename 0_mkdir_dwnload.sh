grep -v "^#" openSNP_23andme_txt_n30.csv | cut -d',' -f2 > urlfile.txt

mkdir 23andme_downloads_dir/

wget -i urlfile.txt -P 23andme_downloads_dir/

