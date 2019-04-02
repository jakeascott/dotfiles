" Use Vim settings, rather than vi compatability
set nocompatible

" Vim Plug
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
call plug#end()


" ----- General Settings ----- "
set backspace=indent,eol,start " allow backspacing in insert mode
set number " line numbers
set ruler " show cursor position at all times
set showcmd " display incomplete commands
set incsearch " do incremental searching
set linebreak " wrap lines on 'word' boundaries
set scrolloff=3 " don't let cursor touch edge of viewport
set splitright " Vertical splits use right half of screen
set timeoutlen=100 " lower ^[ timeout
if exists('&breakindent')
    set breakindent " Indent wrapped lines up to the same level
endif

" Tab settings
set expandtab " Expand tabs into spaces
set tabstop=4 " default to 4 spaces for hard tab
set softtabstop=4 " default to 4 spaces for soft tab
set shiftwidth=4 " for when <tab> is pressed at beginning of line

set hlsearch

syntax on

set mouse=a " activate mouse click, scroll, highlight, etc.

set background=dark
colorscheme gruvbox
