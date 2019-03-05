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
let g:python_host_prog = '/Users/song/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/Users/song/.pyenv/versions/neovim3/bin/python'
set viminfo='100,<50,s10,h,%
let s:editor_root=expand("~/.config/nvim")
set nowrap
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
set hlsearch
set autoindent
set smartindent
set expandtab
set incsearch
set ignorecase
set smartcase
set showmatch
set smarttab
set undofile
set undodir=~/.config/nvim/undo
set undolevels=1000
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
nnoremap <c-w><Space> <c-w>=
nnoremap <leader>in :PlugInstall<cr>
nnoremap <leader>j :w<cr>
nnoremap <c-w>n <c-w>\|
nnoremap <leader>, za
nnoremap 0 ^
nmap Y y$
inoremap {<cr> {<cr>}<c-o>O
inoremap (<cr> (<cr>)<c-o>O
" for shift-enter
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
nnoremap <leader>e :Rg<cr>
" }}}
"{{{ Plugins (vim plug )
" ----------------------------------------------------------------------------
call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-commentary'
Plug 'szw/vim-maximizer' "{{{
let g:maximizer_set_default_mapping = 0
"}}}
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'pangloss/vim-javascript' , { 'for': ['javascript', 'javascript.jsx', 'html', 'vue'] }
Plug 'maxmellon/vim-jsx-pretty'
Plug 'neoclide/vim-jsx-improve'
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
Plug 'maralla/completor.vim' "{{{
let g:completor_css_omni_trigger = '([\w-]+|@[\w-]*|[\w-]+:\s*[\w-]*)$'
let g:completor_python_binary = '/Users/song/.pyenv/shims/python3'
let g:completor_node_binary = '/usr/local/bin/node'
let g:completor_gocode_binary = '/Users/song/go/bin/gocode'
let g:completor_complete_options = 'menuone,noselect'
let g:completor_racer_binary = '/Users/song/.cargo/bin/racer'
function! Tab_Or_Complete() abort
  if pumvisible()
    return "\<C-N>"
  elseif col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-R>=completor#do('complete')\<CR>"
  else
    return "\<Tab>"
  endif
endfunction

" Use `tab` key to select completions.  Default is arrow keys.
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"}}}
Plug 'alexlafroscia/postcss-syntax.vim'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' } "{{{
let g:go_version_warning = 0
let g:go_term_enabled = 1
let g:go_term_width = 80
let g:go_fmt_autosave = 0
let g:go_fmt_command = "goimports"
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
Plug 'mattn/webapi-vim'
Plug 'moll/vim-node'
Plug 'christoomey/vim-run-interactive'
Plug 'derekwyatt/vim-scala'
Plug 'fleischie/vim-styled-components'
Plug 'elixir-lang/vim-elixir'
Plug 'tpope/vim-dispatch'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  } "{{{
" open in the background
function! g:Open_browser(url)
    silent exec '!open -a "Google Chrome" ' . a:url . " &"
endfunction
let g:mkdp_browserfunc = 'g:Open_browser'
autocmd FileType markdown nmap <leader>m :MarkdownPreview<CR>
"}}}
Plug 'tmux-plugins/vim-tmux'
Plug 'z0mbix/vim-shfmt', { 'for': 'sh' } "{{{
let g:shfmt_extra_args = '-i 2 -ci'
"}}}
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
let g:prettier#config#print_width = 80
let g:prettier#config#tab_width = 2
let g:prettier#config#use_tabs = 'false'
let g:prettier#config#semi = 'false'
let g:prettier#config#single_quote = 'true'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#jsx_bracket_same_line = 'false'
let g:prettier#config#trailing_comma = 'all'
let g:prettier#config#parser = 'flow'
"}}}
Plug 'sbdchd/neoformat' "{{{
let g:neoformat_enabled_javascript = ['eslint_d', 'prettier']
" let g:neoformat_enabled_javascript = ['prettier']
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
Plug 'alpertuna/vim-header' "{{{
let g:header_auto_add_header = 0
let g:header_field_author = 'Song Wang'
let g:header_field_modified_by = 0
let g:header_field_modified_timestamp = 0
let g:header_field_timestamp = 0
"}}}
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
nnoremap gb :Gblame<cr>
nnoremap go :Gbrowse<cr>
"}}}
Plug 'tpope/vim-rhubarb'
Plug 'skywind3000/asyncrun.vim'
Plug 'sheerun/vim-polyglot' "{{{
" let g:polyglot_disabled = ['javascript']
" }}}
Plug 'mxw/vim-jsx' "{{{
let g:jsx_ext_required = 1 
"}}}
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
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim' " fzf{{{
" ----------------------------------------------------------------------------
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

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

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
Plug 'mattn/gist-vim', {'depends': 'mattn/webapi-vim'} "{{{
let g:gist_post_private = 1
"}}}
" Plug 'davidhalter/jedi-vim'
Plug 'sunaku/vim-shortcut'
Plug 'roxma/nvim-yarp'
Plug 'cespare/vim-toml'
Plug 'maralla/vim-toml-enhance'
Plug 'ternjs/tern_for_vim'
Plug 'tomtom/tlib_vim'
Plug 'marcweber/vim-addon-mw-utils'
Plug 'garbas/vim-snipmate' "{{{
"}}}
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
" set statusline+=%{join(GitGutterGetHunkSummary())}
let g:vim_json_syntax_conceal = 0


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
let g:vimreason_extra_args_expr_reason = '"--print-width 90"'
let g:vimreason_extra_args_expr_reason = '"--print-width " . ' .  "winwidth('.')"
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
au filetype crontab setlocal nobackup nowritebackup
au FileType vim setlocal foldmethod=marker
au Filetype python setlocal ts=4 sts=4 sw=4
au Filetype go set ts=8 sts=8 sw=8
au Filetype c set ts=4 sts=4 sw=4
au BufWritePost *.scala silent :EnTypeCheck
au Filetype json setlocal ts=2 sts=2 sw=2
au BufNewFile,BufRead *.go setlocal noexpandtab tabstop=8 shiftwidth=8
au Filetype javascript.jsx setlocal ts=2 sts=2 sw=2
au Filetype javascript setlocal ts=2 sts=2 sw=2
au Filetype sh setlocal ts=4 sts=4 sw=4
au Filetype zsh setlocal ts=4 sts=4 sw=4
au Filetype js setlocal ts=2 sts=2 sw=2
au Filetype go set ts=8 sts=8 sw=8
au Filetype lua set ts=2 sts=2 sw=2
au FileType vue.html.javascript.css nnoremap <leader>f :Neoformat! javascript<cr>
au Filetype vue.html.javascript.css set ts=2 sts=2 sw=2
au FileType sh nnoremap <leader>f :Shfmt<cr>
au FileType zsh nnoremap <leader>f :Shfmt<cr>
au Filetype go set listchars=tab:\ \ 
"}}}
"{{{ colorscheme
colorscheme nord
set background=dark
"}}}
