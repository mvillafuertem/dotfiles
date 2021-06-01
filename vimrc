syntax on
set encoding=UTF-8
set number
set tabstop=4 expandtab shiftwidth=2 smarttab
"set autoindent
"set paste
set showcmd
set showmatch
set ruler
set clipboard=unnamed " yank to clipboard
set mouse=a
set laststatus=2
set relativenumber
set backspace=indent,eol,start "https://vi.stackexchange.com/questions/2162/why-doesnt-the-backspace-key-work-in-insert-mode
set path+=**
set wildignore=.git,*/node_modules/*,*/target/* " don't search git, node_modules, or targert with wildmenu
set signcolumn=yes " always show signcolumns
let mapleader=" "

if filereadable(expand("~/.coc-mappings.vim"))
  source ~/.coc-mappings.vim"
endif

if filereadable(expand("~/.plugins.vim"))
  source ~/.plugins.vim"
endif

" Theme
" set termguicolors

set background=dark
" onedark.vim override: Don't set a background color when running in a terminal;
" just use the terminal's background color
if (has("autocmd") && !has("gui_running"))
 augroup colors
   autocmd!
   let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16": "7"}
   autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) "No `bg` setting
 augroup END
endif

colorscheme onedark

" S T A T U S  L I N E
highlight CocErrorSign guifg=#E06C75
highlight CocWarningSign guifg=#E5C07B
highlight StatusLineStatus guifg=#4B5263 guibg=#2C323C
highlight StatusLineError guifg=#E06C75 guibg=#2C323C
highlight StatusLineWarning guifg=#E5C07B guibg=#2C323C

set statusline=%n\   " buffer number
set statusline+=%{GitStatus()}
set statusline+=%t\ %M%r%h%w\  " file modified, readonly, help, preview
set statusline+=%#StatusLineError#%{CocMinimalErrors()}\ " coc-errors
set statusline+=%#StatusLineWarning#%{CocMinimalWarnings()}\ " coc-warnings
set statusline+=%#StatusLineStatus#%{CocMinimalStatus()}%#StatusLine#\ " coc status
set statusline+=%=%Y\  " filetype
set statusline+=%{&ff}\  " right align line endings
set statusline+=%l,%v\ " curser position
set statusline+=%p%%\  " percentage on page

" turn on syntax highlighting.
if !exists("g:syntax_on")
  syntax enable
endif


" TERMINAL
" https://vimhelp.org/terminal.txt.html
set shell=/usr/local/bin/bash\ --rcfile\ ~/.bash_profile ":vertical :term https://stackoverflow.com/questions/8841116/vim-not-recognizing-aliases-when-in-interactive-mode
nmap <Leader>tr :botrigh vertical terminal ++cols=80<CR>
nmap <Leader>trb :botright terminal ++rows=10<CR> 

":set wildmode=list:full allows you to expand wildmenu
":set wildmenu allows you to use <Left> or <Righ> to navigate through the compoetion lists.
set wildmenu
set wildmode=longest:full,full
nnoremap <C-N> :bnext<CR>
nnoremap <C-P> :bprevious<CR>
nnoremap <C-S> :vsplit<CR>



set splitbelow                 "https://thoughtbot.com/blog/vim-splits-move-faster-and-more-naturally
set splitright
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


nmap <Leader>w :w<CR>
nmap <Leader>wq :wq<CR>
nmap <Leader>q :q<CR>


"https://stackoverflow.com/questions/7501092/can-i-map-alt-key-in-vim/15399297#15399297
nnoremap ª :m .+1<CR>==
nnoremap º :m .-2<CR>==

inoremap ª <Esc>:m .+1<CR>==gi
inoremap º <Esc>:m .-2<CR>==gi

vnoremap ª :m '>+1<CR>gv=gv
vnoremap º :m '<-2<CR>gv=gv


" get comment highlighting
autocmd FileType json syntax match Comment +\/\/.\+$+

" Help Vim recognize *.sbt and *.sc as Scala files
au BufRead,BufNewFile *.sbt,*.sc set filetype=scala
