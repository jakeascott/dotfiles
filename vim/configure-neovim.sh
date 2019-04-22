#!/bin/bash

[ ! -d ~/.config/nvim] && mkdir ~/.config/nvim 
cp vimrc ~/.config/nvim/init.vim
echo 'Installed ~/.config/nvim/init.vim'

echo 'Installing vim-plug'
# Get vim-plug
curl -fLo ~/.local/share/nvim/autoload/plug.vim --create-dirs 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
mkdir ~/.local/share/nvim/plugged

echo 'Done. Open nvim and run :PlugInstall to install plugins'
