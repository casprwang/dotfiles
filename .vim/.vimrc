syntax on
" 1. Mapping
let mapleader = "\<Space>"
nnoremap <leader>w :wa<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :q!<CR>
nnoremap <leader>o :NERDTreeToggle<CR>
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>c <C-w>c
nnoremap <leader>e :MRU<CR>
nnoremap <C-w>j <C-w>s       
nnoremap <C-w>l <C-w>v
" nnoremap <leader>, :e $MYVIMRC<CR> 
nnoremap <leader>. :source .vimrc<CR>
nnoremap <leader>n :noh<CR>
nnoremap <leader>y :syn on<CR>
nnoremap <leader>L 10<C-w>> 
nnoremap <leader>H 10<C-w>< 
nnoremap <leader>J 10<C-w>+ 
nnoremap <leader>K 10<C-w>- 
nnoremap <leader>c :lcl<CR>
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>


syntax on
set background=dark
colorscheme material-theme

" shorten the escape time
set timeoutlen=1000 ttimeoutlen=0
set noswapfile
set clipboard=unnamed
set autoread



set backspace=2 " make backspace work like most other apps
set backspace=indent,eol,start

filetype plugin on
" Ctrl-P
let g:ctrlp_map = '<c-p>'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 2.Interface
syntax on 
set relativenumber 
set t_Co=256
set laststatus =2

" for mustang colorscheme
if &t_Co >= 256 || has("gui_running")
    colorscheme mustang
endif

if &t_Co > 2 || has("gui_running")
    " switch syntax highlighting on, when the terminal has colors
    syntax on
endif

" Speed up CtrlP	
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*.a,*.o
set wildignore+=.pyc
set wildignore+=*_build/*
set wildignore+=/coverage/*
set wildignore+=*.bmp,*.gif,*ico,*.jpg,*.png
set wildignore+=*.DS_Store,.hg,.svn
set wildignore+=*~,*.swp,*.tmp
set wildignore+=/Applications/*

if exists("g:ctrl_user_command")
  unlet g:ctrlp_user_command
endif
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/vendor/* 

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 3.Bundle Begins  
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()                     
Plugin 'VundleVim/Vundle.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'scrooloose/nerdTree'
Plugin 'kien/ctrlp.vim'
"Plugin 'klen/python-mode'
Plugin 'Lokaltog/vim-powerline'
Plugin 'tmhedberg/SimpylFold'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'yegappan/mru'
Plugin 'digitaltoad/vim-pug'
Plugin 'scrooloose/nerdcommenter'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'djoshea/vim-autoread'
Plugin 'plasticboy/vim-markdown'
Plugin 'jiangmiao/auto-pairs'
Plugin 'jdkanani/vim-material-theme'
" Plugin 'mattn/emmet-vim'
" Plugin 'majutsushi/tagbar'


" Plugin 'vim-airline/vim-airline'
call vundle#end()            " required
" Bundle ends 

" mru: open the recent files
let MRU_Max_Entries = 1000
let MRU_Exclude_Files = '^/tmp/.*\|^/var/tmp/.*'  " For Unix
let MRU_Window_Height = 15
let MRU_Use_Current_Window = 1
let MRU_Auto_Close = 0
let MRU_Add_Menu = 0
let MRU_Max_Menu_Entries = 20
let MRU_Max_Submenu_Entries = 15



" For python
set tw=79
set nowrap
set fo-=t 
set colorcolumn=80
highlight ColorColumn ctermbg =233
set history=700
set undolevels=700
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
" set expandtab
set hlsearch 
set incsearch 
set ignorecase
set smartcase
" set autoindent
set showmatch
set smarttab
set copyindent 

" PPPPPPPPPPPPPPPPPPPPPPPPPPP
" let g:syntastic_python_python_exec = '/path/to/python3'
" 
" let g:pymode_rope_completion = 1
" let g:pymode_rope_completion_bind = '<C-Space>'
" let g:pymode_rope_complete_on_dot = 1
" let g:pymode_syntax = 1
" let g:pymode_rope_lookup_project = 0 
" let g:pymode_rope_autoimport = 0
" let g:pymode_rope = 0
" let g:pymode_syntax_all = 1
" let g:pymode_syntax_print_as_function = 0
" let g:pymode_syntax_highlight_equal_operator = g:pymode_syntax_all
" let g:pymode_syntax_highlight_stars_operator = g:pymode_syntax_all
" let g:pymode_syntax_indent_errors = g:pymode_syntax_all
" let g:pymode_syntax_space_errors = g:pymode_syntax_all
" let g:pymode_syntax_string_formatting = g:pymode_syntax_all
" let g:pymode_syntax_string_format = g:pymode_syntax_all
" let g:pymode_syntax_string_templates = g:pymode_syntax_all
" let g:pymode_syntax_doctests = g:pymode_syntax_all
" let g:pymode_syntax_builtin_types = g:pymode_syntax_all
" let g:pymode_syntax_builtin_objs = g:pymode_syntax_all
" let g:pymode_syntax_highlight_exceptions = g:pymode_syntax_all
" let g:pymode_syntax_docstrings = g:pymode_syntax_all
" 
" PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP


let g:pymode_indent = 0
let g:pymode_motion = 1



" python folding 
let g:SimpylFold_docstring_preview = 1

" syntastic 
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0






"""""""""""""""""""""" Nerd comment"
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code
" indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1






set undofile                " Save undo's after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo


let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=darkgrey ctermbg=234
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=darkgrey ctermbg=236


let g:vim_markdown_folding_disabled = 1


" let g:user_emmet_leader_key='<C-m>'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
