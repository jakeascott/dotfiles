#===========================================
#     _               _              
#    | |__   __ _ ___| |__  _ __ ___ 
#    | '_ \ / _` / __| '_ \| '__/ __|
# _  | |_) | (_| \__ \ | | | | | (__ 
#(_) |_.__/ \__,_|___/_| |_|_|  \___|
# 
# ==========================================

# activate vi mode
set -o vi

# set shell options
shopt -s autocd # cd by only typing path
shopt -s histappend # append to history file
shopt -s checkwinsize # resize window after each command if necessary

# bind C-l to clear screen
bind -x '"\C-l":clear'

# History options
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=500

# Set prompt (color: \[\e[XXm\]text)
PS1='[\[\e[01;92m\]\w\[\e[00m\]]$ '

# Apply LS & GREP colors 
LS_COLORS='ow=0;30;102:di=0;30;102:ex=1;35:ln=4;36:' ; export LS_COLORS
# GREP_COLOR="1;32"; export GREP_COLOR

# Enable color for various commands
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'

# Source aliases
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# Base16 Shell
#BASE16_SHELL="$HOME/.config/base16-shell/"
#[ -n "$PS1" ] && [ -s "$BASE16_SHELL/profile_helper.sh" ] && eval "$("$BASE_16_SHELL/profile_helper.sh")"
