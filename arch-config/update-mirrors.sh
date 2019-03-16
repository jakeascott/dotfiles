#!/bin/bash

# run as root
# Grabs top 5 arch mirrors from and puts them in /etc/pacman.d/mirrorlist

cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak

curl -s "https://www.archlinux.org/mirrorlist/?country=US&protocol=https&ip_version=4&use_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^## U/d' | rankmirrors -n 5 - > /etc/pacman.d/mirrorlist

pacman -Syy

echo 'pacman mirrorlist updated'
cat /etc/pacman.d/mirrorlist
