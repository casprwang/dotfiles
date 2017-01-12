let s:editor_root=expand("~/.config/nvim")

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
nnoremap <leader>. :source ~/.config/nvim/init.vim<CR>
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

nnoremap J 5j
nnoremap K 5k


"dein Scripts-----------------------------
"dein Scripts-----------------------------
"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/wangsong/.config/nvim/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('/Users/wangsong/.config/nvim/dein')

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" commenting
call dein#add('tpope/vim-commentary')


call dein#add('jiangmiao/auto-pairs')


" kana/vim-textobj-user
call dein#add('kana/vim-textobj-user')
" call dein#add('fvictorio/vim-textobj-backticks')
" call dein#add('thinca/vim-textobj-between')
call dein#add('kana/vim-textobj-line')
" call dein#add('Chun-Yang/vim-textobj-chunk')
" call dein#add('kana/vim-textobj-indent')
" call dein#add('mattn/vim-textobj-url')
" call dein#add('whatyouhide/vim-textobj-xmlattr')
" call dein#add('jceb/vim-textobj-uri')
call dein#add('kana/vim-textobj-entire')
call dein#add('beloglazov/vim-textobj-quotes')
call dein#add('kana/vim-textobj-function')


" navi
call dein#add('christoomey/vim-tmux-navigator')


call dein#add('mattn/emmet-vim')


" Add or remove your plugins here:
call dein#add('Valloric/YouCompleteMe', {'build': './install.py'})
call dein#add('SirVer/ultisnips')
" call dein#add('honza/vim-snippets')

" completion libraries
call dein#add('othree/html5.vim')
call dein#add('othree/yajs.vim', {'on_ft': 'javascript'})
call dein#add('othree/es.next.syntax.vim', {'on_ft': 'javascript'})

call dein#add('ervandew/supertab')

call dein#add('junegunn/fzf')
" You can specify revision/branch/tag.
" call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------
"End dein Scripts-------------------------
"End dein Scripts-------------------------









set expandtab
set shiftwidth=2
set softtabstop=2

autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype python setlocal ts=4 sts=4 sw=4
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2


" let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
" if (has("termguicolors"))
"  set termguicolors
" endif


" syntax enable
" syntax on
" set background=light

" if (has("termguicolors"))
"  set termguicolors
" endif

" Theme


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

"end  Remember cursor position
"========================
"========================
"========================
"========================


syntax enable
set background=light
colorscheme lucario

"status bar
set laststatus=2
set statusline=%f         " Path to the file
set statusline+=%=        " Switch to the right side
set statusline+=%l        " Current line
set statusline+=/         " Separator
set statusline+=%L        " Total lines
set statusline+=
" end 



" completion 
" completion 
" completion 
" completion 
" completion 
function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction

au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-e>"
" this mapping Enter key to <C-y> to chose the current highlight item 
" and close the selection list, same as other IDEs.
" CONFLICT with some plugins like tpope/Endwise
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"



nnoremap <leader>vv ggVG
nnoremap <leader>dd VGd

" let g:UltiSnipsSnippetDirectories = ['~/dotfiles/UltiSnips']
let g:UltiSnipsEditSplit = 'horizontal'
let g:UltiSnipsSnippetsDir="~/dotfiles/nvim/ultiSnips"

" let g:UltiSnipsSnippetDirectories=["~/dotfiles/nvim/UltiSnips"]
" let g:UltiSnipsSnippetDirectories=$HOME.'/dotfiles/UltiSnips'
let g:UltiSnipsSnippetDirectories=["ultiSnips"]

let g:vim_json_syntax_conceal = 0

" imap <Down> <c-j>
imap <c-e> <esc>A
" <c-a> <esc>I

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" end completion 
" end completion 
" end completion 
" end completion 
" end completion 
"
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <Down> :TmuxNavigateDown<cr>
nnoremap <silent> <Up> :TmuxNavigateUp<cr>
nnoremap <silent> <Right> :TmuxNavigateRight<cr>
nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>
nnoremap <silent> <Left> :TmuxNavigateLeft<cr>

" install 
nmap <leader>in :call dein#install()<cr>

" fzf
map <c-p> :FZF<cr>
imap <cr> <esc>o


nmap <leader>in :call dein#install()<cr>

imap <c-q> <c-y>,
