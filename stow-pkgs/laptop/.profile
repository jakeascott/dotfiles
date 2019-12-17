# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.

# If running bash include bashrc
[ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ] && . "$HOME/.bashrc"

# Set PATH so it includes private scripts
[ -d "$HOME/.local/bin" ] && PATH="$HOME/.local/bin:$PATH"

# Set global defaults
export EDITOR="nvim"
export TERMINAL="termite"
export BROWSER="firefox"
#export READER="zathura"
#export FILE="ranger"

# For consistant QT/GTK themes (requires qt5-styleplugins)
export QT_QPA_PLATFORMTHEME=gtk2

# For HiDPI
export GDK_SCALE=2
#export GDK_DPI_SCALE=0.5 # if having trouble with font size

# auto start x session if bspwm not running
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x bspwm >/dev/null && exec startx &>/dev/null
