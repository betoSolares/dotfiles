#!/bin/bash
# Bash read this file

# If not runnig interactively, do not anything
[[ $- != *i* ]] && return

# Aliases
alias oldls='/usr/bin/ls --color=auto'
alias ls='colorls'
alias ll='colorls -la'
alias lynx='lynx -cfg=/home/beto/.config/lynx/lynx.cfg'
alias grep='grep --color=auto'
alias diff='diff --color=auto'

PS1='[\u@\h \W]\$ '

# Programs
neofetch
