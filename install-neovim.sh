#!/bin/sh

WORKDIR=$(find $HOME -name .dotfiles)

# Install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
mkdir -vp ~/.local/share/nvim/site/plugged

cd $WORKDIR
stow -vt ~ --no-folding neovim

nvim --headless +:PlugInstall +:qall
