#!/bin/sh
# must run as root and takes 'hostname' as argument

[ -z "$1" ] && echo 'Usage: configure-arch.sh HOSTNAME USERNAME' && exit 1
[ -z "$2" ] && echo 'Usage: configure-arch.sh HOSTNAME USERNAME' && exit 1

# Timezone and clock set
echo "Setting timezone to Los_Angeles..."
ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
hwclock --systohc
date

# Set language
echo "Setting language to en_US.UTF-8..."
sed -i 's/#en_US.UTF-8/en_US.UTF-8/' /etc/locale.gen
locale-gen
echo 'LANG=en_US.UTF-8' > /etc/locale.conf

# Network setup
echo "Writing network files with hostname $1..."
echo $1 > /etc/hostname

cat > /etc/hosts << EOF
127.0.0.1     localhost
::1           localhost
127.0.1.1     $1.localdomain $1
EOF

cat /etc/hostname
cat /etc/hosts

# Make pacman pretty
grep "^Color" /etc/pacman.conf > /dev/null || sed -i "s/^#Color/Color/" /etc/pacman.conf

# Disable the beep
rmmod pcspkr
echo "blacklist pcspkr" > /etc/modprobe.d/nobeep.conf

# Add/remove programs
pacman -R --noconfirm nano

# Add user
echo "Enter ROOT password..."
passwd
useradd -m -g users -G wheel $2
echo "Enter USER password..."
passwd $2

echo "Done."
