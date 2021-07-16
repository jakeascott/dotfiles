#===========================================
#      _               _
#     | |__   __ _ ___| |__  _ __ ___
#     | '_ \ / _` / __| '_ \| '__/ __|
#  _  | |_) | (_| \__ \ | | | | | (__
# (_) |_.__/ \__,_|___/_| |_|_|  \___|
#
# ==========================================

# activate vi mode
#set -o vi

# bind C-l to clear screen
bind -x '"\C-l":clear'

# set shell options
shopt -s autocd # cd by only typing path
shopt -s cdspell # cd automatically fixes directory name typos
shopt -s direxpand dirspell # auto expand directory globs
shopt -s globstar # enable ** globstar recursive pattern
shopt -s histappend histverify # append to history file, !! will expand
shopt -s checkwinsize # resize window after each command if necessary

# History options
HISTCONTROL='erasedups:ignoreboth'
HISTIGNORE=?:?? # ignore 1 and 2 character commands
HISTSIZE=9999
HISTFILESIZE=9999
PROMPT_COMMAND='history -a'

# Prompt Colors (color: \[\e[XX;YYm\])
RESET="\[\e[0m\]"
RED="\[\e[01;91m\]"
GREEN="\[\e[01;92m\]"
YELLOW="\[\e[01;93m\]"
BLUE="\[\e[01;94m\]"
PURPLE="\[\e[01;95m\]"
CYAN="\[\e[01;96m\]"

# Function for git branch in prompt
git_branch() {
    git branch 2> /dev/null | awk '/^\*/ {print " ("$2")"}'
}

# Set Prompt
PS1="$PURPLE\u $GREEN\w$YELLOW\$(git_branch)$RESET $ "
PROMPT_DIRTRIM=2 # Sets depth of directory displayed in prompt

# Apply LS & GREP colors
LS_COLORS='ow=0;30;102:di=1;32:ex=1;35:ln=4;36:' ; export LS_COLORS
# GREP_COLOR="1;32"; export GREP_COLOR

# Enable color for various commands
alias ls='ls -hN --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias diff='diff --color=auto'

# Source aliases
[ -f ~/.aliases ] && source ~/.aliases
