#!/bin/bash
# Run as normal user

echo 'Be sure to install appropriate graphics driver.'
sudo pacman -S --no-confirm xorg-server xorg-xinit xorg-apps pulseaudio pulseaudio-alsa pulsemixer ttf-dejavu otf-font-awesome i3-gaps i3blocks i3lock dmenu termite compton sysstat htop acpi lxappearance neofetch xclip xdotool libnotify dunst xwallpaper bc fzf tmux firefox dash

WORKDIR=$(pwd | sed 's/dotfiles.*/dotfiles/')
LOCAL="$HOME/.local"
CONFIG="$HOME/.config"

echo 'Creating folders...'
mkdir -vp $LOCAL/bin $LOCAL/share $LOCAL/src
mkdir -vp $CONFIG/i3 $CONFIG/termite $CONFIG/nvim $CONFIG/dunst $CONFIG/compton $CONFIG/i3blocks

echo 'Copying config files...'
cat /etc/X11/xinit/xinitrc | sed -e "/^xclock\|^twm\|xterm\|^$/d" > $HOME/.xinitrc
cat >> $HOME/.xinitrc << 'EOF'
eval $(/usr/bin/gnome-keyring/daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
exec i3
EOF

cp /etc/xdg/compton.conf $CONFIG/compton/compton.conf
cp $WORKDIR/configs/termite $CONFIG/termite/config
cp $WORKDIR/configs/dunstrc $CONFIG/dunst/dunstrc

# Installing bash config
echo 'Removing old bash config...'
rm -f $HOME/\.bash*

cp $WORKDIR/shell/profile $HOME/.profile && echo '~/.profile copied'
cp $WORKDIR/shell/bash/bashrc $HOME/.bashrc && echo '~/.bashrc copied'
cp $WORKDIR/shell/bash/aliases $HOME/.aliases && echo '~/.aliases copied'

# Installing nvim config
echo 'Installing nvim configs...'
cp $WORKDIR/vim/init.vim $CONFIG/nvim/init.vim
echo 'Installing vim-plug...'
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
mkdir -vp ~/.local/share/nvim/site/plugged
nvim +:PlugInstall +:qall

# symlink dash
sudo ln -sfT dash /usr/bin/sh

# Install pacman hook
cat > 110-dash-symlink.hook << EOF
[Trigger]
Type = Package
Operation = Install
Operation = Upgrade
Target = bash

[Action]
Description = Re-pointing /bin/sh symlink to dash...
When = PostTransaction
Exec = /usr/bin/ln -sfT dash /usr/bin/sh
Depends = dash
EOF

# Install i3
echo 'Installing i3 config...'
cp $WORKDIR/i3/config $CONFIG/i3/config
cp $WORKDIR/i3/i3blocks/* $CONFIG/i3blocks/

# Install scripts
echo 'Installing scripts...'
cp $WORKDIR/scripts/* $LOCAL/bin/ 2> /dev/null
cp $WORKDIR/scripts/res/* $LOCAL/share/
