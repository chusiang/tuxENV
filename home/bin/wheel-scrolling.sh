# ============================================================
#  Author: 凍仁翔 / chusiang.lai (at) gmail.com
#  Blog: http://note.drx.tw
#  Filename: wheel-scrolling.sh
#  Modified: 2014-12-31 21:39
#  Description: 
#  Reference: 
#   1. 凍仁的筆記: Logitech Marble Trackball on Ubuntu 10.04+
#     - http://note.drx.tw/2010/06/logitech-marble-trackball-on-ubuntu.html
# =========================================================== 

#!/bin/bash

DEV_WHEEL=$(lsusb | grep "Logitech, Inc. TrackMan Wheel" | wc -l)

if [ $DEV_WHEEL -eq "1" ]
	then
		xinput set-prop 'Logitech Trackball' "Evdev Wheel Emulation" 1
		xinput set-prop 'Logitech Trackball' "Evdev Wheel Emulation Button" 3
		xinput set-prop 'Logitech Trackball' "Evdev Wheel Emulation Timeout" 200
		xinput set-prop 'Logitech Trackball' "Evdev Wheel Emulation Axes" 6 7 4 5
		xinput set-prop 'Logitech Trackball' "Evdev Middle Button Emulation" 1
		xinput set-prop 'Logitech Trackball' "Evdev Middle Button Timeout" 50
		
		STATUS="'Wheel TrackBall' 'Scrolling bas been enabled'"

	else
		STATUS="'Wheel TrackBall' 'No search device'"
fi

echo "notify-send -t 2000 -i mouse $STATUS" | bash

