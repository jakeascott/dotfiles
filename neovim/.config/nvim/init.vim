" ==========================================
"            _
"     __   _(_)_ __ ___  _ __ ___
"     \ \ / / | '_ ` _ \| '__/ __|
"  _   \ V /| | | | | | | | | (__
" (_)   \_/ |_|_| |_| |_|_|  \___|
"
" ==========================================

let mapleader = "\<space>"
let maplocalleader = "\<space>"

" Plugins ------------------------------------------------------------ {{{
" ----- Vim Plugged ----- "
call plug#begin('~/.local/share/nvim/site/plugged')
Plug 'vim-airline/vim-airline'
Plug 'ap/vim-css-color'
Plug 'voldikss/vim-floaterm'
Plug 'morhetz/gruvbox'
Plug 'arcticicestudio/nord-vim'
Plug 'dracula/vim',{'as':'dracula'}
Plug 'joshdick/onedark.vim'
Plug 'tjdevries/colorbuddy.nvim'
Plug 'ishan9299/modus-theme-vim'
call plug#end()
" }}}

" General Settings --------------------------------------------------- {{{
set mouse=a " Activate mouse
set number relativenumber " line numbers
set linebreak " wrap lines on 'word' boundaries
set scrolloff=3 " don't let cursor touch edge of viewport
set splitbelow splitright " vertical splits use right half of screen
set iskeyword+=- " treat dash separated words as one word object
set inccommand=nosplit " interactive find and replace preview
set breakindent " Indent wrapped lines up to the same level
set path+=** " Search down into subfolders

let g:netrw_banner=0 " Disable banner in netrw

" Tab settings
set expandtab " Expand tabs into spaces
set tabstop=4 " default to 4 spaces for hard tab
set softtabstop=4 " default to 4 spaces for soft tab
set shiftwidth=4 " for when <tab> is pressed at beginning of line

" Colorscheme
set termguicolors
set background=dark
colorscheme onedark
"colorscheme dracula
"colorscheme nord
"colorscheme gruvbox
"lua require('colorbuddy').colorscheme('modus-vivendi')

" Columns
"set colorcolumn=80
"highlight ColorColumn ctermbg=darkgray

" }}}

" General Shortcuts -------------------------------------------------- {{{
" Shortcut to edit vimrc
nnoremap <leader>ec :vsplit $MYVIMRC<cr>
nnoremap <leader>rc :source $MYVIMRC<cr>

" Naviage with guides
nnoremap <leader><Space> <esc>/<++><cr>"_c4l

" Toggle relative number
nnoremap <leader>n :set relativenumber!<cr>

" Toggle spell-check
nnoremap <leader>s :setlocal spell! spelllang=en_us<cr>

" Open terminal in new pane
"nnoremap <leader><cr> :sp<cr> :resize 10<cr> :term<cr> :set number!<cr> i
" }}}

" Global Abbreviations ----------------------------------------------- {{{
"iabbrev @@n Jake<space>Scott
"iabbrev @@ scottj@sou.edu

" Abbreviation to insert current date
iabbrev @@d <C-r>=strftime("%Y-%m-%d")<cr>
" }}}

" Normal mode mappings ----------------------------------------------- {{{
nnoremap <leader>d ^d$
nnoremap <leader>v viw
nnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>\ :vsp<cr>
nnoremap <leader>- :sp<cr>
nnoremap <leader>/ :nohlsearch<cr> :echo "Search cleared."<cr>
nnoremap <leader>* :%s/\<<c-r><c-w>\>//g<left><left>
nnoremap <c-u> viwU
nnoremap <tab> za
"nnoremap <c-cr> test
"nnoremap ; :
"nnoremap : ;
" }}}

" Insert mode mappings ----------------------------------------------- {{{
"inoremap jk <esc>
"inoremap <esc> <nop>
inoremap <c-u> <esc>viwUi
" }}}

" Visual mode mappings ----------------------------------------------- {{{
vnoremap <leader>" y`>a"<esc>`<i"<esc>
vnoremap <leader>' y`>a'<esc>`<i'<esc>
vnoremap <leader>( y`>a)<esc>`<i(<esc>
vnoremap <leader>{ y`>a}<esc>`<i{<esc>
vnoremap <leader>[ y`>a]<esc>`<i[<esc>
vnoremap <leader>< y`>a><esc>`<i<<esc>
vnoremap <leader>y "+y
vnoremap <leader>p "+p
" }}}

" Terminal mode mappings --------------------------------------------- {{{
tnoremap <esc> <c-\><c-n>
tnoremap <leader>q <c-\><c-n>:q<cr>
" }}}

" Operator-pending mappings ------------------------------------------ {{{
" pair with d, c, y, etc
onoremap p i(
onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F)vi(<cr>
onoremap an( :<c-u>normal! f(va(<cr>
onoremap al( :<c-u>normal! F)va(<cr>
onoremap fun :<c-u>normal! 0f(hviw<cr>
" }}}

" Quick window navigation -------------------------------------------- {{{
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
inoremap <c-h> <esc><c-w>h
inoremap <c-j> <esc><c-w>j
inoremap <c-k> <esc><c-w>k
inoremap <c-l> <esc><c-w>l
vnoremap <c-h> <esc><c-w>h
vnoremap <c-j> <esc><c-w>j
vnoremap <c-k> <esc><c-w>k
vnoremap <c-l> <esc><c-w>l
tnoremap <c-h> <c-\><c-n><c-w>h
tnoremap <c-j> <c-\><c-n><c-w>j
tnoremap <c-k> <c-\><c-n><c-w>k
tnoremap <c-l> <c-\><c-n><c-w>l
" }}}

" File templates -------------------------------------------- {{{
nnoremap \html :-1read ~/.local/share/nvim/skel/skel.html<cr><esc>:setfiletype html<cr>^3jf>a
nnoremap \python :-1read ~/.local/share/nvim/skel/skel.py<cr><esc>:setfiletype python<cr>^3j3f"i
nnoremap \c :-1read ~/.local/share/nvim/skel/skel.c<cr><esc>:setfiletype c<cr>
nnoremap \ch :-1read ~/.local/share/nvim/skel/skel.h<cr><esc>:setfiletype c<cr>
nnoremap \tex :-1read ~/.local/share/nvim/skel/skel.tex<cr><esc>:setfiletype tex<cr>^3jf{a
nnoremap \sh ggi#!/bin/sh<esc>:setfiletype sh<cr>a<cr><cr>
nnoremap \bash ggi#!/bin/bash<esc>:setfiletype sh<cr>a<cr><cr>
" }}}

" FileType settings -------------------------------------------------- {{{
" Global file settings ----------------------------------------------- {{{
augroup gobal
    autocmd!
    " Disable autocomment on newline
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
    " Automatically delete all trailing whitespace on save.
    autocmd BufWritePre * %s/\s\+$//e
augroup END
" }}}

" Vimscript file settings -------------------------------------------- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim nnoremap <buffer> <localleader>c I"<esc>
    autocmd FileType vim setlocal foldmethod=marker
augroup END

"augroup myvimrc
"    autocmd!
"    autocmd BufWritePost init.vim so $MYVIMRC
"augroup END
" }}}

" Ini file settings -------------------------------------------------- {{{
augroup filetype_ini
    autocmd!
    autocmd FileType dosini nnoremap <buffer> <localleader>c I;<esc>
augroup END
" }}}

" Sxhkd file settings -------------------------------------------------- {{{
augroup filetype_sxhkd
    autocmd!
    autocmd FileType sxhkd nnoremap <buffer> <localleader>c I#<esc>
    autocmd FileType sxhkd setlocal foldmethod=marker
augroup END
" }}}

" Shell script file settings ----------------------------------------- {{{
augroup filetype_sh
    autocmd!
    autocmd FileType sh nnoremap <buffer> <localleader>c I#<esc>
augroup END
" }}}

" Python file settings ----------------------------------------------- {{{
augroup filetype_python
    autocmd!
    autocmd FileType python nnoremap <buffer> <localleader>c I#<esc>
    autocmd FileType python iabbrev <buffer> iff if:<left>
    " For PEP 8 standards
    autocmd FileType python set tabstop=4
    autocmd FileType python set softtabstop=4
    autocmd FileType python set shiftwidth=4
    autocmd FileType python set textwidth=79
    autocmd FileType python set expandtab
    autocmd FileType python set autoindent
    autocmd FileType python set shiftround
    autocmd FileType python set fileformat=unix
augroup END
" }}}

" Haskell file settings ----------------------------------------------- {{{
augroup filetype_haskell
    autocmd!
    autocmd FileType haskell nnoremap <buffer> <localleader>c I--<esc>
    " For haskell style guide
    autocmd FileType haskell set textwidth=79
    autocmd FileType haskell set shiftwidth=4
    autocmd FileType haskell set tabstop=4
    autocmd FileType haskell set expandtab
    autocmd FileType haskell set softtabstop=4
    autocmd FileType haskell set shiftround
    autocmd FileType haskell set autoindent
augroup END
" }}}

" C file settings ---------------------------------------------------- {{{
augroup filetype_c
    autocmd!
    autocmd FileType c nnoremap <buffer> <localleader>c I//<esc>
    autocmd FileType c nnoremap <buffer> <localleader>z :!make<cr>
augroup END
" }}}

" Html file settings ------------------------------------------------- {{{
augroup filetype_html
    autocmd!
    autocmd FileType html nnoremap <buffer> <localleader>c I<!--<space><esc>A<space>--><esc>
    autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
    autocmd FileType html nnoremap <buffer> <localleader>h1 i<h1></h1><esc>F>a
    autocmd FileType html nnoremap <buffer> <localleader>li i<li></li><esc>F>a
    autocmd FileType html nnoremap <buffer> <localleader>ul i<ul></ul><esc>F>a<cr><esc>kf>a<cr>
augroup END
" }}}

" LaTex file settings ------------------------------------------------ {{{
augroup filetype_tex
    autocmd!
    autocmd FileType tex nnoremap <localleader>bf i\textbf{}<ESC>i
    autocmd FileType tex nnoremap <c-p> :w<cr>:!pdflatex %:p<cr>
    autocmd FileType tex nnoremap <c-b> :w<cr>:!biber %:p:r<cr>
augroup END
" }}}

" Markdown file settings ------------------------------------------------ {{{
augroup filetype_markdown
    autocmd!
    autocmd FileType markdown nnoremap <localleader>c :!pandoc -f markdown -t html -o <c-r>%<bs><bs><bs>.html <c-r>%<cr>
    autocmd FileType markdown nnoremap <localleader>i i**<esc>i
    autocmd FileType markdown vnoremap <localleader>i y`>a*<esc>`<i*<esc>
    autocmd FileType markdown nnoremap <localleader>b i****<esc>hi
    autocmd FileType markdown vnoremap <localleader>b y`>a**<esc>`<i**<esc>
augroup END
" }}}
" }}}

" Notes -------------------------------------------------------------- {{{
" ^n for autocomple selections
" ^x^n autocomplete just this file
" ^x^f autocomplete filenames
" ^x^] autocomplete tags
" ^P scroll back in list

" :read to imput file contents into file
" :-1read no extra line

" }}}
