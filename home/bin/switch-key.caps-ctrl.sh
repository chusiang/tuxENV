#!/bin/bash
# ============================================================
#  Author: 凍仁翔 / chusiang.lai (at) gmail.com
#  Blog: http://note.drx.tw
#  Filename: switch-key.caps-ctrl.sh
#  Modified: 2015-11-28 21:06
#  Description: Switching keyboard layout of Caps Lock and Control key.
#  Reference: 
#
#   - 凍仁的筆記: 對調 Ctrl, Caps Lock 鍵位
#    - http://note.drx.tw/2013/03/ctrl-caps-lock.html
#
# =========================================================== 

/usr/bin/setxkbmap -option "ctrl:swapcaps"

