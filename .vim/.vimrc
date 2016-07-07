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
nnoremap <leader>, :e $MYVIMRC<CR> 
nnoremap <leader>. :source .vimrc<CR>
nnoremap <leader>n :noh<CR>
nnoremap <leader>y :syn on<CR>
nnoremap <leader>L <C-w>> 
nnoremap <leader>H <C-w>< 
nnoremap <leader>J <C-w>+ 
nnoremap <leader>K <C-w>- 
nnoremap <leader>c :lcl<CR>

" shorten the escape time
set timeoutlen=1000 ttimeoutlen=0
set noswapfile
set clipboard=unnamed

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
Plugin 'klen/python-mode'
Plugin 'Lokaltog/vim-powerline'
Plugin 'tmhedberg/SimpylFold'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'yegappan/mru'
Plugin 'digitaltoad/vim-pug'
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
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab
set hlsearch 
set incsearch 
set ignorecase
set smartcase
" set autoindent
set showmatch
set smarttab
set copyindent 

let g:syntastic_python_python_exec = '/path/to/python3'

" python mode
let g:pymode = 1
let g:pymode_rope_completion = 1
let g:pymode_rope_completion_bind = '<C-Space>'
let g:pymode_rope_complete_on_dot = 1
let g:pymode_syntax = 1
let g:pymode_rope_lookup_project = 0 
let g:pymode_rope_autoimport = 0
let g:pymode_rope = 0
let g:pymode_syntax_all = 1
let g:pymode_syntax_print_as_function = 0
let g:pymode_syntax_highlight_equal_operator = g:pymode_syntax_all
let g:pymode_syntax_highlight_stars_operator = g:pymode_syntax_all
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
let g:pymode_syntax_string_formatting = g:pymode_syntax_all
let g:pymode_syntax_string_format = g:pymode_syntax_all
let g:pymode_syntax_string_templates = g:pymode_syntax_all
let g:pymode_syntax_doctests = g:pymode_syntax_all
let g:pymode_syntax_builtin_types = g:pymode_syntax_all
let g:pymode_syntax_builtin_objs = g:pymode_syntax_all
let g:pymode_syntax_highlight_exceptions = g:pymode_syntax_all
let g:pymode_syntax_docstrings = g:pymode_syntax_all



" python mode 
" map <Leader>g :call RopeGotoDefinition()<CR>
" let ropevim_enable_shortcuts = 1
" let g:pymode_rope_goto_def_newwin = "vnew"
" let g:pymode_rope_extended_complete = 1
" let g:pymode_breakpoint = 0
" let g:pymode_syntax = 1
" let g:pymode_syntax_built_objs = 0
" let g:pymode_syntax_built_funcs = 0
" map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>
let g:pymode_indent = 1
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
