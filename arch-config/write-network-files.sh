#!/bin/bash

# Writes /etc/hostname and /etc/hosts files
# must run as root and takes 'hostname' as argument

[ -z "$1" ] && echo 'No hostname supplied' && exit 1

echo $1 > /etc/hostname

cat > /etc/hosts << EOL
127.0.0.1     localhost
::1           localhost
127.0.1.1     $1.localdomain $1
EOL
