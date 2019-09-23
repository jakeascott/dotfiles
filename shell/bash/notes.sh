#!/bin/bash

# ${var,,} sets $var to lowercase

# Get user input via command line arg
# Check if command line arg exists (see bash parameter expansion for details)
arg="${1:?'Missing arg 1'}"


# Get user input via prompt
echo -n "Input: "

read input
#read -s password
# in bash : is the nop command
: "${input:?'Mising input'}"


echo $arg $input


# To hardcode partitions
#swap_size=$(free --mebi | awk '/Mem:/ {print $2}')
#swap_end=$(( $swap_size + 129 + 1))MiB

#parted --script "${device}" --mklabel gpt \
    #mkpart ESP fat32 1Mib 129MiB \
    #set 1 boot on \
    #mkpart primary linux-swap 129MiB ${swap_end} \
    #mkpart primary ext4 ${swap_end} 100%

# Dialog prompts
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

devicelist=$(lsblk -dplnx size -o name,size | grep -Ev "boot|rpmb|loop" | tac)
device=$(dialog --stdout --menu "Select installation disk" 0 0 0 ${devicelist}) || exit 1
clear
