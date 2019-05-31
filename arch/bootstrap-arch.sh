#!/bin/bash
# Run as normal user

echo 'Be sure to install appropriate graphics driver.'
sudo pacman -S --noconfirm xorg-server xorg-xinit xorg-apps sxhkd pulseaudio pulseaudio-alsa pulsemixer ttf-dejavu otf-font-awesome sysstat htop acpi lxappearance neofetch xclip xdotool libnotify dunst compton termite feh imagemagick bc 

WORKDIR=$(pwd | sed 's/dotfiles.*/dotfiles/')
LOCAL="$HOME/.local"
CONFIG="$HOME/.config"

echo 'Creating folders...'
mkdir -vp $LOCAL/bin $LOCAL/share $LOCAL/src
mkdir -vp $CONFIG/nvim $CONFIG/dunst $CONFIG/compton $CONFIG/termite

echo 'Copying config files...'
cat /etc/X11/xinit/xinitrc | sed -e "/^xclock\|^twm\|xterm\|^$/d" > $HOME/.xinitrc
cat >> $HOME/.xinitrc << 'EOF'
eval $(/usr/bin/gnome-keyring/daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
EOF

cp /etc/xdg/compton.conf $CONFIG/compton/compton.conf
cp $WORKDIR/configs/termite $CONFIG/termite/config
cp $WORKDIR/configs/dunstrc $CONFIG/dunst/dunstrc

# Install bash config
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

# Install scripts
echo 'Installing scripts...'
cp $WORKDIR/scripts/bin/* $LOCAL/bin/
cp $WORKDIR/scripts/res/* $LOCAL/share/
