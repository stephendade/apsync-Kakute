#!/bin/bash

set -e
set -x

# this script sets up the wifi access point

# NOTE: if something goes wrong with this setup, and you are unable to connect to the TX1, connect a keyboard and mouse and type "sudo dhclient eth0"
sudo apt install dnsmasq haveged -y

# stop dnsmasq from running outside of where we want it to:
sudo systemctl disable dnsmasq

# Create Access Point
APNAME="WiFiAP"
SSID="ardupilot"
KEY="ardupilot"

# add IP address range to /etc/dnsmasq.conf
sudo dd of=/etc/dnsmasq.d/$APNAME.conf <<EOF
interface=wlan0
dhcp-range=10.0.1.129,10.0.1.138,12h
EOF

sudo systemctl disable dnsmasq

IFNAME=wlan0
sudo nmcli connection add type wifi ifname $IFNAME con-name $APNAME ssid $SSID
sudo nmcli connection modify $APNAME connection.autoconnect yes
sudo nmcli connection modify $APNAME 802-11-wireless.mode ap
sudo nmcli connection modify $APNAME 802-11-wireless.band bg
sudo nmcli connection modify $APNAME ipv4.method shared
sudo nmcli connection modify $APNAME wifi-sec.key-mgmt wpa-psk
sudo nmcli connection modify $APNAME ipv4.addresses 10.0.1.128/24
sudo nmcli connection modify $APNAME wifi-sec.psk "$KEY"
sudo nmcli connection modify $APNAME 802-11-wireless-security.group ccmp
sudo nmcli connection modify $APNAME 802-11-wireless-security.pairwise ccmp
sudo nmcli connection up $APNAME

