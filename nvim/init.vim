"    ____                          _      __     ___                    _
"   / ___|__ _ ___ _ __   ___ _ __( )___  \ \   / (_)_ __ ___  _ __ ___| |
"  | |   / _` / __| '_ \ / _ \ '__|// __|  \ \ / /| | '_ ` _ \| '__/ __| |
"  | |__| (_| \__ \ |_) |  __/ |    \__ \   \ V / | | | | | | | | | (__|_|
"   \____\__,_|___/ .__/ \___|_|    |___/    \_/  |_|_| |_| |_|_|  \___(_)
"                 |_|
"
" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" ****************************************************************************
" Author: Casper Wang
" Github: https://github.com/casprwang/dotfiles
" ****************************************************************************
" ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
" {{{ general settings
set viminfo='100,<50,s10,h,%
let s:editor_root=expand("~/.config/nvim")
set number
set noru
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
set icon
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
inoremap <c-r> <BS>
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

nnoremap gq <c-w>q

nnoremap <leader>, :e $MYVIMRC<cr>
nnoremap " <c-^>
" for shift-enter
nnoremap <silent> <esc> :noh<cr>

" CMD-[ to go back
nnoremap <c-_>6 :e#<cr>

" silver searcher
let g:ackprg = 'ag --vimgrep'
" }}}
"{{{ Plugins (vim plug )
" ----------------------------------------------------------------------------
call plug#begin('~/.local/share/nvim/plugged')
Plug 'suy/vim-context-commentstring'
Plug 'tpope/vim-commentary' "{{{
xmap g/ <Plug>Commentary
nmap g/ <Plug>Commentary
nmap g// <Plug>CommentaryLine
omap g/ <Plug>Commentary
nmap cg/ <Plug>ChangeCommentary
" }}}
" typescript
Plug 'christoomey/vim-tmux-navigator' " {{{ tmux navi
let g:tmux_navigator_disable_when_zoomed = 1
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <Left> :TmuxNavigateLeft<cr>
nnoremap <silent> <Down> :TmuxNavigateDown<cr>
nnoremap <silent> <Up> :TmuxNavigateUp<cr>
nnoremap <C-W>M <C-W>\| <C-W>_
nnoremap <C-W>m <C-W>=
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
Plug 'benmills/vimux'
Plug 'casprwang/nord-vim'
Plug 'a/vim-trash-polka'
Plug 'mattn/webapi-vim'
Plug 'rhysd/clever-f.vim' "{{{
map ; <Plug>(clever-f-repeat-forward)
map , <Plug>(clever-f-repeat-back)
"}}}
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  } "{{{
function! g:Open_browser(url)
    silent exe 'silent !open -a "Google Chrome" ' . a:url
endfunction
let g:mkdp_browserfunc = 'g:Open_browser'
"}}}
Plug 'tpope/vim-dispatch'
Plug 'tmux-plugins/vim-tmux'
Plug 'szw/vim-maximizer' "{{{
nnoremap <silent> <c-w><cr> :MaximizerToggle<cr>
let g:maximizer_set_default_mapping = 0
"}}}
Plug 'tmux-plugins/vim-tmux-focus-events' "{{{
"}}}
Plug 'danro/rename.vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'neoclide/jsonc.vim' "{{{
" tsconfig.json is actually jsonc, help TypeScript set the correct filetype
autocmd BufRead,BufNewFile tsconfig.json set filetype=jsonc
"}}}
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'} "{{{
nnoremap <silent> K :call <SID>show_documentation()<CR>

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c


" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.

if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
let g:coc_node_args = ['--max-old-space-size=8192']
" diagnostic
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
"
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" nmap <leader>rn <Plug>(coc-rename)

" smart split definition
function! SplitIfNotOpen(...)
    let fname = a:1
    let call = ''
    if a:0 == 2
	let fname = a:2
	let call = a:1
    endif
    let bufnum=bufnr(expand(fname))
    let winnum=bufwinnr(bufnum)
    if winnum != -1
	" Jump to existing split
	exe winnum . "wincmd w"
    else
	" Make new split as usual
	exe "vsplit " . fname
    endif
    " Execute the cursor movement command
    exe call
endfunction

command! -nargs=+ CocSplitIfNotOpen :call SplitIfNotOpen(<f-args>)


augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

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
  \ 'coc-vetur',
  \ 'coc-tsserver',
  \ 'coc-prettier', 
  \ 'coc-git', 
  \ 'coc-rls', 
  \ 'coc-yaml', 
  \ 'coc-pyright', 
  \ 'coc-explorer', 
  \ 'coc-highlight', 
  \ 'coc-yank', 
  \ 'coc-flow', 
  \ 'coc-eslint', 
  \ 'coc-css', 
  \ 'coc-html', 
  \ 'coc-java', 
  \ 'coc-go', 
  \ 'coc-lua', 
  \ 'coc-elixir', 
  \ 'coc-emmet', 
  \ 'coc-sourcekit', 
  \ 'coc-solargraph', 
  \ 'coc-svg', 
  \ 'coc-vimlsp', 
  \ 'coc-clangd', 
  \ 'coc-pairs', 
  \ 'coc-json', 
  \ 'coc-diagnostic', 
  \ 'coc-dictionary', 
  \ ]

" coc-python
nnoremap <c-_>8 :CocCommand python.execInTerminal<cr>

" coc-explorer
nnoremap <silent> go :CocCommand explorer<CR>
command! -nargs=0 Prettier :CocCommand prettier.formatFile
command! -nargs=0 Eslint :CocCommand eslint.executeAutofix


" coc-snippet
let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<s-tab>'

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ coc#jumpable() ? "\<C-r>=coc#rpc#request('snippetNext',[])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

inoremap <silent><expr> <S-TAB>
    \ pumvisible() ? "\<C-p>" :
    \ coc#jumpable() ? "\<C-r>=coc#rpc#request('snippetPrev',[])\<CR>" :
    \ "\<C-h>"

inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : 
                                           \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

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

" coc-git
nmap <silent> ga :CocCommand git.chunkStage<cr>

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

" nnoremap <leader>f :Format<cr>

" Use `:f` to format current buffer
command! -nargs=0 Format :call CocAction('format')
cabbrev f Format
" command! -nargs=0 f :call CocAction('format')

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
" Plug 'Vimjas/vim-python-pep8-indent'
Plug 'tpope/vim-fugitive' "{{{
nnoremap g' :Gstatus<cr>
nnoremap gb :Gblame<cr>
" nnoremap gp :Gpush<cr>
nnoremap gc :Gcommit<cr>
nnoremap gw :Gw<cr>
"}}}
Plug 'tpope/vim-surround'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' " fzf{{{
" ----------------------------------------------------------------------------
set noswapfile
set clipboard=unnamed
set autoread
set wildmenu
map <leader>b :Buffers<cr>

let g:fzf_action = {
                        \ 'ctrl-t': 'tab drop',
                        \ 'ctrl-v': 'vsplit',
                        \}

let $FZF_DEFAULT_OPTS='--layout=reverse'

function! CreateCenteredFloatingWindow()
    let width = min([&columns - 4, max([80, &columns - 20])])
    let height = min([&lines - 4, max([20, &lines - 10])])
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

    let top = "╭" . repeat("─", width - 2) . "╮"
    let mid = "│" . repeat(" ", width - 2) . "│"
    let bot = "╰" . repeat("─", width - 2) . "╯"
    let lines = [top] + repeat([mid], height - 2) + [bot]
    let s:buf = nvim_create_buf(v:false, v:true)
    call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
    call nvim_open_win(s:buf, v:true, opts)
    set winhl=Normal:Floating
    let opts.row += 1
    let opts.height -= 2
    let opts.col += 2
    let opts.width -= 4
    call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
    au BufWipeout <buffer> exe 'bw '.s:buf
endfunction


" let g:fzf_layout = { 'window': 'call FloatingFZF()' }
let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }

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

au! User FzfStatusLine call <SID>fzf_statusline()

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --hidden --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let options = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(options), a:fullscreen)
endfunction

command! -nargs=* -bang RF call RipgrepFzf(<q-args>, <bang>0)
" nnoremap <silent> <leader>e :RF<cr>
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
nnoremap <silent> <leader>e :Rg<cr>
nnoremap <silent> <c-_>7 :FZF<cr>
nnoremap <silent> <c-w>e :Rg <C-R><C-W><CR>
" history
nnoremap <c-_>\ :History<cr>
" }}}
Plug 'mattn/gist-vim', {'depends': 'mattn/webapi-vim'} "{{{
let g:gist_post_private = 1
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
set laststatus=0
" set filename on the left side
set statusline=%f
" line separator
set statusline+=%=
" set gitgutter on the right side
set statusline+=\ %l\:%c\ \ \ \
" set statusline+=%{join(GitGutterGetHunkSummary())}
let g:vim_json_syntax_conceal = 0
let g:mta_use_matchparen_group = 1
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
au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
au BufNewFile,BufRead *.tsx set filetype=typescript.tsx
au Filetype html setlocal ts=2 sts=2 sw=2
au FileType html setlocal commentstring=<!--\ %s\ -->
au Filetype css setlocal ts=2 sts=2 sw=2
au Filetype scss setlocal ts=2 sts=2 sw=2
au Filetype crontab setlocal nobackup nowritebackup
au Filetype python setlocal ts=4 sts=4 sw=4
au Filetype go set ts=8 sts=8 sw=8
au Filetype c set ts=4 sts=4 sw=4
au Filetype cpp set ts=4 sts=4 sw=4
au Filetype json setlocal ts=2 sts=2 sw=2
au Filetype javascript.jsx setlocal ts=2 sts=2 sw=2
au Filetype javascript setlocal ts=2 sts=2 sw=2
au Filetype markdown setlocal ts=2 sts=2 sw=2
au Filetype markdown setlocal wrap linebreak nolist nu
au Filetype markdown setlocal foldcolumn=0
au FileType typescript setlocal ts=2 sts=2 sw=2
au FileType typescriptreact setlocal ts=2 sts=2 sw=2
au Filetype sh setlocal ts=4 sts=4 sw=4
au Filetype zsh setlocal ts=4 sts=4 sw=4
au Filetype javascript setlocal ts=2 sts=2 sw=2
au Filetype javascript set listchars=tab:\ \ 
au Filetype go set ts=8 sts=8 sw=8
au Filetype go set listchars=tab:\ \ 
au Filetype lua set ts=4 sts=4 sw=4
au Filetype yaml set ts=4 sts=4 sw=4
au Filetype vue set ts=2 sts=2 sw=2
au FileType vue setlocal commentstring=<!--\ %s\ -->
au FileType python let b:coc_root_patterns = ['.git', '.env']
au FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
au FileType md setlocal wrap
" Override PHP Comments

" Auto resize panes
function ResizeWithTmux()
        if winwidth(1) != 1
                exe "normal \<c-w>="
        endif
endfunction
autocmd VimResized * call ResizeWithTmux()

augroup end
"}}}
"{{{ colorscheme


if !empty($TERM_SESSION_ID)
        colorscheme trash-polka-light
        hi Comment    ctermfg=247
        hi MatchParen cterm=none ctermbg=253 ctermfg=244
else
        set background=dark
        colorscheme nord
        hi CocUnderline gui=underline term=undercurl
        hi CocErrorHighlight ctermfg=red  guifg=#c4384b gui=undercurl term=undercurl
        hi CocWarningHighlight ctermfg=yellow guifg=#c4ab39 gui=undercurl term=undercurl
        au CursorHold * silent call CocActionAsync('highlight')
        set termguicolors

        " highlight under cursor
        " hi default CocHighlightText  guibg=Grey ctermbg=Cyan
        " hi default link CocHighlightRead  CocHighlightText
        " hi default link CocHighlightWrite  CocHighlightText
endif

"}}}

nnoremap <leader>. :source $MYVIMRC<cr>

