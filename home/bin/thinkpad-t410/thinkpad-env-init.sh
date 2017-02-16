#!/bin/bash
# Info:	ThinkPad T410 Environment Initialization.
# Initialization =
#PATH_TP="/home/jonny/bin/thinkpad-t410"
PATH_TP="/home/jonny/bin/thinkpad-t410/"

# = Wireless =
#sudo "$PATH_TP/wifi-disable.sh"

# = Workarounds =
LINES=`disper -l | wc -l`
DISPLAY_COUNT=$((LINES / 2))

if [ $DISPLAY_COUNT -eq "2" ]; then
	#disper -d auto -e          # DFP-0 left of CRT-0
    disper -d auto  -e -t left  # DFP-0 right of CRT-0
else
	disper -d DFP-0 -s
fi

# = TrackPoint =
# - Speed.
sudo "$PATH_TP/trackpoint-speed.sh"

# - Scrolling.
#  - ThinkPad PS/2 keyboard.
TP_PS2_KB_COUNT=`xinput list | grep 14 | wc -l`
if [ $TP_PS2_KB_COUNT -eq "1" ]; then
  xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 8 1
  xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 8 2
  xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Axes" 8 6 7 4 5
fi

#  - ThinkPad USB keyboard.
TP_USB_KB_COUNT=`xinput list | grep 11 | wc -l`
if [ $TP_USB_KB_COUNT -eq "2" ]; then
  xinput --set-prop --type=int --format=8 11 "Evdev Wheel Emulation" 1
  xinput --set-prop --type=int --format=8 11 "Evdev Wheel Emulation Button" 2
  xinput --set-prop --type=int --format=8 11 "Evdev Wheel Emulation Axes" 6 7 4 5
fi

# = swap Caps Lock and left Ctrl =

HHKB_COUNT=`lsusb | grep "Topre Corporation HHKB Professional" | wc -l`
if [ $HHKB_COUNT -ne "1" ]; then
	/usr/bin/setxkbmap -option "ctrl:swapcaps"
else
  # Only switch the Caps Lock and Left Ctrl layout at ThinkPad T410.
  /usr/bin/setxkbmap -option "ctrl:swapcaps" -device 13
fi

#STATUS="'ThinkPad Initialization' ''"
#echo "notify-send -t 2000 -i mouse $STATUS" | bash

