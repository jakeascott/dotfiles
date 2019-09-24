#!/bin/bash

# setting to help script fail loudly
set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND; exit $s' ERR

echo -n "Use large font? [y/N] "
read large_font
if [[ ${large_font,,} == "y" ]] ; then
    setfont latarcyrheb-sun32
fi

# Check for EFI
if [[ $(ls /sys/firmware/efi/efivars 2> /dev/null | wc -l) -eq 0 ]] ; then
    echo "No EFI detected. This script is for EFI systems only."
    exit 1
fi

# Get user parameters
echo -n "Enter hostname: "
read hostname
: ${hostname:?'hostname cannot be empty'}

echo -n "Enter admin username: "
read username
: ${username:?'username cannot be empty'}

echo -n "Enter admin password: "
read -s password
: ${password:?'password cannot be empty'}
echo
echo -n "Enter admin password again: "
read -s password2
echo
if [[ "$password" == "$password2" ]] ; then
    echo "Passwords did not match"
    exit 1
fi

devicelist=$(lsblk -dplnx size -o name,size | grep -Ev "boot|rpmb|loop" | tac)
device=$(dialog --stdout --menu "Select installation disk" 0 0 0 ${devicelist}) || exit 1
clear

# calculated size of swap partition
swap_size=$(free --mebi | awk '/Mem:/ {print $2}')
swap_end=$(( $swap_size + 550 + 1))MiB

_message="
Installing arch on $device with
HOSTNAME: $hostname
USERNAME: $username

Drive $device with be wiped and the following partitions with be created...
BOOT: 550MB
SWAP: ${swap_size}MB
ROOT: Rest of Drive
"
echo "$_message"

echo -n "Do you wish to continue? [Y/n] "
read confirm
[[ ${confirm,,} == "n" ]] && exit 1

### Install Start ###

# partition drive
parted --script "${device}" mklabel gpt \
    mkpart ESP fat32 1Mib 551MiB \
    set 1 boot on \
    mkpart primary linux-swap 551MiB ${swap_end} \
    mkpart primary ext4 ${swap_end} 100%

part_boot="${device}1"
part_swap="${device}2"
part_root="${device}3"

echo "Partitions created..."
lsblk
echo "BOOT: $part_boot | SWAP: $part_swap | ROOT: $part_root"
echo -n "Continue with these partitions? [Y/n] "
read confirm2
[[ ${confirm2,,} == "n" ]] && exit 1

# set time and refresh keys
timedatectl set-ntp true
echo 'Refreshing keyring...'
pacman-key --refresh-keys

# start logging
exec &> >(tee "install.log")

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

# Install pacman-contrib and update mirrorlist
pacman -Q pacman-contrib &>/dev/null || sudo pacman -Syq --noconfirm pacman-contrib
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak

curl -s "https://www.archlinux.org/mirrorlist/?country=US&protocol=https&ip_version=4&ip_version=6&uuse_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^## U/d' | rankmirrors -n 5 - > /etc/pacman.d/mirrorlist

# begin arch install
pacstrap /mnt base base-devel intel-ucode
genfstab -U /mnt >> /mnt/etc/fstab

# set timezone and clock
ln -sf /mnt/usr/share/zoneinfo/America/Los_Angeles /mnt/etc/localtime
arch-chroot /mnt hwclock --systohc

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
options root=PARTUUID=$(blkid -s PARTUUID -o value "${part_root}") rw quiet
EOF

# Make pacman pretty
grep "^Color" /mnt/etc/pacman.conf > /dev/null || sed -i "s/^#Color/Color/" /mnt/etc/pacman.conf

# Disable the beep
arch-chroot /mnt rmmod pcspkr
echo "blacklist pcspkr" > /mnt/etc/modprobe.d/nobeep.conf

# Make large font permanent
if [[ ${large_font,,} == "y" ]] ; then
cat > /mnt/etc/vconsole.conf << EOF
FONT=latarcyrheb-sun32
FONT_MAP=8859-2
EOF
fi

# remove programs
arch-chroot /mnt pacman -R --noconfirm nano

# add admin user
arch-chroot /mnt useradd -mU -G wheel,uucp,video,audio,storage,games,input "$username"

# Change user and root passwords
echo "$username:$password" | arch-chroot /mnt chpasswd
echo "root:$password" | arch-chroot /mnt chpasswd

# Edit sudoers file to enable wheel group
sed -i 's/# %wheel ALL=(ALL) NO/%wheel ALL=(ALL) NO/' /mnt/etc/sudoers

# Disable root password
arch-chroot /mnt passwd -l root

# Exit info
echo
echo "Main install done. umount -R /mnt; reboot and remove iso"
