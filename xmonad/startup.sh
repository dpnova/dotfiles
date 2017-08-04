#!/bin/bash
#yourStartUpApplication &
xmobar &
lxpanel &
sh -c 'xrandr --output DVI-I-3 --mode 2560x1440 --rate 59.95 --output DVI-I-2 --mode 2560x1440 --rate 59.95 --right-of DVI-I-3 --output TV-0 --off'
xmonad

