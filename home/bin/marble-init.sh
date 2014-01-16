#!/bin/bash
# Filename: marble-init.sh
# Info:		Enable scroll and middle click at Marble TrackBall.

DEV_MARBLE=$( lsusb | grep -i "Logitech, Inc. Marble Mouse" | wc -l )

if [ $DEV_MARBLE -eq "1" ]; then

	# Scroll with button(9)
	xinput set-prop 'Logitech USB Trackball' "Evdev Wheel Emulation" 1
	xinput set-prop 'Logitech USB Trackball' "Evdev Wheel Emulation Button" 9
	xinput set-prop 'Logitech USB Trackball' "Evdev Wheel Emulation Timeout" 200
	xinput set-prop 'Logitech USB Trackball' "Evdev Wheel Emulation Axes" 6 7 4 5
	xinput set-prop 'Logitech USB Trackball' "Evdev Middle Button Emulation" 1
	xinput set-prop 'Logitech USB Trackball' "Evdev Middle Button Timeout" 50

	# middle click with button(8).
	xinput set-button-map "Logitech USB Trackball" 1 8 3 4 5 6 7 2 9

	STATUS="'Marble TrackBall' 'Enabled Scroll and Middle Click'"

else

	STATUS="'Marble TrackBall' 'No search device'"

fi

echo "notify-send -t 2000 -i mouse $STATUS" | bash

# ------------------------------------
# Author : Chu-Siang, Lai
# E-mail : jonny (at) drx.tw
# Blog: http://note.drx.tw
# ------------------------------------

