# ============================================================
#  Author: 凍仁翔 / chusiang.lai (at) gmail.com
#  Blog: http://note.drx.tw
#  Filename: toggleBluetooth.sh
#  Modified: 2014-12-31 20:39
#  Description: switch Bluetooth status.
#  Reference: 
# =========================================================== 

#!/bin/bash

# 若未開啟藍牙硬體開關，則顯示未 Hard has been disabled.
if [ $( sudo rfkill list | head -n 3 | tail -n 1 | awk '{ print $3 }' ) = yes ]; then
	STATUS="'Bluetooth Information' 'Hard has been disabled'";
	echo "notify-send -t '2000' -i 'application-exit1' $STATUS" | bash
else
	# 關閉藍牙
	if [ $( sudo rfkill list | head -n 2 | tail -n 1 | awk '{ print $3 }' ) = no ]; then
		STATUS="'Bluetooth Information' 'Soft has been disabled'";
		echo "sudo rfkill block 0" | bash
		echo "notify-send -t '2000' -i 'bluetooth' $STATUS" | bash
	# 啟動藍牙
	else
		STATUS="'Bluetooth Information' 'Soft has been enabled'";
		echo "sudo rfkill unblock 0" | bash
		echo "notify-send -t '2000' -i 'bluetooth-active' $STATUS" | bash
	fi
fi
