#!/bin/sh

# Installs .profile .bashrc .aliases
echo 'Removing old bash config...'
rm -f $HOME/\.bash*

cp profile $HOME/.profile && echo '~/.profile copied'
cp bash/bashrc $HOME/.bashrc && echo '~/.bashrc copied'
cp bash/aliases $HOME/.aliases && echo '~/.aliases copied'
