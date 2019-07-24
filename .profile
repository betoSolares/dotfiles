#!/bin/sh
# File reads on login

# Export own scripts to $PATH
export PATH="$PATH:$(du "$HOME/bin/" | cut -f2 | tr '\n' ':')"

# Some Default Variables
export BROWSER="qutebrowser"
export EDITOR="vim"
export TERMINAL="st"

# Call the bashrc
echo "$0" | grep "bash$" >/dev/null && [ -f ~/.bashrc ] && source "$HOME/.bashrc"

# Start graphical server
if [[ "$(tty)" = "/dev/tty1" ]]; then
	pgrep qtile || exec startx
fi
