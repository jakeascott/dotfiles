#!/bin/bash
# Run this after clean arch install to get default setup
# Run as normal user
set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND; exit $s' ERR
# Ensure arch is up-to-date
sudo pacman -Syu

if [[ $(pacman -Qs xf86-video | wc -l) -eq 0 ]]; then
    echo "No Xorg graphics drivers detected"
    echo "Install appropriate graphics driver for: "
    echo "$(lspci | grep -e VGA -e 3d)"
    echo -e "\nAvailable Drivers..."
    echo "$(pacman -Ss xf86-video | grep 'xf86' | sed 's/.*\///' | awk '{print $1}')"
    exit 1
fi

sudo pacman -S --noconfirm pacman-contrib xorg-server xorg-xinit xorg-apps
    pulseaudio pulseaudio-alsa pulsemixer ttf-dejavu otf-font-awesome \
    xdg-user-dirs sysstat htop acpi lxappearance xclip xdotool libnotify \
    termite dunst picom imagemagick sxiv bc firefox

WORKDIR=$(find $HOME -name dotfiles)
[ ! -d $WORKDIR ] && echo "No dotfiles found. Aborting config install." && exit 1
LOCAL="$HOME/.local"
SOURCE="$HOME/.local/src"
CONFIG="$HOME/.config"
CACHE="$HOME/.cache"

# Install yay
$WORKDIR/arch/scripts/install-yay.sh

# Install dash
sudo $WORKDIR/arch/scripts/link-dash.sh

# Copy configs into local directories
mkdir -pv $LOCAL $CONFIG $CACHE $SOURCE
cp -r $WORKDIR/config/* $CONFIG/
cp -r $WORKDIR/local/*  $LOCAL/

# Install GTK themes
sudo cp -r $WORKDIR/gtk-themes/my-gruvbox-gtk /usr/share/themes/
sudo cp -r $WORKDIR/gtk-themes/my-gruvbox-icons /usr/share/icons/

# Install bash config
rm -f $HOME/\.bash*

ln -sf $WORKDIR/shell/profile $HOME/.profile
ln -sf $WORKDIR/shell/bash/bashrc $HOME/.bashrc
ln -sf $WORKDIR/shell/bash/aliases $HOME/.aliases
sudo ln -sf $WORKDIR/shell/bash/root-bashrc /root/.bashrc
echo "Bash config simlinked."

# Install xinitrc
cp $WORKDIR/shell/xinitrc $HOME/.xinitrc && echo "~/.xinitrc installed"

# XDG Directories
mkdir -vp $HOME/Projects $HOME/Downloads $HOME/Repositories $HOME/Shared \
    $HOME/Documents $HOME/Music $HOME/Pictures $HOME/Videos
xdg-user-dirs-update

# neovim config
echo 'Installing nvim configs...'
[ ! -d $CONFIG/nvim ] && mkdir -vp $CONFIG/nvim
ln -sf $WORKDIR/config/nvim/init.vim $CONFIG/nvim/init.vim && echo 'init.vim simlinked'

echo "Installing vim-plug..."
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
mkdir -vp ~/.local/share/nvim/site/plugged
nvim --headless +:PlugInstall +:qall
