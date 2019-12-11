#!/bin/sh

WORKDIR=$(find $HOME -name stow-pkgs)

# Install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
mkdir -vp ~/.local/share/nvim/site/plugged

cd $WORKDIR
stow -t ~ neovim

nvim --headless +:PlugInstall +:qall
