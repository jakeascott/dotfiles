#!/bin/bash

# setting to help script fail loudly
set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND; exit $s' ERR

# Check for EFI
[[ $(ls /sys/firmware/efi/efivars | wc -l) -gt 0 ]] || ( echo "No EFI detected. This script is for EFI systems only."; exit 1; )

# Get user parameters
hostname=$(dialog --stdout --inputbox "Enter hostname" 0 0) || exit 1
clear
: ${hostname:?'hostname cannot be empty'}

username=$(dialog --stdout --inputbox "Enter admin username" 0 0) || exit 1
clear
: ${username:?'username cannot be empty'}

password=$(dialog --stdout --passwordbox "Enter admin password" 0 0) || exit 1
clear
: ${password:?'password cannot be empty'}
password2=$(dialog --stdout --passwordbox "Enter admin password agian" 0 0)
clear
[[ "$password" == "$password2" ]] || ( echo "Passwords did not match"; exit 1; )

### Install Start ###

devicelist=$(lsblk -dplnx size -o name,size | grep -Ev "boot|rpmb|loop" | tac)
device=$(dialog --stdout --menu "Select installation disk" 0 0 0 ${devicelist}) || exit 1
clear

# start logging
exec $> >(tee "install.log")

timedatectl set-ntp true

# put user into fdisk
fdisk "${device}"

# allow user to assign partitions
part_list=$(lsblk -pnx name | grep -E "$device.+part" | awk '{print $1, $4}')
part_boot=$(dialog --stdout --menu "Select boot partition" 0 0 0 ${part_list})
clear
part_list=$(echo "$part_list" | grep -v "$part_boot")
part_root=$(dialog --stdout --menu "Select root partition" 0 0 0 ${part_list})
clear
part_list=$(echo "$part_list" | grep -v "$part_root")
part_swap=$(dialog --stdout --menu "Select swap partition" 0 0 0 ${part_list})

# format partitions
wipefs "${part_boot}"
wipefs "${part_root}"
wipefs "${part_swap}"

mkfs.fat -F32 "${part_boot}"
mkswap "${part_swap}"
mkfs.ext4 "${part_root}"

swapon "${part_swap}"
mount "${part_root}" /mnt
mkdir /mnt/boot
mount "${part_boot}" /mnt/boot

# begin arch install
pacstrap /mnt base base-devel
genfstab -U /mnt >> /mnt/etc/fstab

# set timezone and clock
ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
hwclock --systohc
date

# Set language
sed -i 's/#en_US.UTF-8/en_US.UTF-8/' /mnt/etc/locale.gen
arch-chroot /mnt locale-gen
echo 'LANG=en_US.UTF-8' > /mnt/etc/locale.conf

# Network setup
echo "${hostname}" > /mnt/etc/hostname

cat > /mnt/etc/hosts << EOF
127.0.0.1     localhost
::1           localhost
127.0.1.1     ${hostname}.localdomain ${hostname}
EOF

# Configure systemd-boot
arch-chroot /mnt bootctl --path=/boot install
arch-chroot /mnt bootctl update

mkdir -p /mnt/etc/pacman.d/hooks
cat > /mnt/etc/pacman.d/hooks/100-systemd-boot.hook << EOF
[Trigger]
Type = Package
Operation = Upgrade
Target = systemd

[Action]
Description = Updating systemd-boot.
When = PostTransaction
Exec = /usr/bin/bootctl update
EOF

# Create systemd-boot config files
cat > /mnt/boot/loader/loader.conf << EOF
default arch
timeout 0
console-mode max
editor no
EOF

cat > /mnt/boot/loader/entries/arch.conf << EOF
title Arch Linux
linux /vmlinuz-linux
initrd /intel-ucode.img
initrd /initramfs-linux.img
options root=PARTUUID=$(blkid -s PARTUUID -o value "$part_root") rw quiet
EOF

# Make pacman pretty
grep "^Color" /mnt/etc/pacman.conf > /dev/null || sed -i "s/^#Color/Color/" /mnt/etc/pacman.conf

# Disable the beep
arch-chroot /mnt rmmod pcspkr
echo "blacklist pcspkr" > /mnt/etc/modprobe.d/nobeep.conf

# Make default tty font bigger
cat > /mnt/etc/vconsole.conf << EOF
FONT=latarcyrheb-sun32
FONT_MAP=8859-2
EOF

# remove programs
arch-chroot /mnt pacman -R --noconfirm nano

# add admin user
arch-chroot /mnt useradd -mU -G wheel,uucp,video,audio,storage,games,input "$username"

echo "$username:$password" | chpasswd --root /mnt
echo "root:$password" | chpasswd --root /mnt

# Exit info
echo "Main install done. Edit sudoers with visudo, disable root password passwd -l root"
echo "umount -R /mnt; reboot and remove iso"
