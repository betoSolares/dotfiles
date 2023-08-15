#!/bin/bash

# Aliases
alias cat='bat'
alias diff='diff --color=auto'
alias g='git'
alias grep='grep --color=auto'
alias ll='lsd -lA'
alias ls='lsd'
alias mkdir='mkdir -pv'
alias open='xdg-open'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias tree='lsd --tree'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias xcpy='xclip -selection clipboard'
alias xpst='xclip -selection clipboard -o'

# GPG ask in tty
GPG_TTY=$(tty)
export GPG_TTY

# SCM in prompt
function check_scm {
	if [[ -f .git/HEAD ]]; then
		SCM='git'
	elif which git &>/dev/null && [[ -n "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]]; then
		SCM='git'
	elif [[ -d .hg ]]; then
		SCM='hg'
	elif which hg &>/dev/null && [[ -n "$(hg root 2>/dev/null)" ]]; then
		SCM='hg'
	elif [[ -d .svn ]]; then
		SCM='svn'
	else
		SCM='NONE'
	fi
}

function scm_info {
	check_scm
	if [[ ${SCM} == 'git' ]]; then
		git_prompt_info && return
	elif [[ ${SCM} == 'hg' ]]; then
		hg_prompt_info && return
	elif [[ ${SCM} == 'svn' ]]; then
		svn_prompt_info && return
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

function get_hg_root {
	CURRENT_DIR=$(pwd)
	while [ "$CURRENT_DIR" != "/" ]; do
		if [ -d "$CURRENT_DIR/.hg" ]; then
			echo "$CURRENT_DIR/.hg"
			return
		fi
		CURRENT_DIR=$(dirname "$CURRENT_DIR")
	done
}

function hg_prompt_info {
	HG_ROOT=$(get_hg_root)
	if [ -f "$HG_ROOT/branch" ]; then
		SCM_BRANCH=$(cat "$HG_ROOT/branch")
	else
		SCM_BRANCH=$(hg summary 2>/dev/null | grep branch: | awk '{print $2}')
	fi

	if [[ -n $(hg status 2>/dev/null) ]]; then
		SCM_STATE='x'
	else
		SCM_STATE='✓'
	fi
}

function svn_prompt_info {
	SCM_BRANCH=$(svn info | grep '^URL:' | grep -E -o '(tags|branches)/[^/]+|trunk' | grep -E -o '[^/]+$')

	if [[ -n $(svn status 2>/dev/null) ]]; then
		SCM_STATE='x'
	else
		SCM_STATE='✓'
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
source <(cod init $$ bash)
eval "$(gh completion -s bash)"
