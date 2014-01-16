#!/bin/bash

xinput set-prop 'Logitech USB Trackball' "Evdev Wheel Emulation" 1

# This is for lift hand conf, if you are right hand user you can input '8'
xinput set-prop 'Logitech USB Trackball' "Evdev Wheel Emulation Button" 9

xinput set-prop 'Logitech USB Trackball' "Evdev Wheel Emulation Timeout" 200
xinput set-prop 'Logitech USB Trackball' "Evdev Wheel Emulation Axes" 6 7 4 5
xinput set-prop 'Logitech USB Trackball' "Evdev Middle Button Emulation" 1
xinput set-prop 'Logitech USB Trackball' "Evdev Middle Button Timeout" 50

# Show enable Message.
STATUS="'Marble TrackBall' 'Scrolling bas been enabled'"
echo "notify-send -t 2000 -i mouse $STATUS" | bash
