#!/bin/bash

# ============================================================
#  Author: 凍仁翔 / chusiang.lai (at) gmail.com
#  Blog: http://note.drx.tw
#  Filename: wwan.sh
#  Modified: 2015-01-29 23:04
#  Description: Quicking initialization the WWAN with Gobi2000.
#  Reference: 
#
#   1. 凍仁的筆記: 藉由 Gobi 2000 啟用 ThinkPad T410 行動網路 on Ubuntu 10.04
#    - http://note.drx.tw/2012/05/enable-wwan-with-gobi2000-at-t410.html
#
# =========================================================== 

USBID=$(lsusb | grep Qualcomm | awk '{ print $6 }')

if [ $USBID == "05c6:9205" ]; then

	# 0: tpacpi_wwan_sw: Wireless WAN on t410.
	sudo /usr/sbin/rfkill unblock wwan

	# 1: phy0: Wireless LAN
	sudo /usr/sbin/rfkill block wlan

	echo "Congratulation, you can connect the wwan, now!"
  notify-send "WWAN On" "The WWAN has been Enable." -i 'dialog-apply1' -t '2000'

else

	echo "qcserial module is not initialization."
  notify-send "WWAN fail" "qcserial module is not initialization." -i 'dialog-apply1' -t '2000'

	# restart the modem-manager.
	sudo pkill modem-manager

	# remount the qcserial module.
	sudo rmmod qcserial
	sudo modprobe qcserial

fi
