let mapleader="\<Space>"
map <leader>j :w<cr>
set smartindent
" let foo=3
set expandtab  
nmap <CR> o<Esc>
nmap <S-Enter> O<Esc>
" set timeoutlen=1000 ttimeoutlen=0
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

nnoremap J 5j
nnoremap K 5k

set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()



Plugin 'Shougo/dein.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-commentary'
Plugin 'KabbAmine/vCoolor.vim'
" call dein#add('justinmk/vim-sneak')
" call dein#add('tomtom/tcomment_vim')
Plugin 'junegunn/vim-easy-align'
Plugin 'terryma/vim-smooth-scroll'
Plugin 'ryanoasis/vim-devicons'
Plugin 'Yggdroot/indentLine'
Plugin 'tpope/vim-surround'
Plugin 'Raimondi/delimitMate'
Plugin 'mattn/emmet-vim'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'airblade/vim-gitgutter'
Plugin 'godlygeek/tabular'
Plugin 'ap/vim-css-color', {'on_ft': ['css', 'scss', 'yaml']}
Plugin 'junegunn/fzf'
Plugin 'dhruvasagar/vim-table-mode'
" call dein#add('suan/vim-instant-markdown')
Plugin 'tpope/vim-fugitive'
Plugin 'valloric/MatchTagAlways', {'on_ft': 'html'}
Plugin 'vim-scripts/ReplaceWithRegister'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
" call dein#add('Shougo/neomru.vim')
Plugin 'vim-scripts/mru.vim'
Plugin 'mattn/gist-vim'
Plugin 'mattn/webapi-vim'
Plugin 'metakirby5/codi.vim'

" youcompleteme
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'ervandew/supertab'


" UX UI
Plugin 'mhinz/vim-startify'
Plugin 'christoomey/vim-tmux-navigator'


" syntax
Plugin 'neovim/node-host', {'build': 'npm install'}
Plugin 'vim-syntastic/syntastic'
Plugin 'othree/html5.vim'
Plugin 'othree/yajs.vim', {'on_ft': 'javascript'}
Plugin 'othree/es.next.syntax.vim', {'on_ft': 'javascript'}
Plugin 'othree/jsdoc-syntax.vim', {'on_ft':['javascript', 'typescript']}
Plugin 'heavenshell/vim-jsdoc', {'on_ft':['javascript', 'typescript']}
Plugin 'moll/vim-node', {'on_ft':['javascript', 'typescript']}
Plugin 'elzr/vim-json', {'on_ft': 'json'}
Plugin 'hail2u/vim-css3-syntax', {'on_ft':['css','scss']}
Plugin 'ap/vim-css-color', {'on_ft': ['css', 'scss', 'yaml']}
" call dein#add('tpope/vim-markdown', {'on_ft': 'markdown'})
Plugin 'rizzatti/dash.vim'

Plugin 'davidhalter/jedi-vim'

Plugin 'pangloss/vim-javascript'

" folding 
" call dein#add('nelstrom/vim-markdown-folding')
Plugin 'tmhedberg/SimpylFold', {'on_ft': 'python'}


" deoplete
" call dein#add('Shougo/deoplete.nvim')
Plugin 'ternjs/tern_for_vim'
" call dein#add('carlitux/deoplete-ternjs', {'on_ft': 'javascript'})

" easy motion
" Plugin 'easymotion/vim-easymotion'


" kana/vim-textobj-user
Plugin 'kana/vim-textobj-user'
Plugin 'fvictorio/vim-textobj-backticks'
Plugin 'thinca/vim-textobj-between'
Plugin 'kana/vim-textobj-line'
Plugin 'Chun-Yang/vim-textobj-chunk'
Plugin 'kana/vim-textobj-indent'
Plugin 'mattn/vim-textobj-url'
Plugin 'whatyouhide/vim-textobj-xmlattr'
Plugin 'jceb/vim-textobj-uri'




" call dein#add('rhysd/nyaovim-markdown-preview')
Plugin 'rhysd/nyaovim-mini-browser'



call vundle#end()            " required
filetype plugin indent on    " required



set expandtab
set shiftwidth=2
set softtabstop=2

autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype python setlocal ts=4 sts=4 sw=4
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2



syntax on
set background=light
colorscheme lucario
