#!/bin/sh

dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-up "['<Super>k']"
dconf write /org/gnome/desktop/wm/keybindings/switch-to-workspace-down "['<Super>j']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-up "['<Super><Shift>k']"
dconf write /org/gnome/desktop/wm/keybindings/move-to-workspace-down "['<Super><Shift>j']"

