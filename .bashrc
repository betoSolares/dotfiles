#!/bin/bash
# Bash read this file

# If not runnig interactively, do not anything
[[ $- != *i* ]] && return

# Aliases
alias ls='ls --color=auto'
alias lynx='lynx -cfg=/home/beto/.config/lynx/lynx.cfg'
alias grep='grep --color=auto'
alias diff='diff --color=auto'

PS1='[\u@\h \W]\$ '

# Programs
neofetch
