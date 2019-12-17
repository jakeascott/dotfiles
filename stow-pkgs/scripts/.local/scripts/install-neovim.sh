#!/bin/bash

DIR=$(pwd | sed 's/dotfiles.\+/dotfiles/g')

# Install vim config
echo 'Installing init.vim'
[ ! -d ~/.config/nvim ] && mkdir -vp ~/.config/nvim
ln -sf $DIR/config/nvim/init.vim ~/.config/nvim/init.vim && echo 'vimrc simlinked'

# Get vim-plug
echo 'Installing vim-plug'
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
mkdir -vp ~/.local/share/nvim/site/plugged

# Install plugins
nvim +:PlugInstall +:qall

echo 'Done.'
