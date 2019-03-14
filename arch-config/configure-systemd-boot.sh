#!/bin/bash

# Default configuration for systemd-boot, should work
# on most sytems
# run as root

[ -z "$1" ] && echo 'No root partition specified (e.g. /dev/sda1)' && exit 1

bootctl --path=/boot install
bootctl update

# Insert pacman hooks

mkdir -p /etc/pacman.d/hooks

cat > /etc/pacman.d/hooks/100-systemd-boot.hook << EOL
[Trigger]
Type = Package
Operation = Upgrade
Target = systemd

[Action]
Description = Updating systemd-boot
When = PostTransaction
Exec = /usr/bin/bootctl update
EOL

# Create boot loader config files

cat > /boot/loader/loader.conf << EOL
default arch
timeout 4
console-mode max
editor no
EOL

cat > /boot/loader/entries/arch.conf << EOL
title Arch Linux
linux /vmlinuz-linux
initrd /intel-ucode.img
initrd /initramfs-linux.img
options root=PARTUUID=`blkid -s PARTUUID -o value $1` rw
EOL

echo 'Done'
