#!/bin/fish

# Aliases
alias bc='bc -l'
alias calcurse='calcurse -C ~/.config/calcurse -D ~/.local/share/calcurse'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias lynx='lynx -cfg=/home/beto/.config/lynx/lynx.cfg'
alias mkdir='mkdir -pv'

alias cat='bat'
alias ls='lsd'
alias ll='lsd -lA'
alias tree='lsd --tree'
alias vi='vim'

alias cls='clear'
alias g='git'
alias open='xdg-open'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias tk='tmux-killer'
alias tm='tmuxp'
alias ts='tmux-starter'
alias txk='tmux kill-server'
alias txl='tmux ls'
alias v='vim'
alias xcpy='xclip -selection clipboard'
alias xpst='xclip -selection clipboard -o'

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
#source ~/.cache/wal/colors.fish

# Autocompletion
cod init %self fish | source
