#!/bin/bash

check_deps () {
    deps=(emacs git ripgrep fd-find ShellCheck pandoc)

    echo "Checking dependencies..."

    for x in ${deps[*]}; do
        dnf list --installed $dep >/dev/null 2>&1 \
            || (echo "Installing $dep..." && sudo dnf install $dep -y)
    done
}

check_deps

if [ -d $HOME/.emacs.d ] ; then
    echo "Existing ~/.emacs.d detected. Skipping Doom install."
else
    git clone https://github.com/hlissner/doom-emacs $HOME/.emacs.d \
    && $HOME/.emacs.d/bin/doom install
fi
