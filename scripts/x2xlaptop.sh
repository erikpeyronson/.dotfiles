#!/bin/sh
xrandr --output VIRTUAL1 --off --output DP1 --off --output HDMI3 --off --output HDMI2 --mode 1920x1080 --pos 1080x669 --rotate normal --output HDMI1 --off --output VGA1 --off
ssh -X peyron@192.168.0.202  x2x -west -to :0.0 
