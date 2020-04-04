set number
set tabstop=4 expandtab shiftwidth=2 smarttab
syntax on
set showcmd
set showmatch
set ruler
set encoding=utf-8
set clipboard=unnamed
set mouse=a
set laststatus=2
set relativenumber


" Configuration for vim-plug
" call plug#begin('~/.vim/plugged')
" Plug 'derekwyatt/vim-scala'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'scrooloose/nerdtree'
" Plug 'christoomey/vim-tmux-navigator'

" call plug#end()

" Configuration for nerdtree
let mapleader=" "
" nmap <Leader>nt :NERDTreeFind<CR>
nmap <Leader>w :w<CR>
nmap <Leader>q :q<CR>

" Configuration for vim-scala
" au BufRead,BufNewFile *.sbt set filetype=scala
