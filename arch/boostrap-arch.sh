#!/bin/bash
# run as normal user

echo 'Be sure to install appropriate graphics driver.'

echo 'Installing Xorg, i3, and basic utils...'
sudo pacman -S xorg-server xorg-xinit xorg-apps ttf-dejavu ttf-font-awesome ttf-hack i3-gaps i3blocks i3lock dmenu termite compoton xclip libnotify dunst xwallpaper htop acpi sysstat bc

echo 'Creating config files...'

mkdir -vp $HOME/.local/bin $HOME/.local/share
mkdir -vp $HOME/.config/i3 $HOME/.config/termite $HOME/.config/nvim

cp /etc/X11/xinit/xinitrc $HOME/.xinitrc
cat >> $HOME/.xinitrc << EOF
eval $(/usr/bin/gnome-keyring/daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
xrandr --output <screen> --mode <resolution>
exec i3
EOF

cp /etc/xdg/termite/config $HOME/.config/termite/config
echo 'copied termite config'
