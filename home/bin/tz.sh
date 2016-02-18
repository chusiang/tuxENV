#!/bin/sh
# ============================================================
#  Author: 凍仁翔 / chusiang.lai (at) gmail.com
#  Blog: http://note.drx.tw
#  Filename: tz.sh
#  Modified: 2016-01-08 11:56
#  Description: echo time of multi-timezome.
#  Reference: 
#
#   * Linux 上之多時區時間顯示 | Rex's blah blah blah
#    - http://blog.nutsfactory.net/2007/06/19/multi-time-zone-clock-on-linux/
#
# =========================================================== 

for tz in 'Asia/Taipei' 'America/Chicago' 'GMT'; do
  echo $tz
  TZ=$tz date -R
  echo
done
