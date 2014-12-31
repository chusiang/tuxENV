# ============================================================
#  Author: 凍仁翔 / chusiang.lai (at) gmail.com
#  Blog: http://note.drx.tw
#  Filename: md5-make.sh
#  Modified: 2014-12-31 20:59
#  Description: make md5sum fils with list.txt.
#  Reference: 
#   1. 
# =========================================================== 

#!/bin/bash

for X in $(cat list.txt); do

	# 依序使用 md5sum 檢查當前目錄下所有檔案，並將其儲存其結果。
	echo "md5sum $X > $X.sum " | bash

done

# 移除所有的 .sum。 
#echo "\rm *.sum" | bash
