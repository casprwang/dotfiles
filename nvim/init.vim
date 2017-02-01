let s:editor_root=expand("~/.config/nvim")

let mapleader="\<Space>"
map <leader>j :w<cr>
set smartindent
" let foo=3
set expandtab
nmap <CR> o<Esc>
nmap <S-Enter> O<Esc>
" set timeoutlen=1000 ttimeoutlen=0
nmap <c-w>v <c-w>v<right>
nmap <c-w>l <c-w>v
nmap <c-w>j <c-w>s<down>


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
vmap J 5j
" vmap K 5K

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

" css
call dein#add('hail2u/vim-css3-syntax', {'on_ft':['css','scss']})


call dein#add('jiangmiao/auto-pairs')

call dein#add('scrooloose/nerdtree')
call dein#add('rizzatti/dash.vim')

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
" call dein#add('Valloric/YouCompleteMe', {'build': './install.py'})
call dein#add('SirVer/ultisnips')
" call dein#add('honza/vim-snippets')

" Markdown
call dein#add('plasticboy/vim-markdown')
call dein#add('iamcco/markdown-preview.vim')


" completion libraries
call dein#add('othree/html5.vim')
call dein#add('othree/yajs.vim', {'on_ft': 'javascript'})
call dein#add('othree/es.next.syntax.vim', {'on_ft': 'javascript'})

call dein#add('ervandew/supertab')

" call dein#add('junegunn/fzf')
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

" let g:ycm_key_list_select_completion = ['<Down>']
" let g:ycm_key_list_previous_completion = ['<Up>']
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
" imap <cr> <esc>o



nmap <leader>in :call dein#install()<cr>

imap <c-q> <c-y>,
" imap <c-r> <c-y>,

" let g:ycm_semantic_triggers = {
"       \   'css': [ 're!^\s{4}', 're!:\s+' ],
"       \ }


nmap <leader>id :Dash<cr>
map <leader>o :NERDTreeToggle<CR>




" tabs
nmap L gt
nmap H gT

" nmap <leader>l :silent !echo Hello<cr>




" markdown
set shell=bash\ -i
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 0

" set to 1, the vim will open the preview window once enter the markdown
" let g:mkdp_auto_start = 1
let g:mkdp_path_to_chrome = "open -a Google\\ Chrome\\ Canary"

nmap <silent> <leader>m <Plug>MarkdownPreview

" TMUX
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/dotfiles/nvim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'


Plugin 'ap/vim-css-color'
Plugin 'w0rp/ale'
Plugin 'plasticboy/vim-markdown'

Plugin 'Chiel92/vim-autoformat'

Plugin 'itchyny/calendar.vim'


Plugin 'danro/rename.vim'


Plugin 'jmcantrell/vim-virtualenv'
" Plugin 'vim-airline/vim-airline'



" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


let g:calendar_google_calendar = 1
let g:calendar_google_task = 1

" go
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim


" python
let g:formatter_yapf_style = 'pep8'


" au BufWrite * :Autoformat
noremap <leader>f :Autoformat<CR>


:set nowrap

" styling
:hi TabLineFill  ctermfg=60
:hi TabLineSel      ctermfg=17 ctermbg=11 cterm=NONE
:hi TabLine   ctermfg=8 ctermbg=14 cterm=NONE



" :hi TabLineFill ctermfg=LightGreen ctermbg=DarkGreen
" :hi TabLine ctermfg=Blue ctermbg=Yellow
" :hi TabLineSel ctermfg=Red ctermbg=Yellow
"
" let g:neomake_error_sign = {
"             \ 'text': '>>',
"             \ 'texthl': 'ErrorMsg',
"             \ }
" hi MyWarningMsg ctermbg=9 ctermfg=0
" let g:neomake_warning_sign = {
"             \ 'text': '>>',
"             \ 'texthl': 'MyWarningMsg',
"             \ }
"
"


let g:ale_sign_error = '✖'
" let g:ale_sign_warning = '❕'
let g:ale_sign_warning = '✖'

let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']

hi SignColumn ctermbg=none
" To have the same color as Directory group
hi! link ALEError Directory

let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

" ale
" Use your own colors
hi ALEError ctermfg=none ctermbg=none 
hi ALEWarning ctermfg=none ctermbg=none 
hi ALEErrorSign ctermfg=red ctermbg=none 
hi ALEWarningSign ctermfg=gray ctermbg=none 

" markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1


" css completion
" let g:ycm_semantic_triggers = {
"     \   'css': [ 're!^\s{4}', 're!:\s+' ],
"     \ }



" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.local/share/nvim/plugged')




" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }



" Plug 'davidhalter/jedi-vim'

Plug 'tmux-plugins/vim-tmux-focus-events'






" Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Using a non-master branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

" Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'

" Initialize plugin system
call plug#end()





let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

" let g:python_host_prog =  '/usr/local/bin/python'
"
"
"
"


 " Note: Skip initialization for vim-tiny or vim-small.
 if 0 | endif

 if &compatible
   set nocompatible               " Be iMproved
 endif

 " Required:
 set runtimepath+=~/.config/nvim/bundle/neobundle.vim/

 " Required:
 call neobundle#begin(expand('~/.config/nvim/bundle/'))

 " Let NeoBundle manage NeoBundle
 " Required:
 NeoBundleFetch 'Shougo/neobundle.vim'



NeoBundle 'mattn/gist-vim', {'depends': 'mattn/webapi-vim'}
NeoBundle 'junegunn/fzf'
NeoBundle 'junegunn/fzf.vim'
" NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'davidhalter/jedi-vim'

NeoBundle 'Valloric/MatchTagAlways'

NeoBundle 'Shougo/context_filetype.vim'


NeoBundle 'othree/html5.vim'


" Do not load vim-pyenv until *.py is opened and
" make sure that it is loaded after jedi-vim is loaded.
NeoBundleLazy 'lambdalisue/vim-pyenv', {
        \ 'depends': ['davidhalter/jedi-vim'],
        \ 'autoload': {
        \   'filetypes': ['python', 'python3'],
        \ }}

 " My Bundles here:
 " Refer to |:NeoBundle-examples|.
 " Note: You don't set neobundle setting in .gvimrc!

 call neobundle#end()

 " Required:
 filetype plugin indent on

 " If there are uninstalled bundles found on startup,
 " this will conveniently prompt you to install them.
 NeoBundleCheck



" aug omnicomplete
"   au!
"   au FileType css,sass,scss,stylus,less setl omnifunc=csscomplete#CompleteCSS
"   au FileType html,htmldjango,jinja,markdown setl omnifunc=emmet#completeTag
"   au FileType javascript,jsx,javascript.jsx setl omnifunc=tern#Complete
"   au FileType python setl omnifunc=pythoncomplete#Complete
"   au FileType xml setl omnifunc=xmlcomplete#CompleteTags
" aug END


" au FileType html setl omnifunc=csscomplete#CompleteCSS

let g:mta_use_matchparen_group = 1


let g:deoplete#auto_refresh_delay = 0
let g:deoplete#auto_complete_delay = 0


let g:tern#filetypes = [
                \ 'jsx',
                \ 'javascript.jsx',
                \ 'vue',
                \ '...'
                \ ]


" no popout for deoplete
set completeopt-=preview


" fzf
" Open files in vertical horizontal split
nnoremap <silent> <Leader>l :call fzf#run({
\   'right': winwidth('.') / 2,
\   'sink':  'vertical botright split' })<CR>
" Open files in horizontal split
nnoremap <silent> <Leader>s :call fzf#run({
\   'down': '40%',
\   'sink': 'botright split' })<CR>

" Tags

" search lines
function! s:line_handler(l)
  let keys = split(a:l, ':\t')
  exec 'buf' keys[0]
  exec keys[1]
  normal! ^zz
endfunction

function! s:buffer_lines()
  let res = []
  for b in filter(range(1, bufnr('$')), 'buflisted(v:val)')
    call extend(res, map(getbufline(b,0,"$"), 'b . ":\t" . (v:key + 1) . ":\t" . v:val '))
  endfor
  return res
endfunction

command! FZFLines call fzf#run({
\   'source':  <sid>buffer_lines(),
\   'sink':    function('<sid>line_handler'),
\   'options': '--extended --nth=3..',
\   'down':    '60%'
\})
