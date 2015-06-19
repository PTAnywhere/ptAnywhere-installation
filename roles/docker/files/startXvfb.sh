#!/bin/bash

Xvfb :1 -extension GLX -screen 0 1024x780x24& DISPLAY=:1 /usr/bin/firefox&
x11vnc -forever -usepw -display :1

exit 0
