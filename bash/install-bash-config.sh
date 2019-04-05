#!/bin/bash

# Installs .profile .bashrc .vimrc and .config folder in /home/user/

cp profile $HOME/.profile
cp bashrc $HOME/.bashrc
[ ! -d $HOME/.config ] && mkdir $HOME/.config
cp -r config/bash $HOME/.config/

# Only works when run as root
cp root-profile /root/.profile
cp root-bashrc /root/.bashrc
