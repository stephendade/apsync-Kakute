#!/bin/bash

set -e
set -x

rm -rf APStreamline
sudo apt install ninja-build libgstreamer-plugins-base1.0* libgstreamer1.0-dev libgstrtspserver-1.0-dev gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly -y
pip3 install meson --user

sudo modprobe bcm2835-v4l2
echo "bcm2835-v4l2" | sudo tee -a /etc/modules >/dev/null

[ -d apstreamline ] || {
    git clone https://github.com/shortstheory/adaptive-streaming.git APStreamline
}
pushd APStreamline
 # last commit to work with changing quality levels without crashing
 git checkout d6efd60548dfd34177b47f229ba594fa95a45498
 meson build
 pushd build
  meson configure -Dprefix=$HOME/start_apstreamline/
  ninja install
  sudo mkdir -p /root/start_apstreamline/bin
  sudo cp $HOME/start_apstreamline/bin/stream_server /root/start_apstreamline/bin/stream_server
 popd
popd
