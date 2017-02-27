" ============================================================================
"   ____                    _      __     ___                      _
"  / ___|  ___  _ __   __ _( )___  \ \   / (_)_ __ ___  _ __ ___  | |
"  \___ \ / _ \| '_ \ / _` |// __|  \ \ / /| | '_ ` _ \| '__/ __| | |
"   ___) | (_) | | | | (_| | \__ \   \ V / | | | | | | | | | (__  |_|
"  |____/ \___/|_| |_|\__, | |___/    \_/  |_|_| |_| |_|_|  \___| (_)
"                     |___/
" ============================================================================
" 
" 
" {{{ general settings
" ----------------------------------------------------------------------------
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
:set nowrap
set timeoutlen=1000 ttimeoutlen=0
set noswapfile
set undoreload=10000        " number of lines to save for undo
set clipboard=unnamed
set autoread
set relativenumber
set number
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
set smarttab
set undofile                " Save undo's after file closes
set undodir=~/.config/nvim/undo " where to save undo histories
set undolevels=1000         " How many undos
set expandtab
set shiftwidth=2
set softtabstop=2
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'
let s:editor_root=expand("~/.config/nvim")
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype python setlocal ts=4 sts=4 sw=4
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
" }}}
" {{{ mapping 
" ----------------------------------------------------------------------------
let mapleader="\<Space>"
nmap <leader>in :PlugInstall<cr>
nmap <leader>id :Dash<cr>
nmap <leader>o :NERDTreeToggle<CR>
map <leader>j :w<cr>
inoremap <C-e> <C-o>$
nmap <CR> o<Esc>
imap <c-r> <bs>
nmap <S-Enter> O<Esc>
nmap <c-w>v <c-w>v<right>
nmap <c-w>l <c-w>v
nmap <c-w>j <c-w>s<down>
nmap <esc> :noh<cr>
nnoremap <bs> <c-r>
nnoremap J 5gj
nnoremap K 5gk
vmap J 5gj
vmap K 5gk
nnoremap <leader>. :source ~/.config/nvim/init.vim<CR>
" }}}
"{{{ Plugins
"dein{{{
" ----------------------------------------------------------------------------
if &compatible
  set nocompatible               " Be iMproved
endif
" Required:
set runtimepath+=/Users/wangsong/.config/nvim/dein/repos/github.com/Shougo/dein.vim
" Required:
call dein#begin('/Users/wangsong/.config/nvim/dein')
" Required:
call dein#add('Shougo/dein.vim')
call dein#add('tpope/vim-commentary')
call dein#add('hail2u/vim-css3-syntax', {'on_ft':['css','scss']})
call dein#add('scrooloose/nerdtree')
call dein#add('rizzatti/dash.vim')
call dein#add('kana/vim-textobj-user')
call dein#add('kana/vim-textobj-line')
call dein#add('kana/vim-textobj-entire')
call dein#add('beloglazov/vim-textobj-quotes')
call dein#add('kana/vim-textobj-function')
call dein#add('christoomey/vim-tmux-navigator')
call dein#add('mattn/emmet-vim') " {{{
" emmet
imap <c-f> <c-y>,
"}}}
call dein#add('SirVer/ultisnips')
call dein#add('plasticboy/vim-markdown')
call dein#add('iamcco/markdown-preview.vim')
" markdown {{{
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_frontmatter = 1
let g:mkdp_path_to_chrome = "open -a Google\\ Chrome\\ Canary"
nmap <silent> <leader>m <Plug>MarkdownPreview
"}}}
call dein#add('othree/html5.vim')
call dein#add('othree/yajs.vim', {'on_ft': 'javascript'})
call dein#add('othree/es.next.syntax.vim', {'on_ft': 'javascript'})
call dein#add('ervandew/supertab')
" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"}}}
"bundle {{{
" ----------------------------------------------------------------------------
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
Plugin 'kana/vim-smartinput'
Plugin 'w0rp/ale'
Plugin 'plasticboy/vim-markdown'
Plugin 'Chiel92/vim-autoformat' " {{{
let g:formatter_yapf_style = 'pep9'
" }}}
Plugin 'itchyny/calendar.vim' " {{{
let g:calendar_google_calendar = 1
let g:calendar_google_task = 1
" }}}
Plugin 'danro/rename.vim'
Plugin 'jmcantrell/vim-virtualenv'
call vundle#end()            " required
filetype plugin indent on    " required
" }}}
" vimplug {{{
" ----------------------------------------------------------------------------
call plug#begin('~/.local/share/nvim/plugged')
Plug 'Shougo/deol.nvim'
Plug 'ruanyl/vim-fixmyjs'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'nsf/gocode', {'rtp': 'nvim/'}
Plug 'othree/csscomplete.vim'
Plug 'kristijanhusak/vim-hybrid-material'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'jiangmiao/auto-pairs' "{{{
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'} 
au Filetype scss let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`' }
au Filetype html let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`' , '>':'<'}
au Filetype css let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'}
" let g:AutoPairsFlyMode = 1
"}}}
"Plug 'vim-airline/vim-airline-themes' "{{{
"let g:airline_powerline_fonts = 1
"let g:airline_theme = "tomorrow"
"" let g:airline_section_c = '%t'
"" let g:airline_section_c = '%t %{GetFileSize()} (%{GetCwd()})'
"let g:airline_left_sep = ''        " Remove arrow symbols.
"let g:airline_left_alt_sep = ''    " Remove arrow symbols.
"let g:airline_right_sep = ''       " Remove arrow symbols.
"let g:airline_right_alt_sep = ''   " Remove arrow symbols.
"let g:airline_skip_empty_sections = 1
"let g:airline_inactive_collapse=1
"let g:airline_mode_map = {
"      \ '__' : '-',
"      \ 'n'  : 'N',
"      \ 'i'  : 'I',
"      \ 'R'  : 'R',
"      \ 'c'  : 'C',
"      \ 'v'  : 'V',
"      \ 'V'  : 'V',
"      \ '' : 'V',
"      \ 's'  : 'S',
"      \ 'S'  : 'S',
"      \ '' : 'S',
"      \ }
"let g:airline_section_y = 0  
"let g:airline_section_b = 0
"let g:airline_section_warning = 0
"" let g:airline_section_z = '%l/%L'
"let g:airline_section_z = 0
"let g:airline_section_z = '%3p%%'
""}}}
Plug 'roxma/nvim-completion-manager', {'do': 'npm install'}
Plug 'roxma/nvim-cm-php-language-server',  {'do': 'composer install && composer run-script parse-stubs'}
Plug 'roxma/nvim-cm-tern',  {'do': 'npm install'}
Plug 'ternjs/tern_for_vim'

Plug 'mxw/vim-jsx'
call plug#end()
" }}}
" NeoBundle{{{
" ----------------------------------------------------------------------------
" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif
if &compatible
set nocompatible               " Be iMproved
endif
" Required:
set runtimepath+=~/.config/nvim/bundle/neobundle.vim/
" Required:
call neobundle#begin(expand('~/.config/nvim/bundle/'))
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'mattn/gist-vim', {'depends': 'mattn/webapi-vim'}
NeoBundle 'junegunn/fzf'
NeoBundle 'junegunn/fzf.vim'
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'Valloric/MatchTagAlways'
" NeoBundle 'Shougo/context_filetype.vim'
NeoBundle 'othree/html5.vim'
NeoBundleLazy 'lambdalisue/vim-pyenv', {
      \ 'depends': ['davidhalter/jedi-vim'],
      \ 'autoload': {
      \   'filetypes': ['python', 'python3'],
      \ }}
call neobundle#end()
" Required:
filetype plugin indent on
NeoBundleCheck
" }}}
"}}}
" cursor {{{
" ----------------------------------------------------------------------------
autocmd BufReadPost *
      \ if line("'\"") > 0 && line ("'\"") <= line("$") |
      \   exe "normal! g'\"" |
      \ endif
" center buffer around cursor when opening files
autocmd BufRead * normal zz
" }}}
"{{{ indentation
" ----------------------------------------------------------------------------
set autoindent
set copyindent
set expandtab
set smartindent
"}}}
"{{{ color hybrid
" ----------------------------------------------------------------------------
syntax enable
set background=dark
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
colorscheme hybrid
" set background=light
" colorscheme hybrid_material
"}}}
"status bar{{{
" ----------------------------------------------------------------------------
" set laststatus=2
" set statusline=%f         " Path to the file
" :set statusline+=/    " Separator
" set statusline+=%{ALEGetStatusLine()}
" set statusline+=%=        " Switch to the right side
" set statusline+=%l        " Current line
" set statusline+=/         " Separator
" set statusline+=%L        " Total lines
"}}}
" completion {{{
" ----------------------------------------------------------------------------
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
" }}}
" {{{ tmux navi
" ----------------------------------------------------------------------------
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <Down> :TmuxNavigateDown<cr>
nnoremap <silent> <Up> :TmuxNavigateUp<cr>
nnoremap <silent> <Right> :TmuxNavigateRight<cr>
nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>
nnoremap <silent> <Left> :TmuxNavigateLeft<cr>
" }}}
" style{{{
" ----------------------------------------------------------------------------
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '✖'
let g:ale_statusline_format = ['    ✖ %d', '◘%d', '⬥ ok']
hi SignColumn ctermbg=none
hi! link ALEError Directory
" }}}
" {{{ omni
" ----------------------------------------------------------------------------
" aug omnicomplete
"   au!
"   au FileType css,sass,scss,stylus,less setl omnifunc=csscomplete#CompleteCSS
"   au FileType html,htmldjango,jinja,markdown setl omnifunc=emmet#completeTag
"   au FileType javascript,jsx,javascript.jsx setl omnifunc=tern#Complete
"   au FileType python setl omnifunc=pythoncomplete#Complete
"   au FileType xml setl omnifunc=xmlcomplete#CompleteTags
" aug END
let g:mta_use_matchparen_group = 1
let g:tern#filetypes = [
      \ 'jsx',
      \ 'js',
      \ 'javascript.jsx',
      \ 'vue',
      \ '...'
      \ ]
" }}}
" fzf{{{
" ----------------------------------------------------------------------------
" ----------------------------------------------------------------------------
nmap <leader>p :Windows<cr>
nmap <c-f> :Lines<cr>
set noswapfile
set clipboard=unnamed
set autoread
" show autocomplete for commands
set wildmenu
map <c-p> :FZF<cr>
nnoremap <silent> <c-w>v :call fzf#run({
      \   'right': winwidth('.') / 2,
      \   'sink':  'vertical botright split' })<CR>
" Open files in horizontal split
nnoremap <silent> <c-w>s :call fzf#run({
      \   'down': '40%',
      \   'sink': 'botright split' })<CR>
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
" }}}
" folding {{{
" ----------------------------------------------------------------------------
autocmd FileType vim setlocal foldmethod=marker
" autocmd FileType vim setlocal foldlevel=2
" autocmd FileType txt setlocal foldmethod=marker
" setlocal foldmethod=marker
" nmap <leader><leader> za
" autocmd FileType javascript,typescript,json setl foldmethod=syntax
" :set filetype?
" }}}
" {{{ fixmyjs
" ----------------------------------------------------------------------------
" let g:formatterpath = ['/usr/local/bin/standard']
" let g:formatdef_standard_javascript = '"standard --fix --stdin"'
" let g:formatters_javascript = ['standard_javascript']
let g:formatters_javascript = ['eslint_javascript']
let g:formatdef_eslint_javascript = '"standard --fix --stdin"'
" let g:fixmyjs_engine = 'eslint' 
let g:fixmyjs_engine = 'eslint'

" let g:fixmyjs_executable = '/Users/wangsong/dev/node/node_modules/.bin/eslint'
" let g:fixmyjs_rc_path = '/Users/wangsong/dev/node/.eslintrc.js'
" let g:fixmyjs_rc_path = '/Users/wangsong/temp/.eslintrc.js'
let g:fixmyjs_rc_path = '~/.eslintrc.js'
" let g:fixmyjs_use_local = 1
noremap <leader>f :Fixmyjs<CR>
"}}}
" NCM {{{
" ----------------------------------------------------------------------------
set shortmess+=c
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
let g:UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
" css
" the omnifunc pattern is PCRE
let g:cm_matcher = {'module': 'cm_matchers.fuzzy_matcher', 'case': 'smartcase'}
au User CmSetup call cm#register_source({'name' : 'cm-css',
        \ 'priority': 9, 
        \ 'scopes': ['css', 'scss'],
        \ 'scoping': 1,
        \ 'abbreviation': 'css',
        \ 'cm_refresh_patterns':['\w{2,}$',':\s+\w*$'],
        \ 'cm_refresh': {'omnifunc': 'csscomplete#CompleteCSS'},
        \ })
let g:cm_sources_override = {
    \ 'cm-tags': {'enable':0}
    \ }

inoremap <silent> <c-o> <c-r>=cm#sources#ultisnips#trigger_or_popup("\<Plug>(ultisnips_expand)")<cr>
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" }}}
" ale {{{
" ----------------------------------------------------------------------------
hi ALEError ctermfg=none ctermbg=none
hi ALEWarning ctermfg=none ctermbg=none
hi ALEErrorSign ctermfg=red ctermbg=none
hi ALEWarningSign ctermfg=gray ctermbg=none
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
" let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" let g:ale_javascript_eslint_use_global=1
" let g:formatdef_eslint = '"eslint --fix --stdin"'
" let g:formatters_javascript = ['eslint']
" let g:formatdef_xo_javascript = '"xo --fix --stdin"'
" let g:formatters_javascript = ['xo_javascript']
let g:ale_linters = {
      \   'javascript': ['eslint'],
      \}

" " for jsx
" augroup FiletypeGroup
"   autocmd!
"   au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
" augroup END
" let g:ale_linters = {'jsx': ['stylelint', 'eslint']}
" let g:ale_linter_aliases = {'jsx': 'css'}


let g:ale_lint_delay = 100
let g:ale_javascript_eslint_options = '--rule "semi: [0, never]"'
"}}}
