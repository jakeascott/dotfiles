" ==========================================
"           _                    
"    __   _(_)_ __ ___  _ __ ___ 
"    \ \ / / | '_ ` _ \| '__/ __|
" _   \ V /| | | | | | | | | (__ 
"(_)   \_/ |_|_| |_| |_|_|  \___|
"
" ========================================== 

" Use Vim settings, rather than vi compatability
set nocompatible

" ----- Vim Plugged ----- " 
call plug#begin('~/.local/share/nvim/site/plugged')
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
set splitbelow splitright " splits use right/bottom half of screen
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

" Statusline
set laststatus=2
"set statusline=

" Set colorscheme
set background=dark
"colorscheme gruvbox

" Set colorscheme
set background=dark
colorscheme gruvbox

" Save buffer shortcut 
nnoremap <leader>w :w<cr>

" Clipboard shortcuts
nnoremap <Leader>y "*y
nnoremap <Leader>p "*p
nnoremap <Leader>Y "+y
nnoremap <Leader>P "+p

" Autoclose tags
inoremap ( ()<Left>
inoremap { {}<Left>
inoremap [ []<Left>
