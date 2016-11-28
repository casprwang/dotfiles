let mapleader="\<Space>"
filetype plugin indent on

" highlight cursor 
" set cursorline

" show absolute line numbers in insert mode
autocmd InsertEnter * set number norelativenumber
autocmd InsertLeave * set relativenumber



" show autocomplete for commands
set wildmenu

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
" don't be compatible :)
set nocompatible


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






" vundle
filetype off
set rtp+=~/.config/nvim/bundle/vundle
call vundle#begin('~/.config/nvim/bundle')

" =======
" Plugins
" =======

Plugin 'gmarik/vundle'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'mhartington/oceanic-next'
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

" color shit ===================
" set term=xterm
" set t_Co=256
" color scheme
" syntax enable
" colorscheme mustang
" colorscheme kalisi
" set background=dark
" let &t_AB="\e[48;5;%dm"
" let &t_AF="\e[38;5;%dm"
" set t_Co=256
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
if (has("termguicolors"))
 set termguicolors
endif

" Theme
syntax enable
colorscheme molokai
" =========================

" =================Nerd Comment
" ============================
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" =============================
"

" nnoremap <leader>c :call NERDComment(0,"toggle")<CR>
" vnoremap <leader>c :call NERDComment(0,"toggle")<CR>

