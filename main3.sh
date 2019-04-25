#!/bin/bash

## Part 3/3 - Wifi access point
set -e
set -x

# need to run from home directory
cd ~/

./wifi_access_point.sh

## Remove any not required packages
sudo apt autoremove -y

## And last of all, reboot
sudo reboot

