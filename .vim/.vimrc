" go
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim

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
nnoremap J 5j
nnoremap K 5k
nmap <c-w>v <c-w>v<right>
nmap <c-w>l <c-w>v
nmap <c-w>j <c-w>s<down>
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-commentary'
Plugin 'jiangmiao/auto-pairs' 
" Plugin 'Valloric/YouCompleteMe'
Plugin 'vitalk/vim-simple-todo'
Plugin 'junegunn/fzf'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'scrooloose/nerdtree'
Plugin 'jiangmiao/auto-pairs'
Plugin 'itchyny/calendar.vim'
" kana
Plugin 'kana/vim-textobj-user'
Plugin 'kana/vim-textobj-entire'
Plugin 'beloglazov/vim-textobj-quotes'
Plugin 'kana/vim-textobj-line'
" Markdown
Plugin 'plasticboy/vim-markdown'
Plugin 'iamcco/markdown-preview.vim'
" Syntastic
Plugin 'vim-syntastic/syntastic'
Plugin 'rizzatti/dash.vim'


call vundle#end()            " required
filetype plugin indent on    " required

set expandtab
set shiftwidth=2
set softtabstop=2

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
set background=light
colorscheme lucario

let g:simple_todo_map_keys = 0

nmap <Leader>i <Plug>(simple-todo-below)
nmap <Leader>I <Plug>(simple-todo-above)
nmap <Leader>u <Plug>(simple-todo-mark-switch)

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

" markdown 
set shell=bash\ -i
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 0

" set to 1, the vim will open the preview window once enter the markdown
" let g:mkdp_auto_start = 1
let g:mkdp_path_to_chrome = "open -a Google\\ Chrome\\ Canary"

nmap <silent> <leader>m <Plug>MarkdownPreview 

nmap <leader>in :BundleInstall<cr>
nmap <leader>id :Dash<cr>

" Syntastic
let g:syntastic_javascript_checkers = ['eslint']

let g:syntastic_javascript_eslint_exe = '$(npm bin)/eslint'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0


let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

" :Calendar
nmap <leader>rn :! node %<cr>
nmap <leader>rp :! python3 %<cr>
