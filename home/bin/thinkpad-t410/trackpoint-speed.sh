#!/bin/bash
# FIleName:	thinkpad-trackpoint-speed.sh
# Info:	ThinkPad T410 TrackPoint Speed and Sensitivity Initialization.

# = TrackPoint =
# - Speed.
echo -n 100 > /sys/devices/platform/i8042/serio1/serio2/speed
echo -n 250 > /sys/devices/platform/i8042/serio1/serio2/sensitivity

#STATUS="'UltraNav TrackPoint' 'Speen and Sensitivity bas been initialized'"
#echo "notify-send -t 2000 -i mouse $STATUS" | bash

