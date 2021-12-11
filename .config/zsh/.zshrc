#!/bin/zsh

# Aliases
alias bc='bc -l'
alias cat='bat'
alias diff='diff --color=auto'
alias g='git'
alias grep='grep --color=auto'
alias ll='lsd -lA'
alias ls='lsd'
alias lynx='lynx -cfg=/home/beto/.config/lynx/lynx.cfg'
alias mkdir='mkdir -pv'
alias open='xdg-open'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias tk='tmux-killer'
alias tree='lsd --tree'
alias ts='tmux-starter'
alias txk='tmux kill-server'
alias txl='tmux ls'
alias txp='tmuxp'
alias txpf='tmuxp freeze'
alias txpl='tmuxp load'
alias v='vim'
alias vi='vim'
alias xcpy='xclip -selection clipboard'
alias xpst='xclip -selection clipboard -o'

# GPG ask in tty
export GPG_TTY=$(tty)

autoload -U colors && colors # Load colors
setopt PROMPT_SUBST

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# SCM in prompt
function check_scm {
  if [[ -f .git/HEAD ]]; then
    SCM='git'
  elif which git &> /dev/null && [[ -n "$(git rev-parse --is-inside-work-tree 2> /dev/null)" ]]; then
    SCM='git'
  elif [[ -d .hg ]]; then
    SCM='hg'
  elif which hg &> /dev/null && [[ -n "$(hg root 2> /dev/null)" ]]; then
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
    git_prompt_info
  elif [[ ${SCM} == 'hg' ]]; then
    hg_prompt_info
  elif [[ ${SCM} == 'svn' ]]; then
    svn_prompt_info
  fi
}

function git_prompt_info {
  # Branch from here: https://github.com/njhartwell/pw3nage
  unsafe_ref=$(command git symbolic-ref -q HEAD 2> /dev/null)
  stripped_ref=${unsafe_ref##refs/heads/}
  clean_ref=${stripped_ref//[^a-zA-Z0-9\/]/-}
  SCM_BRANCH=${clean_ref}

  # Status
  SCM_STATE='✓'
  st=$(command git status --porcelain 2> /dev/null | tail -n1)
  if [[ -n ${st} ]]; then
    SCM_STATE='✗'
  fi
}

function get_hg_root {
  CURRENT_DIR=$(pwd)
  while [ "$CURRENT_DIR" != "/" ]; do
    if [ -d "$CURRENT_DIR/.hg" ]; then
      echo "$CURRENT_DIR/.hg"
      return
    fi
    CURRENT_DIR=$(dirname $CURRENT_DIR)
  done
}

function hg_prompt_info {
  #Branch from https://github.com/ohmybash/oh-my-bash/blob/master/themes/base.theme.sh
  HG_ROOT=$(get_hg_root)
  if [ -f "$HG_ROOT/branch" ]; then
    # Mercurial holds it's current branch in .hg/branch file
    SCM_BRANCH=$(cat "$HG_ROOT/branch")
  else
    SCM_BRANCH=$(hg summary 2> /dev/null | grep branch: | awk '{print $2}')
  fi

  # Status from https://github.com/ohmybash/oh-my-bash/blob/master/themes/base.theme.sh
  if [[ -n $(hg status 2> /dev/null) ]]; then
    SCM_STATE='✗'
  else
    SCM_STATE='✓'
  fi
}

function svn_prompt_info {
  # Branch
  SCM_BRANCH=$(svn info | grep '^URL:' | egrep -o '(tags|branches)/[^/]+|trunk' | egrep -o '[^/]+$')

  # Status
  if [[ -n $(svn status 2> /dev/null) ]]; then
    SCM_STATE='✗'
  else
    SCM_STATE='✓'
  fi
}

function scm_prompt {
  scm_info
  if [[ $SCM != 'NONE' ]]; then
    echo -ne "  ${SCM_BRANCH} ${SCM_STATE}"
  fi
}

# Vi mode indicator
VIMODE='[INS]'
function zle-keymap-select {
  VIMODE="${${KEYMAP/vicmd/[CMD]}/(main|viins)/[INS]}"
  zle reset-prompt
}
zle -N zle-keymap-select

PS1='%B%{$fg[red]%}%1~%{$fg[yellow]%}$(scm_prompt) %{$fg[blue]%}${VIMODE} %{$reset_color%}❯ %b'

setopt autocd # Automatically cd into typed directory.
stty stop undef # Disable ctrl-s to freeze terminal.
bindkey -v # vi mode
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Autocompletion
. /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source <(cod init $$ zsh)
