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

# Set prompt
PS1='[\[\033[01;32m\]\w\[\033[00m\]]$ '

# Apply LS colors 
LS_COLORS=$LS_COLORS:'di=1;33:' ; export LS_COLORS

# Enable color in ls and grep
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Aliases
[ -f ~/.config/bash/aliases ] && source ~/.config/bash/aliases
[ -f ~/.config/bash/shortcuts ] && source ~/.config/bash/shortcuts
