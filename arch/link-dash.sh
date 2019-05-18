#!/bin/bash

sudo pacman -S --no-confirm dash

sudo ln -sfT dash /usr/bin/sh

# Install pacman hook
cat > 110-dash-symlink.hook << EOF
[Trigger]
Type = Package
Operation = Install
Operation = Upgrade
Target = bash

[Action]
Description = Re-pointing /bin/sh symlink to dash...
When = PostTransaction
Exec = /usr/bin/ln -sfT dash /usr/bin/sh
Depends = dash
