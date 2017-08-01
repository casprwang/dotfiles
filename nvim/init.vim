"   ____                    _      __     ___                      _
"  / ___|  ___  _ __   __ _( )___  \ \   / (_)_ __ ___  _ __ ___  | |
"  \___ \ / _ \| '_ \ / _` |// __|  \ \ / /| | '_ ` _ \| '__/ __| | |
"   ___) | (_) | | | | (_| | \__ \   \ V / | | | | | | | | | (__  |_|
"  |____/ \___/|_| |_|\__, | |___/    \_/  |_|_| |_| |_|_|  \___| (_)
"                     |___/
" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" **************************************************************************** 
" Author: Song Wang
" Github: https://github.com/wangsongiam/dotfiles
" **************************************************************************** 
" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" {{{ general settings
" ----------------------------------------------------------------------------
" Neovim
" set shell=/bin/bash
let s:editor_root=expand("~/.config/nvim")
" set the unique python virtual environment for neovim only
let g:python_host_prog = '/Users/wangsong/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/Users/wangsong/.pyenv/versions/neovim3/bin/python'
" ----------------------------------------------------------------------------
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
set nowrap
set smartindent
set splitright
set splitbelow
set timeoutlen=1000 ttimeoutlen=0
set noswapfile
set undoreload=10000        " number of lines to save for undo
set clipboard=unnamed
set list
set scrolloff=1
set autoread
set title
set guioptions-=e
set sessionoptions+=tabpages,globals
" set relativenumber
" set number
set hlsearch
"{{{ indentation
" ----------------------------------------------------------------------------
set autoindent
set expandtab
"}}}
set incsearch
set ignorecase
set smartcase
set showmatch
set smarttab
set undofile                " Save undo's after file closes
set undodir=~/.config/nvim/undo " where to save undo histories
set undolevels=1000         " How many undos
" }}}
" {{{ mapping 
"----------------------------------------------------------------------------
" vmap{{{
vmap J 5gj
vmap K 5gk
" yanking repositioning
vmap y y`]
" }}}
" imap{{{
inoremap <c-a> <esc>I
inoremap <c-b> <esc>Bi
inoremap <c-q> <esc>S
inoremap <c-f> <esc>Ea
inoremap <c-d> <esc>cw
inoremap <c-e> <esc>A
" }}}
let mapleader="\<Space>"
nnoremap <c-w><Space> <c-w>=
nnoremap <leader>in :PlugInstall<cr>
nnoremap <leader>j :w<cr>
nnoremap <CR> o<Esc>
nnoremap <S-Enter> O<Esc>
nnoremap <c-w>n <c-w>\|
nnoremap <leader>, za
nnoremap 0 ^
nnoremap <leader>r :!python3 %<cr>

" for git
nnoremap gp :!gp 

" for shift-enter
nnoremap <c-b>b O<esc>

" for returning position ater yanking
nmap <c-w>v :vsplit<cr><c-p>
nmap <c-w>s :split<cr><c-p>
nnoremap <c-w>l :vsplit<cr>
nnoremap <c-w>j :split<cr>
nnoremap <silent> <esc> :noh<cr>
nnoremap J 5gj
nnoremap K 5gk
" nnoremap L gt
" nnoremap H gT

nnoremap <leader>. :source ~/.config/nvim/init.vim<CR>:noh<cr>
" silver searcher
let g:ackprg = 'ag --vimgrep'
nnoremap <leader>e :Ag<cr>
" }}}
"{{{ Plugins (vim plug )
" ----------------------------------------------------------------------------
call plug#begin('~/.local/share/nvim/plugged')
"call plug#begin('~/.config/nvim/plugged')

"Plugging
Plug 'tpope/vim-commentary'
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } "{{{
"let g:deoplete#omni_patterns = {}
"let g:deoplete#omni_patterns.reason = '[^. *\t]\.\w*\|\h\w*|#'
"let g:deoplete#sources = {}
"let g:deoplete#sources.reason = ['omni', 'buffer']

"" neocomplete and YouCompleteMe work out of the box
""}}}
" Plug 'tpope/vim-markdown'
Plug 'szw/vim-maximizer' "{{{
let g:maximizer_set_default_mapping = 0
" nnoremap <silent> <c-w><cr> :MaximizerToggle<CR>
"}}}
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-entire'
Plug 'beloglazov/vim-textobj-quotes'
Plug 'jreybert/vimagit'
Plug 'wangsongiam/vim-git-it'
" Plug 'vimlab/split-term.vim'
Plug 'wvffle/vimterm' "{{{
Plug 'altercation/vim-colors-solarized'
" nnoremap <silent> <F4> :call vimterm#exec('g++  -o /tmp/out' . expand('%')) <CR>
" nnoremap <silent> <F5> :call vimterm#exec('/tmp/out') <CR>

nnoremap <c-^> :call vimterm#toggle() <CR>
tnoremap <c-^> <C-\><C-n>:call vimterm#toggle() <CR>
"}}}
" Plug 'kana/vim-textobj-function'
Plug 'christoomey/vim-tmux-navigator' " {{{ tmux navi
" ----------------------------------------------------------------------------
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <Down> :TmuxNavigateDown<cr>
nnoremap <silent> <Up> :TmuxNavigateUp<cr>
nnoremap <silent> <Right> :TmuxNavigateRight<cr>
" nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>
nnoremap <silent> <Left> :TmuxNavigateLeft<cr>
" }}}
Plug 'jreybert/vimagit'
Plug 'vim-scripts/mru.vim'
Plug 'alexlafroscia/postcss-syntax.vim'
Plug 'mattn/emmet-vim' " {{{
" emmet

imap <c-g> <esc><c-y>,i
" let g:user_emmet_leader_key='<C-o>'
let g:user_emme_settings = {
\  'javascript.jsx' : {
\      'extends' : 'jsx',
\  },
\}
"}}}
Plug 'benmills/vimux'
Plug 'kana/vim-textobj-indent'
" Plug 'nathanaelkane/vim-indent-guides'
Plug 'moll/vim-node'
Plug 'christoomey/vim-run-interactive'
" Plug 'chriskempson/base16-vim'
Plug 'gcmt/taboo.vim'
" React
Plug 'fleischie/vim-styled-components'
Plug 'elixir-lang/vim-elixir'
Plug 'SirVer/ultisnips'
Plug 'iamcco/markdown-preview.vim'
" markdown {{{
" let g:vim_markdown_folding_disabled = 1
" let g:vim_markdown_new_list_item_indent = 0
" let g:vim_markdown_folding_disabled = 1
" let g:vim_markdown_frontmatter = 1
let g:mkdp_path_to_chrome = "open -a Google\\ Chrome\\ Canary"
nmap <silent> <leader>m <Plug>MarkdownPreview
"}}}
Plug 'tmux-plugins/vim-tmux'
Plug 'hail2u/vim-css3-syntax', {'on_ft':['css','scss']}
" Plug 'ap/vim-css-color', {'on_ft':['css', 'scss']}
Plug 'chrisbra/Colorizer' "{{{
au BufNewFile,BufRead *.css,*.html,*.htm,*.js,*.jsx  :ColorHighlight!
"}}}
Plug 'scrooloose/nerdtree' "{{{
let g:NERDTreeWinPos = "right"  
nnoremap <silent> <leader>o :NERDTreeToggle<CR>
" nmap <leader>o -
"}}}
Plug 'othree/html5.vim'
Plug 'othree/yajs.vim', {'on_ft': 'javascript'}
Plug 'othree/es.next.syntax.vim', {'on_ft': 'javascript'}
" autoformat
Plug 'sbdchd/neoformat' "{{{

let g:neoformat_enabled_javascript = ['prettier']
autocmd FileType javascript setlocal formatprg=prettier\ --no-semi\ --stdin\ --parser\ flow\ --single-quote\ --trailing-comma\ es5
" Use formatprg when available
let g:neoformat_try_formatprg = 1
let g:neoformat_only_msg_on_error = 1
" noremap <leader>f :Neoformat<cr>
"}}}
Plug 'chenglou/vim-reason'
Plug 'kana/vim-smartinput'
" post install (yarn install | npm install) then load plugin only for editing supported files
Plug 'mitermayer/vim-prettier', {
	\ 'do': 'yarn install', 
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss'] } "{{{
" max line lengh that prettier will wrap on
nnoremap <leader>f :Prettier<cr>
let g:prettier#config#print_width = 80

" number of spaces per indentation level
let g:prettier#config#tab_width = 2

" use tabs over spaces
let g:prettier#config#use_tabs = 'false'

" print semicolons
let g:prettier#config#semi = 'false'

" single quotes over double quotes
let g:prettier#config#single_quote = 'true' 

" print spaces between brackets
let g:prettier#config#bracket_spacing = 'true' 

" put > on the last line instead of new line
let g:prettier#config#jsx_bracket_same_line = 'false' 

" none|es5|all
let g:prettier#config#trailing_comma = 'none'

" flow|babylon|typescript|postcss
let g:prettier#config#parser = 'flow'
"}}}
"Plug 'w0rp/ale' "{{{
"" no auto linting
"let g:ale_linter_aliases = {'reason': 'ocaml'}

"" ale style{{{
"" ----------------------------------------------------------------------------
"let g:ale_sign_error = '✖'
"let g:ale_sign_warning = '✖'
"let g:ale_statusline_format = ['    ✖ %d', '◘%d', '⬥ ok']
"hi SignColumn ctermbg=none
"hi! link ALEError Directory
"" }}}
"let g:ale_lint_on_text_changed = 'never'
"let g:ale_lint_on_enter = 0
"let g:ale_lint_on_save = 0

hi ALEError ctermfg=none ctermbg=none
hi ALEWarning ctermfg=none ctermbg=none
hi ALEErrorSign ctermfg=red ctermbg=none
hi ALEWarningSign ctermfg=gray ctermbg=none
"let g:ale_set_loclist = 0
"let g:ale_set_quickfix = 1
"" let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"" let g:ale_javascript_eslint_use_global=1
"" let g:formatdef_eslint = '"eslint --fix --stdin"'
"" let g:formatters_javascript = ['eslint']
"" let g:formatdef_xo_javascript = '"xo --fix --stdin"'
"" let g:formatters_javascript = ['xo_javascript']
"let g:ale_linters = {
"      \   'javascript': ['eslint'],
"      \   'html': ['htmlhint'],
"      \}

"let g:ale_html_htmlhint_use_global = 1 
"let g:ale_html_htmlhint_executable = 'htmlhint'
"let g:ale_html_htmlhint_options = '--format=unix'

"" for jsx
"augroup FiletypeGroup
"  autocmd!
"  au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
"augroup END
"" let g:ale_linters = {'jsx': ['stylelint', 'eslint']}
"" let g:ale_linter_aliases = {'jsx': 'css'}


"let g:ale_lint_delay = 400
"let g:ale_javascript_eslint_options = '--rule "semi: [0, never]"'
"let g:ale_lint_on_text_changed = 'never'
"let g:ale_sign_column_always = 0
"}}}"
Plug 'Chiel92/vim-autoformat' " {{{
" let g:formatter_yapf_style = 'pep9'
" " }}}
Plug 'danro/rename.vim'
Plug 'chriskempson/base16-vim'
Plug 'jmcantrell/vim-virtualenv'
Plug 'junegunn/goyo.vim' "{{{

let g:goyo_height = 105
let g:goyo_linenr = 1

function! s:goyo_enter()
  " silent !tmux set status off
  " silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  set noshowmode
  " hi! StatusLine ctermbg=249 ctermfg=235
  " set noshowcmd
  " set scrolloff=999
  " Limelight
  " ...
endfunction

function! s:goyo_leave()
  " silent !tmux set status on
  " silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  set showmode
  " hi! StatusLine ctermbg=249 ctermfg=235
  " set showcmd
  " set scrolloff=5
  " Limelight!
  " ...
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()


" nmap <Leader>g :Goyo 80-10x100<cr>
" nmap <Leader>g :Goyo<cr>
nnoremap <silent> <c-w><cr> :Goyo<cr>
"}}}
Plug 'https://github.com/junegunn/limelight.vim' "{{{
" nmap <Leader>gh :Limelight!!<cr>
" xmap <Leader>g :Limelight!!<cr>:Goyo<cr>
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

" Default: 0.5
let g:limelight_default_coefficient = 0.7

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 1

" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1
"}}}
Plug 'ruanyl/vim-fixmyjs' " {{{
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
" noremap <leader>f :Fixmyjs<CR>
"}}}
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'othree/csscomplete.vim'
Plug 'tpope/vim-fugitive' "{{{
nnoremap gi :Gstatus<cr>
nnoremap gp :Gpush<cr>
nnoremap gm :Gcommit<cr>
nnoremap gd :Gdiff<cr>
nnoremap gb :Gblame<cr>
nnoremap go :Gbrowse<cr>
"}}}
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter' "{{{
let g:gitgutter_enabled = 1
nnoremap <leader>h :GitGutterToggle<cr>
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
let g:gitgutter_signs = 0
"}}}
Plug 'junegunn/vim-easy-align' "{{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
" }}}
Plug 'jiangmiao/auto-pairs' "{{{
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'} 
au Filetype scss let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`' }
" au Filetype jsx let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`' }
" au Filetype javascript let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`' }
" au Filetype js let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`' }
au Filetype html let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`' , '>':'<'}
au Filetype css let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'}
au Filetype python let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'}
let g:AutoPairsFlyMode = 0
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
Plug 'roxma/nvim-completion-manager', {'do': 'npm install'} "{{{
" set shortmess+=c
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
let g:UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
" css
" the omnifunc pattern is PCRE
let g:cm_matcher = {'module': 'cm_matchers.fuzzy_matcher', 'case': 'smartcase'}
au User CmSetup call cm#register_source({'name' : 'cm-css',
        \ 'priority': 5, 
        \ 'scopes': ['css', 'scss', 'js', 'javascript'],
        \ 'scoping': 1,
        \ 'abbreviation': 'css',
        \ 'cm_refresh_patterns':['\w{2,}$',':\s+\w*$'],
        \ 'cm_refresh': {'omnifunc': 'csscomplete#CompleteCSS'},
        \ })

let g:cm_sources_override = {
    \ 'cm-css': {'scopes': ['css', 'scss', 'javascript', 'jsx', 'javascript.jsx']}
    \ }

let g:cm_refresh_default_min_word_len=1
imap <silent> <c-o> <c-r>=cm#sources#ultisnips#trigger_or_popup("\<Plug>(ultisnips_expand)")<cr>
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"}}}"
Plug 'roxma/nvim-cm-php-language-server',  {'do': 'composer install && composer run-script parse-stubs'}
Plug 'roxma/nvim-cm-tern',  {'do': 'npm install'}

" Async
Plug 'skywind3000/asyncrun.vim'

" for swift
Plug 'sheerun/vim-polyglot' "{{{
" let g:polyglot_disabled = ['javascript']
" }}}
Plug 'mxw/vim-jsx'
" Plug 'pangloss/vim-javascript'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/ElmCast/elm-vim' "{{{
let g:elm_setup_keybindings = 0
" }}}
Plug 'mattn/gist-vim'
Plug 'tpope/vim-vinegar'
Plug 'mattn/webapi-vim'
Plug 'junegunn/fzf.vim' " fzf{{{
" ----------------------------------------------------------------------------
" ----------------------------------------------------------------------------
nmap <c-f> :Lines<cr>
set noswapfile
set clipboard=unnamed
set autoread
" show autocomplete for commands
set wildmenu
map <leader>b :Buffers<cr>
map <c-p> :FZF<cr>

let g:fzf_layout = { 'window': 'enew' }
" let g:fzf_layout = { 'window': '-tabnew' }


" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'down': 'split',
  \ 'right': 'vsplit' }

" Open files in vertical split
" nnoremap <silent> <c-w>v :call fzf#run({
"       \   'right': winwidth('.') / 2,
"       \   'sink':  'vertical botright split' })<CR>

" Open files in horizontal split
" nnoremap <silent> <c-w>s :call fzf#run({
"       \   'down': '50%',
"       \   'sink': 'split' })<CR>

" Open files in anoter tab
nnoremap <silent> <c-w>t :call fzf#run({
      \   'tab': 'tabnew',
      \   'sink': 'tabnew' })<CR>

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

function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

" including hidden files
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'

autocmd! User FzfStatusLine call <SID>fzf_statusline()
" }}}
 Plug 'roxma/python-support.nvim' "{{{
 " for python completions
 let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'jedi')
 " language specific completions on markdown file
 let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'mistune')
 let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'flake8')
 let g:python_support_python2_requirements = add(get(g:,'python_support_python2_requirements',[]),'flake8')
 " utils, optional
 let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'psutil')
 let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'setproctitle')
"}}}
Plug 'Valloric/MatchTagAlways' "{{{
let g:mta_filetypes = {
    \ 'javascript.jsx': 1,
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \}
"}}}
Plug 'othree/html5.vim'
Plug 'mattn/gist-vim', {'depends': 'mattn/webapi-vim'}
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Plug 'davidhalter/jedi-vim'
Plug 'Valloric/MatchTagAlways' "{{{
let g:mta_filetypes = {
    \ 'javascript.jsx': 1,
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \}
"}}}
Plug 'othree/html5.vim'
Plug 'sunaku/vim-shortcut'
call plug#end()
" }}}
" cursor position {{{
" ----------------------------------------------------------------------------
autocmd BufReadPost *
      \ if line("'\"") > 0 && line ("'\"") <= line("$") |
      \   exe "normal! g'\"" |
      \ endif
" center buffer around cursor when opening files
autocmd BufRead * normal zz
" }}}
"status bar{{{
" ----------------------------------------------------------------------------
set laststatus=2
" set filename on the left side
set statusline=%f
" line separator
set statusline+=%=
" set gitgutter on the right side
set statusline+=%{join(GitGutterGetHunkSummary())}
        " Switch to the right side
" set statusline+=%l        " Current line
" set statusline+=/         " Separator
" set statusline+=%L        " Total lines
" set statusline=%{join(GitGutterGetHunkSummary())}
"}}}
" completion {{{
"----------------------------------------------------------------------------
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
" let g:UltiSnipsListSnippets="<c-e>"
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

" better key bindings for UltiSnipsExpandTrigger
" let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" let g:ycm_key_list_select_completion = ['<Down>']
" let g:ycm_key_list_previous_completion = ['<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
" }}}
" {{{ omni
" ----------------------------------------------------------------------------
" aug omnicomplete
"   au!
"   au FileType css,sass,scss,stylus,less setl omnifunc=csscomplete#CompleteCSS
"   au FileType html,htmldjango,jinja,markdown setl omnifunc=emmet#completeTag
"   au FileType javascript,jsx,javascript.jsx setl omnifunc=tern#Complete
"  au FileType python setl omnifunc=pythoncomplete#Complete
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
" folding {{{
" ----------------------------------------------------------------------------
" set foldmethod=indent
" set foldlevelstart=1

" let javaScript_fold=2         " JavaScript
" autocmd FileType javascript setlocal foldlevel=2
" autocmd FileType txt setlocal foldmethod=marker
" setlocal foldmethod=marker
" autocmd FileType javascript,typescript,json setl foldmethod=syntax
" :set filetype?
" }}}
"{{{  markdown
au BufRead,BufNewFile *.md setlocal textwidth=80

function! MarkdownLevel()
    if getline(v:lnum) =~ '^## .*$'
        return ">1"
    endif
    if getline(v:lnum) =~ '^### .*$'
        return ">2"
    endif
    if getline(v:lnum) =~ '^#### .*$'
        return ">3"
    endif
    if getline(v:lnum) =~ '^##### .*$'
        return ">4"
    endif
    if getline(v:lnum) =~ '^###### .*$'
        return ">5"
    endif
    return "=" 
endfunction
au BufEnter *.md setlocal foldexpr=MarkdownLevel()  
au BufEnter *.md setlocal foldmethod=expr
" set formatoptions+=a
" let g:vim_markdown_folding_style_pythonic = 1
" {{{
" function! MarkdownLevel()
"     if getline(v:lnum) =~ '^# .*$'
"         return ">1"
"     endif
"     if getline(v:lnum) =~ '^## .*$'
"         return ">2"
"     endif
"     if getline(v:lnum) =~ '^### .*$'
"         return ">3"
"     endif
"     if getline(v:lnum) =~ '^#### .*$'
"         return ">4"
"     endif
"     if getline(v:lnum) =~ '^##### .*$'
"         return ">5"
"     endif
"     if getline(v:lnum) =~ '^###### .*$'
"         return ">6"
"     endif
"     return "=" 
" endfunction
" au BufEnter *.md setlocal foldexpr=MarkdownLevel()  
" au BufEnter *.md setlocal foldmethod=expr 
" }}}

"}}}
" {{{ Contextual commenting for commentary.vim in jsx files.
function! s:SetCommentString()
  let stack = map(synstack(line("."), col(".")), "synIDattr(synIDtrans(v:val), 'name')")
  let cstr=&commentstring
  for id in stack
    if id[0:1] ==# "js"
      let cstr="//%s"
    endif
    if id[0:2] ==# "jsx"
      let cstr="{/*%s*/}"
    endif
  endfor
  let &commentstring=cstr
endfunction

autocmd CursorMoved *.jsx call s:SetCommentString()
autocmd CursorMoved *.js call s:SetCommentString()
"}}}
"{{{ merlin, ocaml and reason
" In your ~/.vimrc
if executable('ocamlmerlin')
  " To set the log file and restart:
  let s:ocamlmerlin=substitute(system('which ocamlmerlin'),'ocamlmerlin\n$','','') . "../share/merlin/vim/"
  execute "set rtp+=".s:ocamlmerlin
  let g:syntastic_ocaml_checkers=['merlin']
endif
if executable('refmt')
  let s:reason=substitute(system('which refmt'),'refmt\n$','','') . "../share/reason/editorSupport/VimReason"
  execute "set rtp+=".s:reason
  let g:syntastic_reason_checkers=['merlin']
endif
"" Always wrap at 90 columns
let g:vimreason_extra_args_expr_reason = '"--print-width 90"'

" Wrap at the window width
let g:vimreason_extra_args_expr_reason = '"--print-width " . ' .  "winwidth('.')"

" Wrap at the window width but not if it exceeds 120 characters.
let g:vimreason_extra_args_expr_reason = '"--print-width " . ' .  "min([120, winwidth('.')])"


let g:deoplete#enable_at_startup = 0


" autocmd FileType reason map <buffer> <D-M> :ReasonPrettyPrint<Cr>
let g:merlin_completion_arg_type = "always"
" nnoremap <leader>t :MerlinTypeOf<cr>

autocmd FileType reason let maplocalleader=","
autocmd FileType ocaml let maplocalleader=","
"}}}
"{{{ autocmd
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype css setlocal ts=2 sts=2 sw=2
autocmd Filetype scss setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype jsx setlocal ts=2 sts=2 sw=2
autocmd Filetype js setlocal ts=2 sts=2 sw=2
" autocmd FileType vim setlocal foldmethod=marker
set ts=2 sts=2 sw=2
autocmd FileType vim setlocal foldmethod=marker
autocmd Filetype python setlocal ts=4 sts=4 sw=4
autocmd Filetype json setlocal ts=2 sts=2 sw=2
"}}}
"{{{ git functions
" one line commiting and pushing everything
nnoremap <leader>p :Gitit 
" one line commiting current file with message
nnoremap <leader>c :GititCommit 
"}}}
"{{{ colorscheme
" ----------------------------------------------------------------------------
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
syntax enable
set background=dark
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
" let g:hybrid_custom_term_colors = 1
" let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
"}}}
