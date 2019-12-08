#!/bin/sh
# File reads on login

# Export own scripts to $PATH
export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':')"

# Some Default Variables
export BROWSER="qutebrowser"
export EDITOR="vim"
export FILE="ranger"
export READER="zathura"
export VIMINIT="source $HOME/.config/vim/vimrc"
export TERMINAL="st"
export INPUTRC="$HOME/.config/input/inputrc"
export LS_COLORS="su=30;41:ow=30;42:st=30;44:"
export BC_ENV_ARGS=~/.config/bc/bc.conf
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export WEECHAT_HOME="$HOME/.config/weechat"
export SUDO_ASKPASS="$HOME/.local/bin/tools/dmenupass"
export GNUPGHOME="$HOME/.local/share/gnupg"
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"
export XINITRC="$HOME/.config/X11/xinitrc"
export HISTFILE="$HOME/.local/share/bash/history"
export FZF_DEFAULT_OPTS='
	--height 50% --reverse --border
	--color fg:7,bg:0,hl:1,fg+:232,bg+:1,hl+:255
	--color info:7,prompt:2,spinner:1,pointer:232,marker:1'

# Less more friendly
export LESS='-R -F -g -i -J -M -W -x2'
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
export LESSHISTFILE=/dev/null

mpd >/dev/null 2>&1 &

# Call the bashrc
echo "$0" | grep "bash$" >/dev/null && [ -f ~/.bashrc ] && source "$HOME/.bashrc"

# Start graphical server
if [[ "$(tty)" = "/dev/tty1" ]]; then
	pgrep qtile || exec startx "$HOME/.config/X11/xinitrc"
fi
