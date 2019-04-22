#!/bin/bash

# Generate
ssh-keygen -t rsa -b 4096 -C "scottj1123@gmail.com"

# Add to ssh-agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

# copy key to clipboard
clip < ~/.ssh/id_rsa.pub
