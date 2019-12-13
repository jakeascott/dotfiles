# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

PATH="/mnt/c/Program Files (x86)/Google/Chrome/Application/:$PATH"

BROWSER='chrome.exe'

# Sets window title to 'wsl'
echo -ne '\e]0;wsl\a'

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/instantclient_19_3:$PATH"

export DISPLAY=:0

if [[ -z $TMUX ]]; then
    if [ $(tmux ls | wc -l) -gt 0 ]; then
        exec tmux attach
    else
        exec tmux
    fi
fi
