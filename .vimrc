set nocompatible
set backspace=indent,eol,start

set number
set cursorline
set ruler
set laststatus=2

set autoindent
set expandtab
set tabstop=2
set shiftwidth=2

set history=100
set vb t_vb=

syntax on

" Python
autocmd FileType python setl smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType python setl tabstop=8 expandtab shiftwidth=4 softtabstop=4
