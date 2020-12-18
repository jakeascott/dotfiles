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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
"colorscheme onedark
"colorscheme dracula
"colorscheme nord
"colorscheme gruvbox
lua require('colorbuddy').colorscheme('modus-vivendi')

" Columns
"set colorcolumn=80
"highlight ColorColumn ctermbg=darkgray

" }}}

" COC Settings --------------------------------------------------- {{{
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
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
"nnoremap <tab> za
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
