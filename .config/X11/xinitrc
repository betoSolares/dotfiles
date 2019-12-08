#!/bin/sh
# X11 read this file in startup

# Load and merge the resources file
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# Keyboard adjustment
setxkbmap -option caps:swapescape

# Execute wm
exec qtile
