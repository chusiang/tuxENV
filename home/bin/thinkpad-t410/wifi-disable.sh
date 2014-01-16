#!/bin/bash
# FIleName:	thinkpad-wifi-disable.sh
# Info:	disable bluetooth and wwan at ThinkPad T410, by the way it need root permission.

# = Wireless =

# == Bluetooth ==

# - enable bluetooth at startup
#echo 1 > /sys/devices/platform/thinkpad_acpi/bluetooth_enable

# - disable bluetooth at startup
#echo 0 > /sys/devices/platform/thinkpad_acpi/bluetooth_enable

# - disable bluetooth
rfkill block 0

# == WWAN ==

# - enable wwan at startup
#echo 1 > /sys/devices/platform/thinkpad_acpi/wwan_enable

# - disable wwan at startup
#echo 0 > /sys/devices/platform/thinkpad_acpi/wwan_enable

# - disable wwan
rfkill block 1

# == WLAN ==

# - disable wlan
rfkill block 2

#STATUS="'WiFi Disabled' 'bluetooth, wwan bas been disabled'"
#echo "notify-send -t 2000 -i mouse $STATUS" | bash

