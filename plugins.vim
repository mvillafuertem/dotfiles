" P L U G I N S
call plug#begin()
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'airblade/vim-gitgutter', {'branch': 'master'}
    Plug 'scalameta/coc-metals', {'do': 'yarn install --frozen-lockfile'}
    Plug 'ryanoasis/vim-devicons'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'chriskempson/base16-vim'
    Plug 'morhetz/gruvbox'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'joshdick/onedark.vim'
    Plug 'preservim/nerdtree'
    Plug 'tpope/vim-fugitive'
    Plug 'Yggdroot/indentLine'
call plug#end()

" C O C
" Gets Errors and Warnings for buffer plus the Status message from coc.nvim
function! StatusDiagnosticForBuffer() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, '✘' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, '' . info['warning'])
  endif
  return join(msgs, ' ')
endfunction

" Gets Errors and Warnings for the entire workspace from coc.nvim
function! StatusDiagnosticForWorkspace() abort
  let diagnostics = CocAction('diagnosticList')
  if type(diagnostics) == v:t_list
    let errors = []
    let warnings = []
    for diagnostic in diagnostics
      if diagnostic['severity'] == 'Error'
        call add(errors, diagnostic)
      endif
      if diagnostic['severity'] == 'Warning'
        call add(warnings, diagnostic)
      endif
    endfor
    return " ✘ " . string(len(errors)) . "  " . string(len(warnings)) . " "
  endif
endfunction

" Just gets the status message from coc.nvim
function! CocMinimalStatus() abort
  return get(g:, 'coc_status', '')
endfunction

" Just gets the errors from the current buffer
function! CocMinimalErrors() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, '✘' . info['error'])
  endif
  return join(msgs)
endfunction

" Just gets the warnings from the current buffer
function! CocMinimalWarnings() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'warning', 0)
    call add(msgs, '' . info['warning'])
  endif
  return join(msgs)
endfunction

" G I T G U T T E R
function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction

" A I R L I N E
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep=' '
let g:airline#extensions#tabline#left_alt_sep=' '
let g:airline#extensions#tabline#right_sep=' '
let g:airline#extensions#tabline#right_alt_sep=' '
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1
let g:airline_theme='onedark'
let g:airline_powerline_fonts=1
let g:airline_left_sep=' '
let g:airline_right_sep=' '
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
" nmap <leader>1 :bfirst<CR>
" nmap <leader>2 :bfirst<CR>:bn<CR>
" nmap <leader>3 :bfirst<CR>:2bn<CR>
" nmap <leader>4 :bfirst<CR>:3bn<CR>
" nmap <leader>5 :bfirst<CR>:4bn<CR>

" N E R D T R E E
let NERDTreeShowHidden=1
nmap <Leader>nt :NERDTreeFind<CR>
nmap <Leader>ntc :NERDTreeClose<CR>
nmap ,f :NERDTreeFind<CR>
" Open NERDTree when open vim
" autocmd VimEnter * NERDTree
" autocmd VimEnter * wincmd p
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
