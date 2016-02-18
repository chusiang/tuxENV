#!/bin/bash
# ============================================================
#  Author: 凍仁翔 / chusiang.lai (at) gmail.com
#  Blog: http://note.drx.tw
#  Filename: date.1h-ago.sh
#  Modified: 2016-01-08 11:43
#  Description: computer 8 hours ago with date.
#  Reference: 
#
#   * Linux 使用 date 計算時間(昨天、明天) - Tsung's Blog
#    - https://blog.longwin.com.tw/2010/07/linux-date-computer-2010/
#
# =========================================================== 

date --date='8 hours ago' "+%Y-%m-%d %H:%M:%S"

