#!/bin/bash

START=$(pwd)

cd $HOME/.local/src
git clone 'https://aur.archlinux.org/yay.git'
cd yay && makepkg -si

cd $START
