" Mapping
let mapleader = "\<Space>"
nnoremap <leader>w :wa<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>o :NERDTreeToggle<CR>
nnoremap <leader>y :sy on<CR>

" Interface
syntax on 
set relativenumber 
set t_Co=256
colorscheme darkerdesert
set laststatus =2

" Bundle Begins  
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()                     
Plugin 'VundleVim/Vundle.vim'
Plugin 'flazz/vim-colorschemes'
Plugin 'scrooloose/nerdTree'
" Plugin 'vim-airline/vim-airline'
call vundle#end()            " required
" Bundle ends 

