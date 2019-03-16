#!/bin/bash

# Default configuration for syslinux
# Must have /boot as boot location
# root partion must be set as bootable
# run as root

[ -z "$1" ] && echo 'Root partition not specified (e.g. /dev/sda1)' && exit 1

echo 'Installing syslinux...'
pacman -S syslinux gptfdisk
syslinux-install_update -i -a -m

cat > /boot/syslinux/syslinux.cfg << EOL
PROMPT 0
TIMEOUT 50
DEFAULT arch

LABEL arch
    LINUX ../vmlinuz-linux
    APPEND root=$1 rw
    INITRD ../intel-ucode.img,../initramfs-linux.img

LABEL archfallback
    LINUX ../vmlinuz-linux
    APPEND root=$1 rw
    INITRD ../intel-ucode.img,../initramfs-linux-fallback.img
EOL

echo 'Installed /boot/syslinux/syslinux.cfg'
echo 'Done'
