let mapleader="\<Space>"
set laststatus=2
set nowrap
map <leader>j :w<cr>
set smartindent
" let foo=3
set expandtab  
nmap <CR> o<Esc>
nmap <S-Enter> O<Esc>
set noswapfile
set clipboard=unnamed
set autoread
" " show autocomplete for commands
set wildmenu
" map <silent> <esc> :noh<CR>
nnoremap <leader>. :source ~/.vimrc<CR>
set timeoutlen=1000 ttimeoutlen=0
set noswapfile
set clipboard=unnamed
set autoread
set relativenumber
set number
set hlsearch
set incsearch
set ignorecase
set smartcase
set autoindent
set showmatch
set smarttab
set copyindent

set undofile                " Save undo's after file closes
set undodir=~/.config/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo
nnoremap J 5gj
nnoremap K 5gk
vmap J 5gj
vmap K 5gk
nmap Y y$

nmap <c-w>v <c-w>v<right>
nmap <c-w>l <c-w>v
nmap <c-w>j <c-w>s<down>



set expandtab
set shiftwidth=2
set softtabstop=2



" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-commentary'
Plug 'chriskempson/base16-vim'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'othree/es.next.syntax.vim', {'on_ft': 'javascript'}
Plug 'kana/vim-textobj-entire'
Plug 'beloglazov/vim-textobj-quotes'
" Plug 'kana/vim-textobj-function'
Plug 'christoomey/vim-tmux-navigator'
Plug 'kana/vim-smartinput'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf'
" Initialize plugin system
call plug#end()






autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype python setlocal ts=4 sts=4 sw=4
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2

autocmd BufReadPost *
      \ if line("'\"") > 0 && line ("'\"") <= line("$") |
      \   exe "normal! g'\"" |
      \ endif
      " center buffer around cursor when opening files
autocmd BufRead * normal zz


syntax enable

" ================================== waiting 
let base16colorspace=256  " Access colors present in 256 colorspace
colorscheme base16-default-dark
" fzf
map <c-p> :FZF<cr>

" navi
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <Down> :TmuxNavigateDown<cr>
nnoremap <silent> <Up> :TmuxNavigateUp<cr>
nnoremap <silent> <Right> :TmuxNavigateRight<cr>
nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>
nnoremap <silent> <Left> :TmuxNavigateLeft<cr>

map <leader>o :NERDTreeToggle<CR>

" fzf
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }


if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
