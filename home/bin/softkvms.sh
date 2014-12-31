# ============================================================
#  Author: 凍仁翔 / chusiang.lai (at) gmail.com
#  Blog: http://note.drx.tw
#  Filename: softkvms.sh
#  Modified: 2014-12-31 21:27
#  Description: softKvm server setting.
#  Reference: 
#   1. 凍仁的筆記: QuickSynergy (softKvm) on Ubuntu
#     - http://note.drx.tw/2010/04/quicksynergy-kvm-on-ubuntu.html
# =========================================================== 

#!/bin/bash

declare DEVICE="eth0"
declare STATUS
declare ADDRESS="172.16.1.100"

# Checking the network.
/sbin/ifconfig $DEVICE | grep $ADDRESS \
  && STATUS=1 || STATUS=0 2>&1 /dev/null

# Enable the synergy server.
if [ $STATUS -eq 1 ]; then
  synergys -f --config ~/.synergy.conf &
fi

unset DEVICE
unset STATUS
unset ADDRESS
