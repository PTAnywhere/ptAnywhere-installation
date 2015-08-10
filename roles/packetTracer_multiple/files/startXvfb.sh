#!/bin/bash

export PT6HOME=/opt/pt
export DISPLAY=:1

# Start Xvfb on virtual display 1
Xvfb $DISPLAY -screen 0 1024x780x24&

# Run Packet Tracer
cd $PT6HOME
bin/PacketTracer6 saves/FORGE/ibookdemo611.pkt &

# Afterwards you could run other apps in this virtual display. E.g.:
# DISPLAY=:1 firefox http://www.google.com &

# VNC on virtual display
x11vnc -forever -usepw -display $DISPLAY

exit 0
