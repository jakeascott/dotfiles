#!/bin/bash
# Run as normal user

echo 'Be sure to install appropriate graphics driver.'
sudo pacman -Sy --noconfirm i3-gaps i3blocks i3lock

WORKDIR=$(pwd | sed 's/dotfiles.*/dotfiles/')
LOCAL="$HOME/.local"
CONFIG="$HOME/.config"

# Install configs
echo 'Installing i3 configs...'
mkdir -vp $CONFIG/i3
cp $WORKDIR/i3/config $CONFIG/config
cp -r $WORKDIR/i3/i3blocks $CONFG/
