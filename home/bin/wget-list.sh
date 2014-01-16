#!/bin/bash
# Filename: wget-list.sh
# Info:		wget files with list.txt.

for X in $(cat list.txt); do
	wget $X
done

# - 2013/09/27
# wget support download something with file, please use the '-i' option.
# 
# $ wget -i list.txt
#
