#!/bin/bash
# Run as normal user

echo 'Be sure to install appropriate graphics driver.'

LOCAL="$HOME/.local"
CONFIG="$HOME/.config"

echo 'Creating folders...'
mkdir -vp $LOCAL/bin $LOCAL/share $LOCAL/aur
mkdir -vp $CONFIG/i3 $CONFIG/termite $CONFIG/nvim $CONFIG/dunst $CONFIG/compton $CONFIG/i3blocks

echo 'Enabling touchpad for x...'
sudo mkdir -vp /etc/X11/xorg.conf.d
cat > /etc/X11/xorg.conf.d/90-touchpad.conf << 'EOF'
Section "InputClass"
    Identifier "touchpad"
    MatchIsTouchpad "on"
    Driver "libinput"
    Option "Tapping" "on"
    Option "TappingButtonMap" "lmr"
    Option "NaturalScrolling" "on"
    Option "ScrollMethod" "twofinger"
EndSection
EOF

echo 'Copying config files...'
cp /etc/X11/xinit/xinitrc $HOME/.xinitrc
cat >> $HOME/.xinitrc << 'EOF'
eval $(/usr/bin/gnome-keyring/daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
exec i3
EOF

cp /etc/xdg/compton.conf $CONFIG/compton/
cp /etc/xdg/termite/config $CONFIG/termite/
cp /usr/share/dunst/dunstrc $CONFIG/dunst/
