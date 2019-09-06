" ==========================================
"           _
"    __   _(_)_ __ ___  _ __ ___
"    \ \ / / | '_ ` _ \| '__/ __|
" _   \ V /| | | | | | | | | (__
"(_)   \_/ |_|_| |_| |_|_|  \___|
"
" ==========================================

let mapleader = "\<space>"
let maplocalleader = "\\"
set mouse=a " Activate mouse

" ----- Vim Plugged ----- "
call plug#begin('~/.local/share/nvim/site/plugged')
Plug 'morhetz/gruvbox'
" Plug 'kassio/neoterm'
" vim-test
" deoplete.nvim | nvim-completion-manager | asyncomplete | webcomplete
" LanguageClient-neovim
" ALE
call plug#end()

" ----- General Settings ----- "
set number " line numbers
set linebreak " wrap lines on 'word' boundaries
set scrolloff=3 " don't let cursor touch edge of viewport
set splitbelow splitright " vertical splits use right half of screen
set iskeyword+=- " treat dash separated words as one word object
set inccommand=nosplit " interactive find and replace preview
if exists('&breakindent')
    set breakindent " Indent wrapped lines up to the same level
endif

" Tab settings
set expandtab " Expand tabs into spaces
set tabstop=4 " default to 4 spaces for hard tab
set softtabstop=4 " default to 4 spaces for soft tab
set shiftwidth=4 " for when <tab> is pressed at beginning of line

" Set colorscheme
set background=dark
colorscheme gruvbox
highlight Search ctermbg=LightGreen ctermfg=0
highlight IncSearch ctermbg=LightGreen ctermfg=0

" Shortcut to edit vimrc
nnoremap <leader>vrc :vsplit $MYVIMRC<CR>
nnoremap <leader>svrc :source $MYVIMRC<CR>

" Naviage with guides
nnoremap <leader><Space> <Esc>/<++><CR>"_c4l

" Disable autocomment on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Automatically delete all trailing whitespace on save.
autocmd BufWritePre * %s/\s\+$//e

" Toggle relative number
nnoremap <leader>n :set relativenumber!<CR>

" Toggle spell-check
nnoremap <leader>s :setlocal spell! spelllang=en_us<CR>

" Open terminal in new pane
nnoremap <leader><CR> :sp<CR> :resize 10<CR> :term<CR> :set number!<CR> i

" Abbreviations
iabbrev @@n Jake<space>Scott
iabbrev @@ scottj@sou.edu

" Normal mode mappings
nnoremap H ^
nnoremap L $
nnoremap <leader>d ^d$
nnoremap <leader>v viw
nnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>\ :vsp
nnoremap <leader>- :sp
nnoremap <leader>/ :nohlsearch<CR>
nnoremap <C-u> viwU

" Insert mode mappings
"inoremap jk <esc>
"inoremap <esc> <nop>
inoremap <C-u> <esc>viwUi

" Visual mode mappings
vnoremap H ^
vnoremap L $
vnoremap <leader>" y`<i"<esc>`>a"<esc>

" Terminal mode mappings
tnoremap <Esc> <C-\><C-n>
tnoremap <leader>q <C-\><C-n>:q<CR>

" Quick window navigation
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
inoremap <A-h> <Esc><C-w>h
inoremap <A-j> <Esc><C-w>j
inoremap <A-k> <Esc><C-w>k
inoremap <A-l> <Esc><C-w>l
vnoremap <A-h> <Esc><C-w>h
vnoremap <A-j> <Esc><C-w>j
vnoremap <A-k> <Esc><C-w>k
vnoremap <A-l> <Esc><C-w>l
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l

" LaTeX
"autocmd FileType tex nnoremap ,bf \textbf{}<ESC>?\\{<Enter>a
