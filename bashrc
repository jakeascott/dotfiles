# ~/.bashrc executed when new interactive shell is launched. 

# activate vi mode
set -o vi

# set shell options
shopt -s autocd # cd by only typing path
shopt -s histappend # append to history file
shopt -s checkwinsize # resize window after each command if necessary

# History options
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=500

# Set prompt (color: \[\e[XXm\]text)
PS1='[\[\e[01;94m\]\u\[\e[01;93m\]@\[\e[01;95m\]\h\[\e[01;92m\] \w\[\e[00m\]]$ '

# Apply LS & GREP colors 
LS_COLORS=$LS_COLORS:'di=1;32:' ; export LS_COLORS
# GREP_COLOR="1;32"; export GREP_COLOR

# Enable color for various commands
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'

# Source aliases & shortcuts
[ -f ~/.config/bash/aliases ] && source ~/.config/bash/aliases
[ -f ~/.config/bash/shortcuts ] && source ~/.config/bash/shortcuts
