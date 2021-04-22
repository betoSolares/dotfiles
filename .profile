#!/bin/sh
# File reads on login

# Export own scripts to $PATH
export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | tr '\n' ':')"

# Some Default Variables
export BROWSER="qute"
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
export XAUTHORITY="/tmp/Xauthority"
export XINITRC="$HOME/.config/X11/xinitrc"
export HISTFILE="$HOME/.local/share/hist/history"
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"
export NPM_CONFIG_USERCONFIG="$HOME/.config/npm/npmrc"
export TMUXP_CONFIGDIR="$HOME/.local/share/tmuxp"
export ZDOTDIR="$HOME/.config/zsh"

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


# Call the rc
if [ "${SHELL}" = "/bin/bash"  ]; then
	echo "$0" | grep "bash$" >/dev/null && [ -f ~/.bashrc  ] && source "$HOME/.bashrc"
  else
	echo "$0" | grep "zsh$" >/dev/null && [ -f ~/.config/zsh/.zshrc  ] && source "$HOME/.config/zsh/.zshrc"
fi

# Window Manager
#export WM="qtile"
#export WM="fvwm"
#export WM="dwm"
export WM="pekwm"

# Start graphical server
if [[ "$(tty)" = "/dev/tty1" ]]; then
	pgrep "${WM}" || exec startx "$HOME/.config/X11/xinitrc" &> /dev/null
fi
