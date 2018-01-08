let mapleader="\<Space>"
set laststatus=2
set nowrap
map <leader>j :w<cr>
set smartindent
set expandtab  
nmap <CR> o<Esc>
nmap <S-Enter> O<Esc>
set noswapfile
set clipboard=unnamed
set autoread
" " show autocomplete for commands
set wildmenu
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

nmap Y y$

nmap <c-w>v <c-w>v<right>
nmap <c-w>l <c-w>v
nmap <c-w>j <c-w>s<down>

set expandtab
set shiftwidth=2
set softtabstop=2
