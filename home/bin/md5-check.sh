#!/bin/bash
# Filename: md5-check.sh
# Info:		use md5sum check fils with list.txt

for X in $(cat list.txt); do

	# 依序檢查當前目錄下所有的 .sum。
	echo "md5sum -c $X.sum" | bash

	# 使用背景執行 (&) 是個很好的加速方法，但當檔案過大或過多時會導致系統過於忙碌而無法進行其它作業。
	#echo "md5sum -c $X.sum" | bash &

done

# 移除所有的 .sum。 
# echo "rm -rf *.sum" | bash
