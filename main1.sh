#!/bin/bash

## Part 1/3 - Ras Pi hardware config
set -e
set -x

# need to run from home directory
cd ~/

## Raspi-Config - camera, serial port, ssh
sudo raspi-config nonint do_expand_rootfs
sudo raspi-config nonint do_camera 0
sudo raspi-config nonint do_ssh 0
sudo raspi-config nonint do_serial 0

## Change hostname
sudo raspi-config nonint do_hostname apsync
sudo perl -pe 's/raspberrypi/apsync/' -i /etc/hosts

# stop systemd starting a getty on ttyS0:
sudo systemctl disable serial-getty@ttyS0.service
sudo perl -pe 's/ console=serial0,115200//' -i /boot/cmdline.txt

## Power switch config
echo "" | sudo tee -a /boot/config.txt >/dev/null
echo "# Power switch" | sudo tee -a /boot/config.txt >/dev/null
echo "dtoverlay=gpio-shutdown" | sudo tee -a /boot/config.txt >/dev/null
echo "dtoverlay=gpio-poweroff" | sudo tee -a /boot/config.txt >/dev/null

sudo reboot
