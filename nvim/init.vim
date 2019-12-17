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
let g:python_host_prog = expand('~/.pyenv/versions/neovim2/bin/python')
let g:python3_host_prog = expand('~/.pyenv/versions/neovim3/bin/python')
set viminfo='100,<50,s10,h,%
let s:editor_root=expand("~/.config/nvim")
set number
set relativenumber
set signcolumn=yes
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
set updatetime=100
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
nnoremap <c-w>n <c-w>\|
nnoremap 0 ^
nmap Y y$

nnoremap <silent> <leader>j :w<cr>
inoremap {<cr> {<cr>}<c-o>O
inoremap (<cr> (<cr>)<c-o>O
" for shift-enter
nmap <c-w>v :vsplit<cr><c-_>
nmap <c-w>s :split<cr><c-_>
nnoremap <c-w>l :vsplit<cr>
nnoremap <c-w>j :split<cr>
nnoremap <silent> <esc> :noh<cr>
nnoremap <leader>. :source ~/.config/nvim/init.vim<CR>:noh<cr>
nnoremap <c-y>] :tabclose<cr>

" navigation
nmap J 5gj
nmap K 5gk
vmap J 5gj
vmap K 5gk

" Tab
nnoremap <c-y>_ :tabnext<cr>
nnoremap <c-y>^ :tabprevious<cr>

" silver searcher
let g:ackprg = 'ag --vimgrep'
" }}}
"{{{ Plugins (vim plug )
" ----------------------------------------------------------------------------
call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-commentary' "{{{
" Visual mode
xmap g/ <Plug>Commentary
" Normal mode
nmap g/ <Plug>Commentary
" Normal mode, current line
nmap g// <Plug>CommentaryLine
" Operator pending mode (this lets you do e.g. `dgc` to delete a block of comments)
omap g/ <Plug>Commentary
" Special case cgc (you can skip this one, but then `cgc` will also delete an extra blank line)
nmap cg/ <Plug>ChangeCommentary
" }}}
Plug 'szw/vim-maximizer' "{{{
let g:maximizer_set_default_mapping = 0
"}}}
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
"typescript
Plug 'christoomey/vim-tmux-navigator' " {{{ tmux navi
let g:tmux_navigator_disable_when_zoomed = 1
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <Down> :TmuxNavigateDown<cr>
nnoremap <silent> <Up> :TmuxNavigateUp<cr>
nnoremap <silent> <Right> :TmuxNavigateRight<cr>
nnoremap <silent> <Left> :TmuxNavigateLeft<cr>
" }}}
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' } "{{{
let g:go_version_warning = 0
let g:go_term_enabled = 1
let g:go_term_width = 80
let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"
let g:go_metalinter_autosave = 0
let g:go_fmt_fail_silently = 1
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
Plug 'christoomey/vim-run-interactive'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'tpope/vim-dispatch'
Plug 'tmux-plugins/vim-tmux'
Plug 'hail2u/vim-css3-syntax', {'on_ft':['css','scss']}
Plug 'scrooloose/nerdtree' "{{{
let g:NERDTreeWinPos = "right"
nnoremap <silent> <leader>o :NERDTreeToggle<CR>
let NERDTreeIgnore=['node_modules']
"}}}
Plug 'dense-analysis/ale' "{{{
let g:ale_linter_aliases = {
                        \ 'jsx': ['css', 'javascript']}
let g:ale_linters = {
                        \ 'jsx': ['stylelint', 'eslint'],
                        \ 'python': ['autopep8'],
                        \ 'javascript': ['eslint']}
let g:ale_fixers = {
                        \ 'jsx': ['eslint'],
                        \ 'python': ['autopep8'],
                        \ 'javascript': ['eslint']}
let g:ale_sign_column_always = 1
let g:ale_set_signs = 0
"}}}
" Plug 'kana/vim-smartinput'
" Plug 'Chiel92/vim-autoformat'
Plug 'szw/vim-maximizer' "{{{
nnoremap <silent> <c-w><cr> :MaximizerToggle<cr>
"}}}
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'othree/csscomplete.vim'
Plug 'sheerun/vim-polyglot'
Plug 'liuchengxu/vim-clap' "{{{
let g:clap_popup_input_delay = 0
let g:clap_provider_grep_delay = 0
let g:clap_provider_grep_blink = [0, 0]
" nnoremap <silent> <leader>e :Clap! grep ++finder=rg --column --line-number --no-heading --color=always --smart-case<cr>
" nnoremap <silent> <c-_> :Clap! files ++finder=rg --no-ignore --hidden --files<cr>
" nnoremap <c-y>\ :Clap! history<cr>
"}}}
Plug 'airblade/vim-gitgutter' "{{{{
let g:gitgutter_preview_win_floating = 1
" Visual mode
xmap ga <Plug>(GitGutterStageHunk)
" Normal mode
nmap ga <Plug>(GitGutterStageHunk)
"}}}}

Plug 'itchyny/lightline.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'} "{{{
nmap ge :CocCommand explorer<CR>
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

let g:indentLine_leadingSpaceEnabled = 1

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
" extensions
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-prettier', 
  \ 'coc-json', 
  \ 'coc-git', 
  \ 'coc-rls', 
  \ 'coc-yaml', 
  \ 'coc-python', 
  \ 'coc-highlight', 
  \ 'coc-yank', 
  \ 'coc-flow', 
  \ 'coc-markdownlint', 
  \ 'coc-css', 
  \ 'coc-html', 
  \ 'coc-java', 
  \ 'coc-go', 
  \ ]

" snippets
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'


function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' '). ' ' . get(g:, 'coc_status', '')
endfunction


" lightline
function! LightlineGitBlame() abort
  let blame = get(b:, 'coc_git_blame', '')
  " return blame
  return winwidth(0) > 120 ? blame : ''
endfunction

let g:lightline = {
  \ 'colorscheme': 'nord',
  \ 'active': {
  \   'left': [
  \     [ 'paste' ],
  \     [ 'filename' ],
  \     [ 'coc_git_branch_status' ],
  \   ],
  \   'right':[
  \     ['lineinfo' ],
  \     [ 'blame' ],
  \   ],
  \ },
  \ 'inactive': {
  \   'left': [
  \   ],
  \ },
  \ 'component_function': {
  \   'coc_git_change_status': 'CocGitChangeStatus',
  \   'coc_git_branch_status': 'CocGitBranchStatus',
  \ },
\ }

autocmd FileType markdown let b:coc_suggest_disable = 1

let g:nord_statusline_uniform = 1

function! CocGitChangeStatus()
    return trim(get(b:, 'coc_git_status', ''))
endfunction

function! CocGitBranchStatus()
    return trim(get(g:, 'coc_git_status', ''))
endfunction

nnoremap <silent> gh :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
nmap <leader>f :Format<cr>
" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)


" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end


" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

"}}}
Plug 'tpope/vim-fugitive' "{{{
nnoremap gi :Gstatus<cr>
nnoremap gb :Gblame<cr>
nnoremap go :Gbrowse<cr>
nnoremap gc :Gcommit<cr>
nnoremap gw :Gw<cr>
"}}}
Plug 'tpope/vim-rhubarb'
Plug 'skywind3000/asyncrun.vim'
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim' " fzf{{{
" ----------------------------------------------------------------------------
set noswapfile
set clipboard=unnamed
set autoread
" show autocomplete for commands
set wildmenu
map <leader>b :Buffers<cr>

let g:fzf_action = {
                        \ 'ctrl-t': 'tab split',
                        \}

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

let $FZF_DEFAULT_OPTS='--layout=reverse'

let g:fzf_layout = { 'window': 'call FloatingFZF()' }

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = &lines - 3
  let width = float2nr(&columns - (&columns * 2 / 10))
  let col = float2nr((&columns - width) / 2)

  let opts = {
        \ 'relative': 'editor',
        \ 'row': 1,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction

function! s:fzf_statusline()
        highlight fzf1 ctermfg=161 ctermbg=251
        highlight fzf2 ctermfg=23 ctermbg=251
        highlight fzf3 ctermfg=237 ctermbg=251
        setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case -g "!*graphql.tsx" '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

au! User FzfStatusLine call <SID>fzf_statusline()
nnoremap <silent> <leader>e :Rg<cr>
nnoremap <silent> <c-_> :FZF<cr>
" history
nnoremap <c-y>\ :History<cr>
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
Plug 'liuchengxu/vista.vim'
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
"{{{ autocmd
augroup FiletypeGroup
    autocmd!
    au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
augroup END
au Filetype html setlocal ts=2 sts=2 sw=2
au Filetype css setlocal ts=2 sts=2 sw=2
au Filetype scss setlocal ts=2 sts=2 sw=2
au filetype crontab setlocal nobackup nowritebackup
" au FileType vim setlocal foldmethod=marker
au Filetype python setlocal ts=4 sts=4 sw=4
au Filetype go set ts=8 sts=8 sw=8
au Filetype c set ts=4 sts=4 sw=4
au BufWritePost *.scala silent :EnTypeCheck
au Filetype json setlocal ts=2 sts=2 sw=2
au BufNewFile,BufRead *.go setlocal noexpandtab tabstop=8 shiftwidth=8
au Filetype javascript.jsx setlocal ts=2 sts=2 sw=2
au Filetype javascript setlocal ts=2 sts=2 sw=2
au Filetype markdown setlocal ts=2 sts=2 sw=2
au Filetype markdown setlocal foldcolumn=0
au Filetype markdown setlocal norelativenumber
au Filetype markdown setlocal nu
au Filetype markdown setlocal foldcolumn=3
au Filetype markdown setlocal foldcolumn=0
au FileType typescript setlocal ts=2 sts=2 sw=2
au FileType typescriptreact setlocal ts=2 sts=2 sw=2
au Filetype sh setlocal ts=4 sts=4 sw=4
au Filetype zsh setlocal ts=4 sts=4 sw=4
au Filetype js setlocal ts=2 sts=2 sw=2
au Filetype go set ts=8 sts=8 sw=8
au Filetype lua set ts=2 sts=2 sw=2
au Filetype vue.html.javascript.css set ts=2 sts=2 sw=2
au Filetype go set listchars=tab:\ \ 
" autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')
"}}}
"{{{ colorscheme
set background=dark
colorscheme nord
"}}}
