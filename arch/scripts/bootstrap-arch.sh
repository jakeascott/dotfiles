#!/bin/bash
# Run as normal user

echo 'Be sure to install appropriate graphics driver.'
sudo pacman -Sy --noconfirm xorg-server xorg-xinit xorg-apps pulseaudio pulseaudio-alsa pulsemixer ttf-dejavu otf-font-awesome otf-fira-code otf-fira-sans otf-fira-mono xdg-user-dirs sysstat htop acpi lxappearance xclip xdotool libnotify kitty dunst compton imagemagick feh bc firefox i3-gaps i3blocks

WORKDIR=$(pwd | sed 's/dotfiles.*/dotfiles/')
LOCAL="$HOME/.local"
CONFIG="$HOME/.config"

mkdir -pv $LOCAL
mkdir -pv $CONFIG 

echo 'Copying config files...'
cp $WORKDIR/shell/xinitrc $HOME/.xinitrc && echo '~/.xinitrc copied'

cp -r $WORKDIR/config/* $CONFIG/
cp -r $WORKDIR/local/*  $LOCAL/

sudo cp -r $WORKDIR/gtk-themes/my-gruvbox-gtk /usr/share/themes/
sudo cp -r $WORKDIR/gtk-themes/my-gruvbox-icons /usr/share/icons/

# Install bash config
echo 'Removing old bash config...'
rm -f $HOME/\.bash*

cp $WORKDIR/shell/profile $HOME/.profile && echo '~/.profile copied'
cp $WORKDIR/shell/bash/bashrc $HOME/.bashrc && echo '~/.bashrc copied'
cp $WORKDIR/shell/bash/aliases $HOME/.aliases && echo '~/.aliases copied'
sudo cp $WORKDIR/shell/bash/root-bashrc /root/.bashrc && echo '/root/.bashrc copied'

# Installing nvim config
echo 'Installing vim-plug...'
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
mkdir -vp ~/.local/share/nvim/site/plugged
nvim +:PlugInstall +:qall

xdg-user-dirs-update
systemctl --user daemon-reload
