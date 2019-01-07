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

