" ==========================================
"           _
"    __   _(_)_ __ ___  _ __ ___
"    \ \ / / | '_ ` _ \| '__/ __|
" _   \ V /| | | | | | | | | (__
"(_)   \_/ |_|_| |_| |_|_|  \___|
"
" ==========================================

let mapleader = "\<space>"
let maplocalleader = "\<space>"

" Plugins ------------------------------------------------------------ {{{
" ----- Vim Plugged ----- "
call plug#begin('~/.local/share/nvim/site/plugged')
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
" Plug 'kassio/neoterm'
" vim-test
" deoplete.nvim | nvim-completion-manager | asyncomplete | webcomplete
" LanguageClient-neovim
" ALE
call plug#end()
" }}}

" Colorscheme -------------------------------------------------------- {{{
set background=dark
colorscheme gruvbox
" }}}

" General Settings --------------------------------------------------- {{{
set mouse=a " Activate mouse
set number relativenumber " line numbers
set linebreak " wrap lines on 'word' boundaries
set scrolloff=3 " don't let cursor touch edge of viewport
set splitbelow splitright " vertical splits use right half of screen
set iskeyword+=- " treat dash separated words as one word object
set inccommand=nosplit " interactive find and replace preview
set ignorecase smartcase " Regex ignores case if query is lowercase
if exists('&breakindent')
    set breakindent " Indent wrapped lines up to the same level
endif

" Tab settings
set expandtab " Expand tabs into spaces
set tabstop=4 " default to 4 spaces for hard tab
set softtabstop=4 " default to 4 spaces for soft tab
set shiftwidth=4 " for when <tab> is pressed at beginning of line
" }}}

" General Shortcuts -------------------------------------------------- {{{
" Shortcut to edit vimrc
nnoremap <leader>vrc :vsplit $MYVIMRC<cr>
nnoremap <leader>svrc :source $MYVIMRC<cr>

" Naviage with guides
nnoremap <leader><Space> <esc>/<++><cr>"_c4l

" Toggle relative number
nnoremap <leader>n :set relativenumber!<cr>

" Toggle spell-check
nnoremap <leader>s :setlocal spell! spelllang=en_us<cr>

" Open terminal in new pane
nnoremap <leader><cr> :sp<cr> :resize 10<cr> :term<cr> :set number!<cr> i
" }}}

" Global Abbreviations ----------------------------------------------- {{{
iabbrev @@n Jake<space>Scott
iabbrev @@ scottj@sou.edu
" }}}

" Normal mode mappings ----------------------------------------------- {{{
nnoremap H ^
nnoremap L $
nnoremap <leader>d ^d$
nnoremap <leader>v viw
nnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>\ :vsp<cr>
nnoremap <leader>- :sp<cr>
nnoremap <leader>/ :nohlsearch<cr> :echo "Search cleared."<cr>
nnoremap <c-u> viwU
nnoremap <tab> za
" }}}

" Insert mode mappings ----------------------------------------------- {{{
"inoremap jk <esc>
"inoremap <esc> <nop>
inoremap <c-u> <esc>viwUi
" }}}

" Visual mode mappings ----------------------------------------------- {{{
vnoremap H ^
vnoremap L $
vnoremap <leader>" y`<i"<esc>`>a"<esc>
vnoremap <leader>' y`<i'<esc>`>a'<esc>
vnoremap <leader>( y`<i(<esc>`>a)<esc>
vnoremap <leader>{ y`<i{<esc>`>a}<esc>
vnoremap <leader>[ y`<i[<esc>`>a]<esc>
vnoremap <leader>< y`<i<<esc>`>a><esc>
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
nnoremap <a-h> <c-w>h
nnoremap <a-j> <c-w>j
nnoremap <a-k> <c-w>k
nnoremap <a-l> <c-w>l
inoremap <a-h> <esc><c-w>h
inoremap <a-j> <esc><c-w>j
inoremap <a-k> <esc><c-w>k
inoremap <a-l> <esc><c-w>l
vnoremap <a-h> <esc><c-w>h
vnoremap <a-j> <esc><c-w>j
vnoremap <a-k> <esc><c-w>k
vnoremap <a-l> <esc><c-w>l
tnoremap <a-h> <c-\><c-n><c-w>h
tnoremap <a-j> <c-\><c-n><c-w>j
tnoremap <a-k> <c-\><c-n><c-w>k
tnoremap <a-l> <c-\><c-n><c-w>l
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
" }}}

" Python file settings ----------------------------------------------- {{{
augroup filetype_python
    autocmd!
    autocmd FileType python nnoremap <buffer> <localleader>c I#<esc>
    autocmd FileType python iabbrev <buffer> iff if:<left>
augroup END
" }}}

" C file settings ---------------------------------------------------- {{{
augroup filetype_c
    autocmd!
    autocmd FileType c nnoremap <buffer> <localleader>c I//<esc>
augroup END
" }}}

" Shell script file settings ----------------------------------------- {{{
augroup filetype_sh
    autocmd!
    autocmd FileType sh nnoremap <buffer> <localleader>c I#<esc>
augroup END
" }}}

" Html file settings ------------------------------------------------- {{{
augroup filetype_html
    autocmd!
    autocmd FileType html nnoremap <buffer> <localleader>f Vatzf
augroup END
" }}}

" LaTex file settings ------------------------------------------------ {{{
"augroup filetype_tex
"autocmd FileType tex nnoremap ,bf \textbf{}<ESC>?\\{<Enter>a
"augroup END
" }}}
" }}}

" Other stuff -------------------------------------------------------- {{{
onoremap ih :<c-u>execute "normal! ?^==\\+$\r:nohlsearch\rkvg_"<cr>
" }}}
