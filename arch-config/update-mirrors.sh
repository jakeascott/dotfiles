#!/bin/bash
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
curl -s "https://www.archlinux.org/mirrorlist/?country=US&protocol=https&ip_version=4&use_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^## U/d' | rankmirrors -n 5 - > /etc/pacman.d/mirrorlist
