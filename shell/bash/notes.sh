#!/bin/bash

# Get user input via command line arg
# Check if command line arg exists (see bash parameter expansion for details)
arg="${1:?'Missing arg 1'}"


# Get user input via prompt
echo -n "Input: "

read input
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
