#!/bin/bash
# FileName:	monitor-switch.sh
# Info: 	Switch single/secondary/clone/extend display with disper on Multiple Monitor.
# Note:		test 'Fn + F7' hotkey.

# = Initialization =
LINES=`disper -l | wc -l`
DISPLAY_COUNT=$((LINES / 2))
PRIMARY=$(disper -l | sed -n '1p' | awk '{ print $2 }' | sed 's/://')

# = Main =

# - only local display.
if [ $DISPLAY_COUNT -eq "1" ]; then
	disper -d $PRIMARY -s
	echo "DISPLAY_STATUS = single" > /dev/shm/disper-status

# - over two displays.
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

# -----------------------------------
#  Author : Chu-siang Lai
#  E-mail : jonny (at) drx.tw
#  Blog : http://note.drx.tw
# -----------------------------------
