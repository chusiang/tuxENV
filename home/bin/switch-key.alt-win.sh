#!/bin/bash
# ============================================================
#  Author: 凍仁翔 / chusiang.lai (at) gmail.com
#  Blog: http://note.drx.tw
#  Filename: switch-key.alt-win.sh
#  Modified: 2015-11-28 21:06
#  Description: Switching keyboard layout of Alt and Win key.
#  Reference: 
#
#   - keyboard - Rebind Alt key to win using setxkbmap? | Ask Ubuntu
#    - http://askubuntu.com/questions/29731/rebind-alt-key-to-win-using-setxkbmap
#
# =========================================================== 

/usr/bin/setxkbmap -option "altwin:swap_lalt_lwin"
