#!/bin/sh

# shellcheck disable=SC1094
# shellcheck disable=SC1091

# Default Variables
export BROWSER="brave-browser"
export DOCKER_CONFIG="$HOME/.config/docker"
export EDITOR="nvim"
export GNUPGHOME="$HOME/.local/share/gnupg"
export GOPATH="$HOME/.local/go"
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export HISTFILE="$HOME/.local/share/hist/history"
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"
export INPUTRC="$HOME/.config/input/inputrc"
export LS_COLORS="su=30;41:ow=30;42:st=30;44:"
export NPM_CONFIG_USERCONFIG="$HOME/.config/npm/npmrc"
export READER="zathura"
export TERMINAL="alacritty"
export TMUXP_CONFIGDIR="$HOME/.local/share/tmuxp"
export WGETRC="$HOME/.config/wget/wgetrc"
export XAUTHORITY="/tmp/Xauthority"
export XINITRC="$HOME/.config/X11/xinitrc"

# Add scripts to path
PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':')"
export PATH
export PATH="$PATH$HOME/.local/npm/bin"
export PATH="$PATH:$GOPATH/bin"

# Less more friendly
export LESSHISTFILE=/dev/null
export LESS='-R -F -g -i -J -M -W -x2'
LESS_TERMCAP_mb="$(printf '\E[1;31m')"
LESS_TERMCAP_md="$(printf '\E[1;36m')"
LESS_TERMCAP_me="$(printf '\E[0m')"
LESS_TERMCAP_so="$(printf '\E[01;44;33m')"
LESS_TERMCAP_se="$(printf '\E[0m')"
LESS_TERMCAP_us="$(printf '\E[1;32m')"
LESS_TERMCAP_ue="$(printf '\E[0m')"
export LESS_TERMCAP_mb
export LESS_TERMCAP_md
export LESS_TERMCAP_me
export LESS_TERMCAP_so
export LESS_TERMCAP_se
export LESS_TERMCAP_us
export LESS_TERMCAP_ue

if [ "${SHELL}" = "/bin/bash" ]; then
	echo "$0" | grep "bash$" >/dev/null && [ -f ~/.bashrc ] && . "$HOME/.bashrc"
fi

# Start graphical server
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
	exec startx "$HOME/.config/X11/xinitrc" >/dev/null 2>&1
fi
