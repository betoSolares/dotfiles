#
# !/bin/bash
# File reads on login
#

# Call the bashrc
if [[ -f ~/.bashrc ]]; then
	. ~/.bashrc
fi

# Some Default Variables
export BROWSER="chromium"
export EDITOR="vim"
export TERMINAL="st"

# Start graphical server
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x i3 >/dev/null && exec startx

