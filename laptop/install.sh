#!/bin/sh

stow -vnt "${HOME}" --no-folding stow-package

# Install vim-plug
curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
mkdir -vp $HOME/.local/share/nvim/site/plugged

nvim --headless +:PlugInstall +:qall

