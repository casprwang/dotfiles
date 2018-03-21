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
" virtual env https://github.com/zchee/deoplete-jedi/wiki/Setting-up-Python-for-Neovim
let g:python3_host_prog  = '/Users/song/.pyenv/versions/neovim3/bin/python'
let g:python_host_prog = '/Users/song/.pyenv/versions/neovim2/bin/python'

set viminfo='100,<50,s10,h,%

let s:editor_root=expand("~/.config/nvim")
set nowrap
set smartindent
set splitright
set splitbelow
set timeoutlen=1000 ttimeoutlen=0
set noswapfile
" set relativenumber
" set number
set undoreload=10000        " number of lines to save for undo
set clipboard=unnamed
set list
set scrolloff=1
set autoread
set title
set guioptions-=e
set sessionoptions+=tabpages,globals
set hlsearch
set autoindent
set expandtab
set incsearch
set ignorecase
set smartcase
set showmatch
set smarttab
set smartindent
set undofile
set undodir=~/.config/nvim/undo
set undolevels=1000

" cursor Nvim > v-2.0

set guicursor=n-v-c:block-Cursor/lCursor-blinkon0
                        \,i-ci:ver25-Cursor/lCursor
                        \,r-cr:hor20-Cursor/lCursor
" }}}
" {{{ mapping
let mapleader="\<Space>"

vmap y y`]

inoremap <c-a> <esc>I
inoremap <c-b> <esc>Bi
inoremap <c-q> <esc>S
inoremap <c-f> <esc>Ea
inoremap <c-d> <esc>cw
inoremap <c-e> <esc>A
inoremap {<cr> {<cr>}<c-o>O

nnoremap <c-w><Space> <c-w>=
nnoremap <leader>in :PlugInstall<cr>
nnoremap <leader>j :w<cr>
nnoremap <CR> o<Esc>
nnoremap <S-Enter> O<Esc>
nnoremap <c-w>n <c-w>\|
nnoremap <leader>, za
nnoremap 0 ^
nmap Y y$

" for git
nnoremap gp :!gp

" for shift-enter
nnoremap <c-b>b O<esc>

nmap <c-w>v :vsplit<cr><c-_>
nmap <c-w>s :split<cr><c-_>
nnoremap <c-w>l :vsplit<cr>
nnoremap <c-w>j :split<cr>
nnoremap <silent> <esc> :noh<cr>
nnoremap <leader>. :source ~/.config/nvim/init.vim<CR>:noh<cr>

nmap J 5gj
nmap K 5gk
vmap J 5gj
vmap K 5gk

" silver searcher
let g:ackprg = 'ag --vimgrep'
nnoremap <leader>e :Ag<cr>
" }}}
"{{{ Plugins (vim plug )
" ----------------------------------------------------------------------------
call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-commentary'
Plug 'scrooloose/nerdcommenter' "{{{
let g:ft = ''
function! NERDCommenter_before()
  if &ft == 'vue'
    let g:ft = 'vue'
    let stack = synstack(line('.'), col('.'))
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
        exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
      endif
    endif
  endif
endfunction
function! NERDCommenter_after()
  if g:ft == 'vue'
    setf vue
    let g:ft = ''
  endif
endfunction
"}}}
Plug 'szw/vim-maximizer' "{{{
let g:maximizer_set_default_mapping = 0
"}}}
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-entire'
Plug 'pangloss/vim-javascript' , { 'for': ['javascript', 'javascript.jsx', 'html', 'vue'] }
Plug 'endel/vim-github-colorscheme'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-indent'
Plug 'beloglazov/vim-textobj-quotes'
Plug 'rizzatti/dash.vim' "{{{
nnoremap <leader>K :Dash<cr>
"}}}
Plug 'wangsongiam/vim-git-it' "{{{
nnoremap <leader>p :Gitit
nnoremap <leader>m :GititCommitAll
"}}}
Plug 'altercation/vim-colors-solarized'
Plug 'wvffle/vimterm' "{{{
nnoremap <c-^> :call vimterm#toggle() <CR>
tnoremap <c-^> <C-\><C-n>:call vimterm#toggle() <CR>
"}}}
Plug 'thinca/vim-textobj-function-javascript'
Plug 'christoomey/vim-tmux-navigator' " {{{ tmux navi
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <Down> :TmuxNavigateDown<cr>
nnoremap <silent> <Up> :TmuxNavigateUp<cr>
nnoremap <silent> <Right> :TmuxNavigateRight<cr>
nnoremap <silent> <Left> :TmuxNavigateLeft<cr>
" }}}
Plug 'jreybert/vimagit'
Plug 'vim-scripts/mru.vim'
Plug 'alexlafroscia/postcss-syntax.vim'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' } "{{{
let g:go_term_enabled = 1
let g:go_term_width = 80
let g:go_fmt_autosave = 0
let g:go_metalinter_autosave = 0
au FileType go nmap <leader>r <Plug>(go-run-tab)
"}}}
Plug 'nsf/gocode', { 'rtp': 'nvim', 'do': '~/.local/share/nvim/plugged/gocode/nvim/symlink.sh' }
Plug 'mattn/emmet-vim' " {{{
imap <c-g> <esc><c-y>,i
let g:user_emme_settings = {
                        \  'javascript.jsx' : {
                        \      'extends' : 'jsx',
                        \  },
                        \}
"}}}
Plug 'benmills/vimux'
Plug 'arcticicestudio/nord-vim'
Plug 'moll/vim-node'
Plug 'christoomey/vim-run-interactive'
Plug 'gcmt/taboo.vim'
Plug 'derekwyatt/vim-scala'
Plug 'fleischie/vim-styled-components'
Plug 'elixir-lang/vim-elixir'
Plug 'SirVer/ultisnips'
Plug 'iamcco/markdown-preview.vim' "{{{
let g:mkdp_path_to_chrome = "open -a Google\\ Chrome\\ Canary"
"}}}
Plug 'tmux-plugins/vim-tmux'
Plug 'hail2u/vim-css3-syntax', {'on_ft':['css','scss']}
Plug 'chrisbra/Colorizer' "{{{
au BufNewFile,BufRead *.css,*.html,*.htm,*.js,*.jsx  :ColorHighlight!
"}}}
Plug 'scrooloose/nerdtree' "{{{
let g:NERDTreeWinPos = "right"
nnoremap <silent> <leader>o :NERDTreeToggle<CR>
let NERDTreeIgnore=['node_modules']
"}}}
Plug 'othree/html5.vim'
Plug 'othree/yajs.vim', {'on_ft': 'javascript'}
Plug 'othree/es.next.syntax.vim', {'on_ft': 'javascript'}
" autoformat
Plug 'mitermayer/vim-prettier', {
                        \ 'do': 'yarn install',
                        \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss'] } "{{{
" max line lengh that prettier will wrap on
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
let g:prettier#config#trailing_comma = 'all'

" flow|babylon|typescript|postcss
let g:prettier#config#parser = 'flow'
"}}}
Plug 'sbdchd/neoformat' "{{{


let g:neoformat_enabled_javascript = ['eslint_d', 'prettier']
let g:neoformat_try_formatprg = 1
let g:neoformat_only_msg_on_error = 1
noremap <leader>f :Neoformat<cr>

let g:neoformat_enabled_python = ['autopep8']
let g:neoformat_python_autopep8 = {
                        \ 'exe': 'autopep8',
                        \ }

"}}}
Plug 'chenglou/vim-reason'
Plug 'kana/vim-smartinput'
Plug 'Chiel92/vim-autoformat'
Plug 'danro/rename.vim'
Plug 'chriskempson/base16-vim'
Plug 'jmcantrell/vim-virtualenv'
Plug 'szw/vim-maximizer' "{{{
nnoremap <silent> <c-w><cr> :MaximizerToggle<cr>
"}}}
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'keith/investigate.vim' "{{{
let g:investigate_use_dash=1
"}}}

Plug 'othree/csscomplete.vim'
Plug 'tpope/vim-fugitive' "{{{
nnoremap gi :Gstatus<cr>
nnoremap gd :Gdiff<cr>
nnoremap gb :Gblame<cr>
nnoremap go :Gbrowse<cr>
"}}}
Plug 'tpope/vim-rhubarb'
"Plug 'easymotion/vim-easymotion' "{{{
"nmap J <Plug>(easymotion-j)
"nmap K <Plug>(easymotion-k)
"vmap J <Plug>(easymotion-j)
"vmap K <Plug>(easymotion-k)
""}}}
Plug 'airblade/vim-gitgutter' "{{{
let g:gitgutter_enabled = 1
nnoremap <leader>h :GitGutterToggle<cr>
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
let g:gitgutter_signs = 0
"}}}
Plug 'junegunn/vim-easy-align' "{{{
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" }}}
Plug 'jiangmiao/auto-pairs' "{{{
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'}
au Filetype scss let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`' }
au Filetype html let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`' , '>':'<'}
au Filetype css let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'}
au Filetype python let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'}
let g:AutoPairsFlyMode = 0
"}}}
Plug 'jiangmiao/simple-javascript-indenter'
Plug 'roxma/nvim-completion-manager', {'do': 'npm install'} "{{{
" set shortmess+=c
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
let g:UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
" css
" the omnifunc pattern is PCRE
let g:cm_matcher = {'module': 'cm_matchers.fuzzy_matcher', 'case': 'smartcase'}
" au User CmSetup call cm#register_source({'name' : 'cm-css',
"         \ 'priority': 7,
"         \ 'scopes': ['css', 'scss', 'js', 'javascript'],
"         \ 'scoping': 1,
"         \ 'abbreviation': 'css',
"         \ 'cm_refresh_patterns':['\w{2,}$',':\s+\w*$'],
"         \ 'cm_refresh': {'omnifunc': 'csscomplete#CompleteCSS'},
"         \ })

au User CmSetup call cm#register_source({'name' : 'cm-css',
                        \ 'priority': 9,
                        \ 'scoping': 1,
                        \ 'scopes': ['css','scss'],
                        \ 'abbreviation': 'css',
                        \ 'word_pattern': '[\w\-]+',
                        \ 'cm_refresh_patterns':['[\w\-]+\s*:\s+'],
                        \ 'cm_refresh': {'omnifunc': 'csscomplete#CompleteCSS'},
                        \ })

let g:cm_sources_override = {
                        \ 'cm-css': {'scopes': ['css', 'scss', 'javascript', 'jsx', 'javascript.jsx']}
                        \ }

let g:cm_refresh_default_min_word_len=2
imap <silent> <c-o> <c-r>=cm#sources#ultisnips#trigger_or_popup("\<Plug>(ultisnips_expand)")<cr>
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"}}}"
Plug 'roxma/nvim-cm-php-language-server',  {'do': 'composer install && composer run-script parse-stubs'}
Plug 'roxma/nvim-cm-tern',  {'do': 'npm install'}
Plug 'skywind3000/asyncrun.vim'
Plug 'sheerun/vim-polyglot' "{{{
" let g:polyglot_disabled = ['javascript']
" }}}
Plug 'mxw/vim-jsx'
Plug 'posva/vim-vue' "{{{
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css
let g:vue_disable_pre_processors=1
autocmd FileType vue syntax sync fromstart
"}}}
Plug 'tyru/caw.vim'
Plug 'Shougo/context_filetype.vim'

Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/ElmCast/elm-vim' "{{{
let g:elm_setup_keybindings = 0
" }}}
Plug 'tpope/vim-vinegar'
Plug 'mattn/webapi-vim'
Plug 'junegunn/fzf.vim' " fzf{{{
" ----------------------------------------------------------------------------
nmap <c-f> :Lines<cr>
set noswapfile
set clipboard=unnamed
set autoread
" show autocomplete for commands
set wildmenu
map <leader>b :Buffers<cr>
map <c-_> :FZF<cr>

let g:fzf_layout = { 'window': 'enew' }

let g:fzf_action = {
                        \ 'ctrl-t': 'tab split',
                        \ 'down': 'split',
                        \ 'right': 'vsplit' }

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
        highlight fzf1 ctermfg=161 ctermbg=251
        highlight fzf2 ctermfg=23 ctermbg=251
        highlight fzf3 ctermfg=237 ctermbg=251
        setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

" including hidden files
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -l -g ""'

au! User FzfStatusLine call <SID>fzf_statusline()
" }}}
Plug 'Valloric/MatchTagAlways' "{{{
let g:mta_filetypes = {
                        \ 'javascript.jsx': 1,
                        \ 'html' : 1,
                        \ 'xhtml' : 1,
                        \ 'xml' : 1,
                        \ 'jinja' : 1,
                        \ 'vue.html.javascript.css' : 1,
                        \ '.vue.html.javascript.css' : 1,
                        \ 'vue' : 1,
                        \ '.vue' : 1,
                        \}
"}}}
Plug 'othree/html5.vim'
Plug 'mattn/gist-vim', {'depends': 'mattn/webapi-vim'} "{{{
let g:gist_post_private = 1
"}}}
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
" Plug 'davidhalter/jedi-vim'
Plug 'Valloric/MatchTagAlways' "{{{
let g:mta_filetypes = {
                        \ 'javascript.jsx': 1,
                        \ 'vue': 1,
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
au BufReadPost *
                        \ if line("'\"") > 0 && line ("'\"") <= line("$") |
                        \   exe "normal! g'\"" |
                        \ endif
" center buffer around cursor when opening files
au BufRead * normal zz
" }}}
"status bar{{{
" ----------------------------------------------------------------------------
set laststatus=2
" set filename on the left side
set statusline=%f
" line separator
set statusline+=%=
" set gitgutter on the right side
set statusline+=\ %l\:%c\ \ \ \
set statusline+=%{join(GitGutterGetHunkSummary())}
"}}}
" completion {{{
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
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
let g:UltiSnipsEditSplit = 'horizontal'
let g:UltiSnipsSnippetsDir="~/dotfiles/nvim/ultiSnips"
let g:UltiSnipsSnippetDirectories=["ultiSnips"]

let g:vim_json_syntax_conceal = 0

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:SuperTabDefaultCompletionType = '<C-n>'

" omni
let g:mta_use_matchparen_group = 1
let g:tern#filetypes = [
                        \ 'jsx',
                        \ 'js',
                        \ 'javascript.jsx',
                        \ 'vue',
                        \ '...'
                        \ ]
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

au CursorMoved *.jsx call s:SetCommentString()
au CursorMoved *.js call s:SetCommentString()
"}}}
"{{{ merlin, ocaml and reason
if executable('ocamlmerlin')
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

let g:merlin_completion_arg_type = "always"
au FileType reason let maplocalleader=","
au FileType ocaml let maplocalleader=","
"}}}
"{{{ autocmd
au Filetype html setlocal ts=2 sts=2 sw=2
au Filetype css setlocal ts=2 sts=2 sw=2
au Filetype scss setlocal ts=2 sts=2 sw=2
au FileType vim setlocal foldmethod=marker
au Filetype python setlocal ts=4 sts=4 sw=4
au Filetype go set ts=8 sts=8 sw=8
au Filetype c set ts=4 sts=4 sw=4
au BufWritePost *.scala silent :EnTypeCheck
au Filetype json setlocal ts=2 sts=2 sw=2
au BufNewFile,BufRead *.go setlocal noexpandtab tabstop=8 shiftwidth=8
au Filetype javascript.jsx setlocal ts=2 sts=2 sw=2
au Filetype javascript setlocal ts=2 sts=2 sw=2
au Filetype js setlocal ts=2 sts=2 sw=2
au Filetype go set ts=8 sts=8 sw=8
au Filetype lua set ts=2 sts=2 sw=2
autocmd FileType vue.html.javascript.css nnoremap <leader>f :Neoformat! javascript<cr>
au Filetype vue.html.javascript.css set ts=2 sts=2 sw=2

" hide go's list char (gogmt wants tab but I personally don't want to see the sign)
" autocmd FileType vue nnoremap <leader>f :%!eslint_d --stdin --fix-to-stdout<CR>
au Filetype go set listchars=tab:\ \
"}}}
"{{{ colorscheme
" colorscheme github
" set background=light
colorscheme nord
set background=dark
"}}}
