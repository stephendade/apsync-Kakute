#!/bin/bash

set -e
set -x

sudo apt install autoconf automake libtool -y

## Git clone mavlink-router
rm -rf mavlink-router
[ -d mavlink-router ] || {
    git clone https://github.com/intel/mavlink-router.git
}

## and build them
pushd ~/mavlink-router
 git submodule update --init --recursive
 ./autogen.sh && ./configure CFLAGS='-g -O2' --sysconfdir=/etc --localstatedir=/var --libdir=/usr/lib64 --prefix=/usr
 make
 sudo make install
 sudo mkdir -p /etc/mavlink-router
 sudo cp ../mavlink-router.conf /etc/mavlink-router/main.conf
 sudo systemctl enable mavlink-router.service
 sudo systemctl start mavlink-router.service
popd
