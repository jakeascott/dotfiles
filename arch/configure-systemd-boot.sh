#!/bin/bash

# Default configuration for systemd-boot
# ESP must be /boot
# run as root

[ -z "$1" ] && echo 'Root partition not specified (e.g. /dev/sda1)' && exit 1

bootctl --path=/boot install
bootctl update

# Insert pacman hooks
echo "Inserting pacman hooks..."

mkdir -p /etc/pacman.d/hooks

cat > /etc/pacman.d/hooks/100-systemd-boot.hook << EOF
[Trigger]
Type = Package
Operation = Upgrade
Target = systemd

[Action]
Description = Updating systemd-boot
When = PostTransaction
Exec = /usr/bin/bootctl update
EOF

# Create boot loader config files
echo 'Installing boot loader config files...'
cat > /boot/loader/loader.conf << EOF
default arch
timeout 4
console-mode max
editor no
EOF
echo '/boot/loader/loader.conf installed'

cat > /boot/loader/entries/arch.conf << EOF
title Arch Linux
linux /vmlinuz-linux
initrd /intel-ucode.img
initrd /initramfs-linux.img
options root=PARTUUID=`blkid -s PARTUUID -o value $1` rw
EOF
echo '/boot/loader/entries/arch.conf installed'

cat > /boot/loader/entries/arch-lts.conf << EOF
title Arch Linux LTS
linux /vmlinuz-linux-lts
initrd /intel-ucode.img
initrd /initramfs-linux-lts.img
options root=PARTUUID=`blkid -s PARTUUID -o value $1` rw
EOF
echo '/boot/loader/entries/arch-lts.conf installed'

echo 'Done'
