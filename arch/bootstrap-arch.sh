#!/bin/bash
# Run as normal user

echo 'Be sure to install appropriate graphics driver.'

LOCAL="$HOME/.local"
CONFIG="$HOME/.config"

echo 'Creating folders...'
mkdir -vp $LOCAL/bin $LOCAL/share $LOCAL/aur
mkdir -vp $CONFIG/i3 $CONFIG/termite $CONFIG/nvim $CONFIG/dunst

echo 'Copying config files...'
cp /etc/X11/xinit/xinitrc $HOME/.xinitrc
cat >> $HOME/.xinitrc << 'EOF'
eval $(/usr/bin/gnome-keyring/daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
exec i3
EOF

cp /etc/xdg/termite/config $CONFIG/termite/
cp /usr/share/dunst/dunstrc $CONFIG/dunst/
