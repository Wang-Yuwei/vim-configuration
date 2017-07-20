" Leader key and Escape key
let mapleader="\<Space>"
imap jj <Esc>

" auto load .vimrc
autocmd BufWritePost $MYVIMRC source $MYVIMRC

" disable compatible mode
set nocompatible

" load plugins according to file type
filetype on
filetype plugin on

" vundle plugins
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'tomasr/molokai'
Plugin 'Lokaltog/vim-powerline'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'

call vundle#end()
filetype plugin indent on

" gui themes
set gcr=a:block-blinkon0
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions-=m
set guioptions-=T
if has('gui_running')
    colorscheme molokai
endif
set guifont=Source\ Code\ Pro

fun! ToggleFullscreen()
    call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")
endf

map <silent> <F11> :call ToggleFullscreen()<CR>

" shared configuration
set incsearch
set ignorecase
set wildmenu
syntax enable
syntax on
autocmd BufEnter * set mouse=

" indent
filetype indent on
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" view
set number
set cursorline
set hlsearch

" key binding
" save and quit
nmap <Leader><Leader> :
nmap <Leader>fs :w<CR>
nmap <Leader>q :q<CR>
nmap <Leader>Q :qa<CR>
nmap <Leader>W :wa<CR>

" copy and paste
vnoremap <Leader>y "+y
nmap <Leader>p "+p

" open file
cnoremap red edit <c-r>=expand("%:h")<cr>/
nmap <Leader>ff :red

" window
nmap <Leader>wl <C-W>l
nmap <Leader>wh <C-W>h
nmap <Leader>wj <C-W>j
nmap <Leader>wk <C-W>k
nmap <Leader>wv :vsplit<CR>
nmap <Leader>ws :split<CR>

" backspace
set backspace=indent,eol,start

" powerline
let g:Powerline_colorscheme='solarized256'

" nerd tree
nmap <leader>ft :NERDTreeToggle<CR>
let NERDTreeMinimalUI=1
let NERDTreeAutoDeleteBuffer=1

