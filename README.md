# dotfiles

Jake's scripts, dotfiles & notes.

## Managing dotfiles with GNU Stow
I now use stow to manage my dotfiles.
Stow is available in most distributions repositories as `stow`.
Configs are now organized into stow packages in the `stow-pkgs` directory.
To install the desired config simply run `stow -t ~ <pkg-name>`.
