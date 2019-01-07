#
# !/bin/bash
# X11 read this file in startup
#

# Clean the bash history
if [[ -f ~/.bash_history ]]; then
	> ~/.bash_history
fi

# Execute qtile
exec qtile

