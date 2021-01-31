#!/bin/fish

# Aliases
alias lynx='lynx -cfg=/home/beto/.config/lynx/lynx.cfg'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias calcurse='calcurse -C ~/.config/calcurse -D ~/.local/share/calcurse'
alias oldls='/usr/bin/ls --color=auto'
alias ls='lsd'
alias ll='lsd -lA'
alias bc='bc -l'
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias null='/dev/null'
alias cls='clear'
alias ts='tmux-starter'
alias open='xdg-open'
alias tree='lsd --tree'
alias vi='vim'
alias drm='docker rm -vf (docker ps -a -q)'
alias drmi='docker rmi (docker images -a -q)'
alias cz='cz -S'

# GPG ask in tty
set -x GPG_TTY (tty)

# Greeting
function fish_greeting
end

# Git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_char_stateseparator ' '
set __fish_git_prompt_char_dirtystate '*'
set __fish_git_prompt_char_stagedstate '#'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_color_dirtystate blue
set __fish_git_prompt_color_invalidstate red
set __fish_git_prompt_color_stagedstate yellow
set __fish_git_prompt_color_branch yellow

# Prompt
function fish_prompt
  printf '%s' (prompt_pwd)
  printf '%s' (__fish_git_prompt)
  printf ' > '
end

# Vi mode
fish_vi_key_bindings
set fish_cursor_default block

# Pywal colors
source ~/.cache/wal/colors.fish
