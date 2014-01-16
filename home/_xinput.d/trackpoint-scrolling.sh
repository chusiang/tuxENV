#!/bin/sh

# = Setting scrolling of trackpoint on laptops =
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 8 1
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 8 2
xinput set-int-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Axes" 8 6 7 4 5

STATUS="'UltraNav TrackPoint' 'Scrolling bas been enabled'"
echo "notify-send -t 2000 -i mouse $STATUS" | bash

# = Setting scrolling of trackpoint on USB keyboard =
xinput set-int-prop "11" "Evdev Wheel Emulation" 8 1
xinput set-int-prop "11" "Evdev Wheel Emulation Button" 8 2
xinput set-int-prop "11" "Evdev Wheel Emulation Axes" 8 6 7 4 5

STATUS2="'UltraNav TrackPoint Keyboard' 'Scrolling bas been enabled'"
echo "notify-send -t 2000 -i mouse $STATUS2" | bash

