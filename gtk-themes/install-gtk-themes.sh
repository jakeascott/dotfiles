#!/bin/sh

WORKDIR=$(find $HOME -name dotfiles)

sudo cp -r $WORKDIR/gtk-themes/jakes-gruvbox-gtk /usr/share/themes/
sudo cp -r $WORKDIR/gtk-themes/jakes-gruvbox-icons /usr/share/icons/

echo 'Copied GTK themes to /usr/share.'
