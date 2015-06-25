#!/bin/bash

export PT6HOME=/opt/pt

cd $PT6HOME
Xvfb :1 -extension GLX -screen 0 1024x780x24& DISPLAY=:1 bin/PacketTracer6 saves/FORGE/ibookdemo611.pkt &
x11vnc -forever -usepw -display :1

exit 0
