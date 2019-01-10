#
# !/bin/bash
# File reads on login
#

# Call the bashrc
if [[ -f ~/.bashrc ]]; then
	. ~/.bashrc
fi

# Export own scripts to $PATH
if [[ -f ~/.scripts ]]; then
       export PATH=$PATH:$HOME/.scripts
fi

# Some Default Variables
export BROWSER="chromium"
export EDITOR="vim"
export TERMINAL="st"

# Start graphical server
if [[ "$tty" = "/dev/tty1" ]]; then
	pgrep qtile || exec startx
fi
