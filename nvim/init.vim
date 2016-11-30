let mapleader="\<Space>"
set laststatus=2
" let foo=3

" function source()
" ex
" noremap  <silent> k gk
" noremap  <silent> j gj
" noremap  <silent> h gh
" noremap  <silent> l gl

" highlight cursor 
" set cursorline

" show absolute line numbers in insert mode
autocmd InsertEnter * set number norelativenumber
autocmd InsertLeave * set relativenumber
set splitbelow
set splitright

" show autocomplete for commands
set wildmenu

nnoremap <leader>w :wa!<CR>
nnoremap <leader>s :wa!<CR>
nnoremap <D-s> :wa<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :q!<CR>
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <c-w>l <C-w>v
nnoremap <c-w>j <C-w>s
nnoremap <c-z> :q!<cr>

" fixing the conflict with gitgutter without warning after reloading vimrc


" vnoremap <leader>gb :Gblame<CR>
" nnoremap <leader>gb :Gblame<CR>


" nnoremap <leader>c <C-w>c
nnoremap <leader>. :source ~/.config/nvim/init.vim<CR>
" nnoremap <leader>zz :source ~/dotfiles/.zshrc<CR>
map <silent> <esc> :noh<CR>
" nnoremap <leader>y :syn on<CR>
nmap <CR> o<Esc>
nmap <S-Enter> O<Esc>
map <silent> <leader>cc :TComment<CR>
" don't be compatible :)
set nocompatible
inoremap <c-d> <esc>ddi
inoremap <c-f> <c-x><c-f>


" Terminal mode
nmap <c-t> :terminal<cr>
tnoremap <Esc> <C-d><cr>

" navigation
noremap H ^
noremap L g_
noremap J 5j
noremap K 5k
noremap <c-d> 5<c-e>
noremap <c-u> 5<c-y>
" noremap ; :

" vmap
vmap < <gv
vmap > >gv

" commenting
noremap <leader>== o========================<esc>

" ==================================================
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

" dein ---------------------
set runtimepath+=~/.config/nvim/dein.vim/
call dein#begin(expand('~/.config/nvim/deinPlugins'))
call dein#add('Shougo/dein.vim')
call dein#add('scrooloose/nerdtree')
call dein#add('vim-airline/vim-airline')
call dein#add('tomtom/tcomment_vim')
call dein#add('ryanoasis/vim-devicons')
call dein#add('Yggdroot/indentLine')
call dein#add('tpope/vim-surround')
call dein#add('Raimondi/delimitMate')
call dein#add('mattn/emmet-vim')
call dein#add('Xuyuanp/nerdtree-git-plugin')
call dein#add('airblade/vim-gitgutter')
call dein#add('ap/vim-css-color', {'on_ft': ['css', 'scss', 'yaml']})
call dein#add('junegunn/fzf')
call dein#add('dhruvasagar/vim-table-mode')
call dein#add('suan/vim-instant-markdown')
call dein#add('tpope/vim-fugitive')
call dein#add('valloric/MatchTagAlways', {'on_ft': 'html'})
call dein#end()
filetype plugin indent on
nmap <leader>ii :call dein#install()<cr>

" vundle --------------------------
"filetype off
"set rtp+=~/.config/nvim/bundle/vundle
"call vundle#begin('~/.config/nvim/bundle')
"
"========================
" Remember cursor position
"========================
"========================
"========================
"========================
autocmd BufReadPost *
      \ if line("'\"") > 0 && line ("'\"") <= line("$") |
      \   exe "normal! g'\"" |
      \ endif
      " center buffer around cursor when opening files
autocmd BufRead * normal zz
"========================
"========================
"========================
"" Plugins
" =======

" Plugin 'gmarik/vundle'
" Plugin 'scrooloose/nerdtree'
"Plugin 'mhartington/oceanic-next'
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

"call vundle#end()
"filetype on
" ----------------------

" Mapping for Plugins
map <silent> <leader>o :NERDTreeToggle<CR>

" color shit ===================
" color shit ===================
" color shit ===================
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
" hi CursorLineNR guifg=#ffffff
" hi SpellBad guibg=#ff2929 guifg=#ffffff" ctermbg=224
" =========================
" =========================
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


map <c-p> :FZF<cr>



" " Emmet==============================
" " Enable Emmet in all modes
" " Remapping <C-y>, just doesn't cut it.
"   function! s:expand_html_tab()
" " try to determine if we're within quotes or tags.
" " if so, assume we're in an emmet fill area.
"    let line = getline('.')
"    if col('.') < len(line)
"      let line = matchstr(line, '[">][^<"]*\%'.col('.').'c[^>"]*[<"]')
"      if len(line) >= 2
"         return "\<C-n>"
"      endif
"    endif
" " expand anything emmet thinks is expandable.
"   if emmet#isExpandable()
"     return "\<C-y>,"
"   endif
" " return a regular tab character
"   return "\<tab>"
"   endfunction

"   autocmd FileType html,markdown imap <buffer><expr><tab> <sid>expand_html_tab()
"   let g:user_emmet_mode='a'
"   let g:user_emmet_complete_tag = 0
"   let g:user_emmet_install_global = 0
"   autocmd FileType html,css EmmetInstall
"
" " =====================================================
" unmap gitgutter for smooth <leader>h
let g:gitgutter_map_keys = 0


" set encoding=utf-8
" " set macligatures
" " set guifont=Fira\ Code:h12
"
"
" " set guifont=<FONT_NAME>:h<FONT_SIZE>
" " set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types:h11
" let g:airline_powerline_fonts=1
" " set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete\ 12
"
" " set encoding=utf8
"
"
"
" " loading the plugin 
" let g:webdevicons_enable = 1
" " adding the flags to NERDTree 
" let g:webdevicons_enable_nerdtree = 1
" " adding the custom source to unite 
" let g:webdevicons_enable_unite = 1
" " adding the column to vimfiler 
" let g:webdevicons_enable_vimfiler = 1
" " adding to vim-airline's tabline 
" let g:webdevicons_enable_airline_tabline = 1
" " adding to vim-airline's statusline 
" let g:webdevicons_enable_airline_statusline = 1
" " ctrlp glyphs
" let g:webdevicons_enable_ctrlp = 1
" " adding to flagship's statusline 
" let g:webdevicons_enable_flagship_statusline = 1
" " turn on/off file node glyph decorations (not particularly useful)
" let g:WebDevIconsUnicodeDecorateFileNodes = 1
" " use double-width(1) or single-width(0) glyphs 
" " only manipulates padding, has no effect on terminal or set(guifont) font
" let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
" " whether or not to show the nerdtree brackets around flags 
" let g:webdevicons_conceal_nerdtree_brackets = 1
" " the amount of space to use after the glyph character (default ' ')
" let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '
" " Force extra padding in NERDTree so that the filetype icons line up vertically 
" let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
