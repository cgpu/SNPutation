for file in YXMTless_23andme_files_dir/*.23andme.* ; do cat $file | wc -l | tr "\n" "\t" && echo `basename $file` > counts_post_YXMT_trim.txt; done

for file in dashless_YXMTless_23andme_files/*.23andme.* ; do cat $file | wc -l | tr "\n" "\t" && echo `basename $file` > counts_post_YXMT_dash_trims.txt; done
