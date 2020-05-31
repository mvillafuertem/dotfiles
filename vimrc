set encoding=utf-8
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
set backspace=indent,eol,start "https://vi.stackexchange.com/questions/2162/why-doesnt-the-backspace-key-work-in-insert-mode

let mapleader=" "
nmap <Leader>w :wq<CR>
nmap <Leader>q :q<CR>
nmap <Leader>nt :NERDTreeFind<CR>
nmap <Leader>ntc :NERDTreeClose<CR>

call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'ryanoasis/vim-devicons'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'
Plug 'christoomey/vim-tmux-navigator'
Plug 'joshdick/onedark.vim'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
call plug#end()

colorscheme onedark
"set background=dark
"let base16colorspace=256
"set termguicolors

let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1
let g:airline_theme='onedark'

if filereadable(expand("~/coc-mappings.vim"))
  source ~/coc-mappings.vim"
endif

autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
