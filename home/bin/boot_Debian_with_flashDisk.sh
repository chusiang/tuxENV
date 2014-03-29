#!/bin/bash
# ============================================================
#  Author: 凍仁翔 / chusiang.lai (at) gmail.com
#  Blog: http://note.drx.tw
#  Filename: boot_Debian_with_flashDisk.sh
#  Description:
#
#    Boot Debian from an USB device | Debian Administration
#    - http://www.debian-administration.org/article/446/Boot_Debian_from_an_USB_device
#
#  Last modified: 2014-03-29 09:27
# =========================================================== 

BOOT_IMG="/home/jonny/package/operating-system/debian/boot.img.gz"
INSTALL_ISO="/home/jonny/package/operating-system/debian/debian-7.4.0-amd64-CD-1.iso"

# First unmount your memory stick. (/dev/sdc)
sudo umount $(mount | grep sdc | awk '{ print $3 }')

# download the boot.img.gz, which is necessary to make your USB device bootable:
#wget ftp://ftp.debian.org/debian/dists/stable/main/installer-amd64/current/images/hd-media/boot.img.gz

# Extract this image and write it to your USB device:
#sudo zcat boot.img.gz > /dev/sdc
sudo zcat $BOOT_IMG > /dev/sdc

# Now mount the volume to /mnt:
sudo mount /dev/sdc /mnt && cd /mnt/

# Download the ISO to the USB device:
#sudo wget ftp://free.nchc.org.tw/debian-cd/7.4.0/amd64/iso-cd/debian-7.4.0-amd64-CD-1.iso
sudo cp $INSTALL_ISO /mnt && sync && sync && sync

# Now you can unmount the volume:
cd ~ && sudo umount /dev/sdc


