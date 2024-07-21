#!/bin/bash

# Aliases
alias cat='bat'
alias diff='diff --color=auto'
alias g='git'
alias grep='grep --color=auto'
alias ll='lsd -lA'
alias ls='lsd'
alias mkdir='mkdir -pv'
alias th='tmux-helper'
alias tree='lsd --tree'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'

# GPG ask in tty
GPG_TTY=$(tty)
export GPG_TTY

# SCM in prompt
function check_scm {
	if [[ -f .git/HEAD ]]; then
		SCM='git'
	elif which git &>/dev/null && [[ -n "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]]; then
		SCM='git'
	else
		SCM='NONE'
	fi
}

function scm_info {
	check_scm
	if [[ ${SCM} == 'git' ]]; then
		git_prompt_info && return
	fi
}

function git_prompt_info {
	unsafe_ref=$(command git symbolic-ref -q HEAD 2>/dev/null)
	stripped_ref=${unsafe_ref##refs/heads/}
	clean_ref=${stripped_ref//[^a-zA-Z0-9\/]/-}
	SCM_BRANCH=${clean_ref}

	SCM_STATE='✓'
	status=$(command git status --porcelain 2>/dev/null | tail -n1)
	if [[ -n ${status} ]]; then
		SCM_STATE='x'
	fi
}

function scm_prompt {
	scm_info
	if [[ $SCM != 'NONE' ]]; then
		echo -ne ":  ${SCM_BRANCH} ${SCM_STATE} "
	fi
}

function show_host {
	if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
		echo -ne "\[\e[1;91m\]\u\[\e[1;94m\]@\[\e[1;92m\]\h "
	fi
}

PROMPT_DIRTRIM=2
export PS1='$(show_host)\[\e[1;93m\]\w \[\e[1;90m\]$(scm_prompt)\[\e[1;97m\]\$\[\e[0m\] '

stty -ixon            # Disable ctrl-s and ctrl-q
shopt -s autocd       # cd by typing the name
shopt -s dirspell     # Correct spelling errors during tab-completion
shopt -s cdspell      # Correct minor errors in cd
shopt -s checkwinsize # Update window size after every command
shopt -s cmdhist      # Save multiline commands in single line

# Autocompletion
# shellcheck source=/dev/null
source <(cod init $$ bash)
eval "$(gh completion -s bash)"
