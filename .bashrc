#!/bin/bash
# Bash read this file

# If not runnig interactively, do not anything
[[ $- != *i* ]] && return

# Aliases
alias lynx='lynx -cfg=/home/beto/.config/lynx/lynx.cfg'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias calcurse='calcurse -C ~/.config/calcurse -D ~/.local/share/calcurse'

# LS
alias oldls='/usr/bin/ls --color=auto'
alias ls='lsd'
alias ll='lsd -la'
export LS_COLORS="su=30;41:ow=30;42:st=30;44:"

# BC
export BC_ENV_ARGS=~/.config/bc/bc.conf
alias bc='bc -l'

# FZF
alias find='find-fzf'
export FZF_DEFAULT_OPTS='
	--height 50% --reverse --border
	--color fg:7,bg:0,hl:1,fg+:232,bg+:1,hl+:255
	--color info:7,prompt:2,spinner:1,pointer:232,marker:1
'

PS1='[\u@\h \W]\$ '

neofetch
