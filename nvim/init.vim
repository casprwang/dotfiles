let mapleader="\<Space>"
nnoremap <leader>w :wa!<CR>
nnoremap <leader>s :wa!<CR>
nnoremap <D-s> :wa<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :q!<CR>
nnoremap <C-w>h <C-w>h
nnoremap <C-w>l <C-w>l
nnoremap <C-w>j <C-w>j
nnoremap <C-w>k <C-w>k
nnoremap <C-w>c <C-w>c
nnoremap <leader>. :source ~/.config/nvim/init.vim<CR>
nnoremap <leader>n :noh<CR>
nnoremap <leader>y :syn on<CR>
nmap <CR> o<Esc>



" core setting
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
set undodir=~/.config/nvim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo


" for swap 
set backupdir=~/.nvim/backup//
set directory=~/.nvim/swap//
set undodir=~/.nvim/undo//



" don't be compatible :)
set nocompatible



" vundle
filetype off
set rtp+=~/.config/nvim/bundle/vundle
call vundle#begin('~/.config/nvim/bundle')

" =======
" Plugins
" =======

Plugin 'gmarik/vundle'
Plugin 'scrooloose/nerdtree'
" Plugin 'Xuyuanp/nerdtree-git-plugin'
" Plugin 'tpope/vim-fugitive'
" Plugin 'kien/ctrlp.vim'
" Plugin 'scrooloose/syntastic'
" Plugin 'Yggdroot/indentLine'
" Plugin 'marijnh/tern_for_vim'
" Plugin 'bling/vim-airline'
" Plugin 'othree/html5.vim'
" Plugin 'airblade/vim-gitgutter'
" Plugin 'pangloss/vim-javascript'

call vundle#end()
filetype on


" Mapping for Plugins
map <leader>o :NERDTreeToggle<CR>







