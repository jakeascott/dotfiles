# Installing dotfile packages

These packages are organized to be used with GNU Stow.

To Install config for a package, run:
`stow -t ~ <package-name>`


## Neovim
Vim-plug's method of storing packages causes problems when stow simlinks the toplevel directories.
Use the `install-neovim.sh` script to avoid problems.
