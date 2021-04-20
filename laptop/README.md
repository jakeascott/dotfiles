# Laptop: Suckless Debian

Procede with a minimal debian install, with Secure Boot on and Full Disk encryption.

Wifi card needs proprietary drivers so make sure to use the unofficial install media or have a wired conneciton.

## Console Font

My laptop has a hidpi screen so the console fonts are tiny. I've found `Lat15-Terminus32x16` to be comfortable.

List available fonts with `ls /usr/share/consolefonts`. You can make this persistent by modifying `sudo dpkg-reconfigure console-setup` or edit `/etc/default/console-setup`

## Add contrib, non-free, and backports

Edit `/etc/apt/sources.list`

```
# Base repository
deb https://deb.debian.org/debian/ buster main contrib non-free
deb-src https://deb.debian.org/debian/ buster main contrib non-free

# Security updates
deb https://security.debian.org/debian-security buster/updates main contrib non-free
deb-src https://security.debian.org/debian-security buster/updates main contrib non-free

# Stable updates
deb https://deb.debian.org/debian buster-updates main contrib non-free
deb-src https://deb.debian.org/debian buster-updates main contrib non-free

# Stable backports
deb https://deb.debian.org/debian buster-backports main contrib non-free
deb-src https://deb.debian.org/debian buster-backports main contrib non-free
```

## Activate Wifi

The Intel wireless card in my laptop needs proprietary drivers. Add the non-free repost to sources.list and install `firmware-iwlwifi`. Then run `modprob -r iwlwifi ; modprobe iwlwifi`. I like to also install `network-manager` for managing network connections.

Connect to wifi with `nmcli dev wifi conn <wifi-name> password <wifi-password>`

## Activate TRIM and install microcode

`sudo systemctl enable fstrim.timer`

install `intel-microcode`

## Install some basics

Install `git`, `curl`, `neovim`, `stow`, `tmux`, `build-essential`, `fish`, `lm-sensors`

> `chsh -s /usr/bin/fish`

## Xorg

install `xorg`

clone `github.com:jakesco/dwm.git`, `github.com:jakesco/st.git`, `github.com:jakesco/dmenu.git` to `~/.local/src`

These require `libx11-dev`, `libxft-dev`, and `libxinerama-dev`. `make` and `sudo make clean install` for each.

## Resources
- [dpkg cheatsheet](https://www.cyberciti.biz/howto/question/linux/dpkg-cheat-sheet.php)
- [wifi](https://wiki.debian.org/iwlwifi)
- [install guide](https://www.dwarmstrong.org/minimal-debian/)
- [after install](https://gitlab.com/dwarmstrong/debian-after-install/-/blob/master/debian-after-install.sh)
