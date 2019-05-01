#!/bin/bash
# run as normal user

echo 'Be sure to install appropriate graphics driver.'

echo 'Installing Xorg, i3, and basic utils...'
sudo pacman -S xorg-server xorg-xinit xorg-apps ttf-dejavu ttf-font-awesome i3-gaps i3blocks i3lock dmenu termite compton xclip libnotify dunst xwallpaper htop acpi bc lxappearance

LOCAL="$HOME/.local"
CONFIG="$HOME/.config"

echo 'Creating config folders...'
mkdir -vp $LOCAL/bin $LOCAL/share
mkdir -vp $CONFIG/i3 $CONFIG/termite $CONFIG/nvim $CONFIG/dunst

echo 'Installing config files...'
cp /etc/X11/xinit/xinitrc $HOME/.xinitrc
cat >> $HOME/.xinitrc << 'EOF'
eval $(/usr/bin/gnome-keyring/daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
xrandr --output <screen> --mode <resolution>
exec i3
EOF

cp /etc/xdg/termite/config $CONFIG/termite/
cp /usr/share/dunst/dunstrc $CONFIG/dunst/
