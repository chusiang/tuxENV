# ============================================================
#  Author: 凍仁翔 / chusiang.lai (at) gmail.com
#  Blog: http://note.drx.tw
#  Filename: marble-init.sh
#  Modified: 2014-12-31 20:43
#  Description: Enable scroll and middle click at Marble TrackBall.
#  Reference: 
#   1. 凍仁的筆記: Logitech Marble Trackball on Ubuntu 10.04+
#     - http://note.drx.tw/2010/06/logitech-marble-trackball-on-ubuntu.html
# =========================================================== 

#!/bin/bash

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

# We can send message to system notification with libnotify-bin.
echo "notify-send -t 2000 -i mouse $STATUS" | bash

