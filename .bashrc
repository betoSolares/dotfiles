#!/bin/bash
# Bash read this file

# If not runnig interactively, do not anything
[[ $- != *i* ]] && return

# Aliases
alias lynx='lynx -cfg=/home/beto/.config/lynx/lynx.cfg'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias calcurse='calcurse -C ~/.config/calcurse -D ~/.local/share/calcurse'
alias oldls='/usr/bin/ls --color=auto'
alias ls='lsd'
alias ll='lsd -la'
alias bc='bc -l'
alias find='find-fzf'

PS1='[\u@\h \W]\$ '

neofetch
