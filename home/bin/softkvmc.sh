# ============================================================
#  Author: 凍仁翔 / chusiang.lai (at) gmail.com
#  Blog: http://note.drx.tw
#  Filename: softkvmc.sh
#  Modified: 2014-12-31 21:28
#  Description: softKvm client setting.
#  Reference: 
#   1. 凍仁的筆記: QuickSynergy (softKvm) on Ubuntu
#     - http://note.drx.tw/2010/04/quicksynergy-kvm-on-ubuntu.html
# =========================================================== 

#!/bin/bash

declare ADDRESS="172.16.1.100"
declare PORT="24800"

# Connect with the synergy client.
synergyc $ADDRESS:$PORT

unset ADDRESS
unset PORT
