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
nnoremap J 5gj
nnoremap K 5gk
vmap J 5gj
vmap K 5gk

nmap <c-w>v <c-w>v<right>
nmap <c-w>l <c-w>v
nmap <c-w>j <c-w>s<down>



set expandtab
set shiftwidth=2
set softtabstop=2



" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.vim/plugged')


Plug 'tpope/vim-commentary'

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-entire'
Plug 'beloglazov/vim-textobj-quotes'
" Plug 'kana/vim-textobj-function'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-scripts/mru.vim'
Plug 'reasonml/vim-reason-loader'
Plug 'kana/vim-smartinput'
Plug 'danro/rename.vim'
Plug 'junegunn/fzf.vim'
Plug 'wangsongiam/vim-git-it'
" Initialize plugin system
call plug#end()






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

" ================================== waiting 
" set background=light
" colorscheme lucario

" let g:simple_todo_map_keys = 0

" nmap <Leader>i <Plug>(simple-todo-below)
" nmap <Leader>I <Plug>(simple-todo-above)
" nmap <Leader>u <Plug>(simple-todo-mark-switch)

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

" " markdown 
" set shell=bash\ -i
" let g:vim_markdown_folding_disabled = 1
" let g:vim_markdown_new_list_item_indent = 0

" " set to 1, the vim will open the preview window once enter the markdown
" " let g:mkdp_auto_start = 1
" let g:mkdp_path_to_chrome = "open -a Google\\ Chrome\\ Canary"

" nmap <silent> <leader>m <Plug>MarkdownPreview 

" nmap <leader>in :BundleInstall<cr>
" nmap <leader>id :Dash<cr>

" " Syntastic
" " let g:syntastic_javascript_checkers = ['eslint']

" " let g:syntastic_javascript_eslint_exe = '$(npm bin)/eslint'
" " set statusline+=%#warningmsg#
" " set statusline+=%{SyntasticStatuslineFlag()}
" " set statusline+=%*

" " let g:syntastic_always_populate_loc_list = 0
" " let g:syntastic_auto_loc_list = 0
" " let g:syntastic_check_on_open = 0
" " let g:syntastic_check_on_wq = 0


" let g:calendar_google_calendar = 1
" let g:calendar_google_task = 1

" " :Calendar
" nmap <leader>rn :! node %<cr>
" nmap <leader>rp :! python3 %<cr>
" let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`'} 
" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
" {{{ opam

" " }}}
" let s:opam_share_dir = system("opam config var share")
" let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

" let s:opam_configuration = {}

" function! OpamConfOcpIndent()
"   execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
" endfunction
" let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

" function! OpamConfOcpIndex()
"   execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
" endfunction
" let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

" function! OpamConfMerlin()
"   let l:dir = s:opam_share_dir . "/merlin/vim"
"   execute "set rtp+=" . l:dir
" endfunction
" let s:opam_configuration['merlin'] = function('OpamConfMerlin')

" let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
" let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
" let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
" for tool in s:opam_packages
"   " Respect package order (merlin should be after ocp-index)
"   if count(s:opam_available_tools, tool) > 0
"     call s:opam_configuration[tool]()
"   endif
" endfor
" " ## end of OPAM user-setup addition for vim / base ## keep this line
" " }}}
"{{{ color hybrid
" ----------------------------------------------------------------------------
syntax enable
set background=dark
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
colorscheme hybrid
" hi! StatusLine    .s:fg_comment     .s:bg_background  .s:fmt_revr


hi! StatusLine ctermbg=249 ctermfg=235

  
" hi MoreMsg         guifg=#E6DB74

" h1 StatusLineNC

" set background=light
" colorscheme hybrid_material
"}}}

" " In your ~/.vimrc
" if executable('ocamlmerlin')
"   " To set the log file and restart:
"   let s:ocamlmerlin=substitute(system('which ocamlmerlin'),'ocamlmerlin\n$','','') . "../share/merlin/vim/"
"   execute "set rtp+=".s:ocamlmerlin
"   let g:syntastic_ocaml_checkers=['merlin']
" endif
" if executable('refmt')
"   let s:reason=substitute(system('which refmt'),'refmt\n$','','') . "../share/reason/editorSupport/VimReason"
"   execute "set rtp+=".s:reason
"   let g:syntastic_reason_checkers=['merlin']
" endif
