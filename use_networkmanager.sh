#!/bin/bash

# RPi2 setup script for use as companion computer

set -e
set -x

sudo rm /etc/network/interfaces
sudo touch /etc/network/interfaces
sudo apt-get install -y network-manager

sudo systemctl disable networking
sudo systemctl stop networking

sudo apt-get remove -y modemmanager

# Disable wpa_supplicant
if [ -e /etc/wpa_supplicant/wpa_supplicant.conf ]; then
    sudo mv /etc/wpa_supplicant/wpa_supplicant.conf{,-unused}
fi
sudo systemctl stop wpa_supplicant
sudo systemctl disable wpa_supplicant
sudo killall /sbin/wpa_supplicant || true

# Enable NetworkManager
sudo systemctl start NetworkManager
sudo systemctl enable NetworkManager

