#
# !/bin/bash
# Bash read this file
#

# If not runnig interactively, do not anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

