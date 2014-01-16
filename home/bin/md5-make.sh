#!/bin/bash
# Filename: md5-make.sh
# Info:		make md5sum fils with list.txt

for X in $(cat list.txt); do

	# 依序使用 md5sum 檢查當前目錄下所有檔案，並將其儲存其結果。
	echo "md5sum $X > $X.sum " | bash

done

# 移除所有的 .sum。 
#echo "\rm *.sum" | bash
