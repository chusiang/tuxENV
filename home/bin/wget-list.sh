# ============================================================
#  Author: 凍仁翔 / chusiang.lai (at) gmail.com
#  Blog: http://note.drx.tw
#  Filename: wget-list.sh
#  Modified: 2014-12-31 21:36
#  Description: wget files with list.txt.
#  Reference: 
#   1. 
# =========================================================== 

#!/bin/bash

#for X in $(cat list.txt); do
#	wget $X
#done

#
# - 2013/09/27
# The wget support download something with '-i' option to insert file.
# 
wget -i list.txt
#
