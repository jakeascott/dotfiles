gnome-software-packagekit-plugin

Online Accounts:
telepathy
gvfs-goa

gnome-tweaks
dconf
gnome-shell-extensions


## Hide apps from menu
copy desktop files from `/usr/share/applications` to
`~/.local/share/applications` and add `NoDisplay=true`
to the **.desktop** files


## Gnome Terminal
* Change colors: `bash -c  "$(wget -qO- https://git.io/vQgMr)"`
* May need `dconf-cli` and `uuid-runtime`


## GTK Themes
* Themes are saved in `/usr/share/themes`
* Icons saved in `/usr/share/icons`
