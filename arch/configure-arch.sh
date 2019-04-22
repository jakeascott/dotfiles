#!/bin/bash

# Sets default lanbuage to English and makes network files
# must run as root and takes 'hostname' as argument

[ -z "$1" ] && echo 'No hostname supplied' && exit 1

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

cat > /etc/hosts << EOL
127.0.0.1     localhost
::1           localhost
127.0.1.1     $1.localdomain $1
EOL

cat /etc/hostname
cat /etc/hosts

# Make pacman pretty
grep "^Color" /etc/pacman.conf > /dev/null || sed -i "s/^#Color/Color/" /etc/pacman.conf

echo "Done"
