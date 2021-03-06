" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

function! ResCur()
  if line("'\"") > 0 && line("'\"") <= line("$")
    normal! g`"
	normal! zz
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END


set nocompatible      " Don't force vi compatibility
behave xterm          " Alternative is 'xterm'
set keymodel=""       " mswin includes start/stopsel.
set ai                " Turn on autoindenting
set aw                " Save file when compiling, etc.
set bs=2              " Allow backspacing over everything in insert mode
"set guioptions=Ttma   " Toolbar, menu, tearoffs, autoselect
set tw=120             " Limit the width of text to 70
set viminfo='20,\"50  " Read/write a .viminfo file, don't store more
" than 50 lines of registers
set whichwrap=b,s,<,>,[,] " End of line cursor support
set nobackup          " Do not create backup files
set ruler
set showmatch
set incsearch
set hlsearch
set scrolloff=10	  " minimal number of lines visible above current line(the one with cursor)
"set noet ci pi sts=0 sw=4 ts=4 which is:
set noexpandtab         " No tabs in the output file!
set shiftwidth=4      " What you get for ^D
set tabstop=4         " Same as shiftwidth
"set copyindent
"set preserveindent
set softtabstop=0
" following options set c-style indentation
" it is visible when one statement spans multiple lines
set cindent
set cinoptions=(0,u0,U0
" for work - bezet - 25.04.2013
set cinoptions=(0,u0,U0,{1s,>2s,e-s,^-s sw=2 ts=2 expandtab
" for vim in ssh(and xterm)
set t_Co=256
set number

nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
"set comments=sl:/**,mb:\ *,exl:\ */,sr:/*,mb:*,exl:*/,://
" bezet - 27.08.2013
set colorcolumn=81
" let &colorcolumn=join(range(81,999),",")
colorscheme b2
syntax on
" bezet - 9.9.2013
set diffopt+=context:16

" When starting to edit a file:
"   For Java, C, and C++ files set formatting of comments and set
"   C-indenting on.   For other files switch it off.
"   Don't change the sequence, it's important that the line with * comes first.
autocmd BufRead * set formatoptions=tcql nocindent comments&
au BufNewFile,BufRead *.g2 set filetype=c
"	TODO: compare following lines
"autocmd BufRead *.java,*.c,*.h,*.cc,*.cpp,*.hpp set formatoptions=ctq cindent comments=sr:/**,mb:*,elx:*/,sr:/*,mb:*,elx:*/,:// number expandtab
autocmd BufRead,BufNewFile *.java,*.c,*.h,*.cc,*.cpp,*.hpp set formatoptions=ctroq cindent comments=sr:/**,mb:*,elx:*/,sr:/*,mb:*,elx:*/,://
autocmd BufRead,BufNewFile *.py set expandtab
au BufRead,BufNewFile *.pde set filetype=arduino
au BufRead,BufNewFile *.ino set filetype=arduino
"	make pfp loadable only on request
"	for pathogen 2.4 version (coming soon?)
"	let g:pathogen_blacklist = []
let g:pathogen_disabled = []
call add(g:pathogen_disabled, 'pfp-vim')
call pathogen#infect()
" settings for splice
let g:splice_initial_layout_grid=1
let g:splice_initial_diff_grid=1
set splitright

" 01.10.2013 - bezet - testing
filetype plugin indent on
syntax enable
let g:mwDefaultHighlightingPalette='extended'
