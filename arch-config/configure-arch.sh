#!/bin/bash

# Writes /etc/hostname and /etc/hosts files
# must run as root and takes 'hostname' as argument

[ -z "$1" ] && echo 'No hostname supplied' && exit 1

# Timezone and clock set
echo 'Setting timezone to Los_Angeles...'
ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
hwclock --systohc

# Set language
# NEED TO UNCOMMENT 'en_US.UTF-8' IN /etc/locale.gen FIRST
echo 'Setting language to en_US.UTF-8...'
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# Network setup
echo "Writing network files with hostname $1..."
echo $1 > /etc/hostname

cat > /etc/hosts << EOL
127.0.0.1     localhost
::1           localhost
127.0.1.1     $1.localdomain $1
EOL

echo 'Done'
