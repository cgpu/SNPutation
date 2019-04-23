# Download .csv file with 30 selected openSNP 23andme SNPset files
wget https://s3-eu-west-1.amazonaws.com/deploit-tutorial/openSNP_23andme_txt_n30.csv 

# Create directory only if the first command succeeds
grep -v "^#" openSNP_23andme_txt_n30.csv | cut -d',' -f2 > urlfile.txt  && mkdir 23andme_downloads_dir/

# Sequentially download (wget) files from URL list
wget -i urlfile.txt -P 23andme_downloads_dir/

