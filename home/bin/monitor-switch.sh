# ============================================================
#  Author: 凍仁翔 / chusiang.lai (at) gmail.com
#  Blog: http://note.drx.tw
#  Filename: monitor-switch.sh
#  Modified: 2014-12-31 21:11
#  Description:
#      Switching single/secondary/clone/extend mode display with
#    'disper' on Multi-monitor, and I like to switch with Fn + F7.
#  Reference: 
#   1. 
# =========================================================== 

#!/bin/bash

# - Initialization
LINES=`disper -l | wc -l`
DISPLAY_COUNT=$((LINES / 2))
PRIMARY=$(disper -l | sed -n '1p' | awk '{ print $2 }' | sed 's/://')

# - Main

# Only one display.
if [ $DISPLAY_COUNT -eq "1" ]; then
	disper -d $PRIMARY -s
	echo "DISPLAY_STATUS = single" > /dev/shm/disper-status

# Over one display.
else

	# disper-status exist
	if [ -f /dev/shm/disper-status ]; then
		STATUS=$(cat /dev/shm/disper-status | awk '{ print $3}')

		case $STATUS in
			single)
				disper -d auto -S
				echo "DISPLAY_STATUS = secondary" > /dev/shm/disper-status;;
		
			secondary)
				disper -d auto -c
				echo "DISPLAY_STATUS = clone" > /dev/shm/disper-status;;
		
			clone)
				disper -d auto -e
				echo "DISPLAY_STATUS = extend" > /dev/shm/disper-status;;
		
			extend)
				disper -d $PRIMARY -s
				echo "DISPLAY_STATUS = single" > /dev/shm/disper-status;;
		esac

	# disper-status not exist
	else
		echo "DISPLAY_STATUS = single" > /dev/shm/disper-status
	fi

fi

