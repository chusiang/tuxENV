#!/bin/bash

# Checking Environment with IP.

declare DEVICE="eth0"
declare STA
declare ADDRESS="172.16.1.100"

/sbin/ifconfig $DEVICE | grep $ADDRESS && STA=1 || STA=0 2>&1 /dev/null

if [ $STA -eq 1 ]; then
  synergys -f --config ~/.synergy.conf &
fi

unset DEVICE
unset STA
unset ADDRESS
