# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.

# If running bash include bashrc
[ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"

# Set PATH so it includes private scripts
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"

# Set global defaults
export EDITOR="nvim"
export TERMINAL="gnome-terminal"
export BROWSER="firefox"

export QT_QPA_PLATFORMTHEME=qt5ct
