# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.

# If running bash include bashrc
[ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"

# Set PATH so it includes private scripts
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"
[ -d "$HOME/.local/scripts" ] && PATH="$HOME/.local/scripts:$PATH"

# Include GOPATH in PATH if it exists
[ -d "$HOME/go/bin" ] && PATH="$HOME/go/bin:$PATH"

# Include NPM in PATH if it exists
[ -d "$HOME/.npm-global/bin" ] && PATH="$HOME/.npm-global/bin:$PATH"

# Variables for .NET
[ -d "$HOME/.dotnet/tools" ] && PATH="$HOME/.dotnet/tools:$PATH"
export DOTNET_ROOT=/opt/dotnet
export DOTNET_CLI_TELEMETRY_OPOUT=1

# Set global defaults
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="firefox"
export READER="zathura"
export FILE="ranger"

# Change man page reader to vim
export MANPAGER='nvim +Man!'

# For consistant QT/GTK themes (requires qt5-styleplugins)
#export QT_QPA_PLATFORMTHEME=gtk2

# Start gnome keyring if using a display manager
#if [ -n "$DESKTOP_SESSION" ]; then
#    eval $(gnome-keyring-daemon --start)
#    export SSH_AUTH_SOCK
#fi

# auto start x session if dwm not running
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x dwm >/dev/null && exec startx &>/dev/null
