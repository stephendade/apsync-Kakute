# KakutePi Companion

## Introduction
This repository contains a series of scripts for running on a Raspberry Pi in order
to configure it for running with the KakutePi board (though it will run on any Raspberry
Pi with a flight controller connected to the UART).

The scripts are designed to be as automated as possible.

The software is heavily based on the "[APSync](http://ardupilot.org/dev/docs/apsync-intro.html)" companion computer software. Here it has been simplified to become a minimal package.

## Running

Download this repository to a fresh Raspberry Pi install. It is assumed this repository has been
cloned into the ``~/`` directory.

Run each of the ``mainN.sh`` (ie ``main1.sh``, then ``main2.sh``, then ``main3.sh``) scripts in turn. The Raspberry Pi will reboot at the end of each script.

At the end, the Raspberry Pi will be ready for use.

## Using

The Flight controller (Kakute F4 in this case) needs to have the following parameters set:
- ``SERIAL1_BAUD     921``
- ``SERIAL1_OPTIONS  2``

The software running includes:
- [mavlink-router](https://github.com/intel/mavlink-router) for distributing telemetry
- [APWeb](https://github.com/shortstheory/APWeb) for a web-based monitoring and control
- [apstreamline](https://github.com/shortstheory/adaptive-streaming) for low-latency video
- A Wifi access point "ardupilot" (default password "ardupilot")

Once connected to the Wifi access point the interfaces and be accessed.

- The web interface and video streaming control can be access via http://10.0.1.128
- Telemetry software can be connected via UDP IP 10.0.1.128, port 14550. For example
with MAVProxy use the command ``mavproxy.py --master=udpout:10.0.1.128:14550``

Note the the above interfaces can be accessed via the Raspberry Pi's ethernet port, but
the IP address will be different (as per the LAN configuration).

## Known Issues

- The Wifi channel and encryption type cannot be changed via the APWeb interface.
- Video software such as VLC introduces up to 2 seconds of lag in the video streaming. 
See https://github.com/shortstheory/adaptive-streaming#rtsp-streaming for details on how
to reduce this.
