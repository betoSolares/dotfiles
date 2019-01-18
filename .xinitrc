#
# !/bin/bash
# X11 read this file in startup
#

# Load and merge the resources file
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# Clean the bash history
if [[ -f ~/.bash_history ]]; then
	> ~/.bash_history
fi

# Execute qtile
exec qtile

