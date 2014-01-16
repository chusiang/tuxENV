#!/bin/bash
# Name:	wwan.sh
# Info:	Initialization the Gobi2000 wwan.

sudo rfkill unblock wwan

USBID=$(lsusb | grep Qualcomm | awk '{ print $6 }')

if [ $USBID == "05c6:9205" ]; then

	# 1: tpacpi_wwan_sw: Wireless WAN on t410.
	sudo /usr/sbin/rfkill unblock 1
	echo "Congratulation, you can connect the wwan, now!"

else

	echo "qcserial module is not initialization."

	# restart the modem-manager.
	sudo pkill modem-manager;

	# remount the qcserial module.
	sudo rmmod qcserial;
	sudo modprobe qcserial

fi
