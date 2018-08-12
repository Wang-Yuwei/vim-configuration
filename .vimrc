set nocompatible

call plug#begin('~/.local/share/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Valloric/YouCompleteMe'

call plug#end()

filetype on
filetype plugin on

let mapleader=' '
imap jk <Esc>

autocmd BufWritePost $MYVIMRC source $MYVIMRC

filetype indent on
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent

nmap <Leader><Leader> :
nmap <Leader>fs :w<CR>
nmap <Leader>fed :e $MYVIMRC <CR>
nmap <Leader>q :q <CR>

nmap <Leader>wl <C-W>l
nmap <Leader>wh <C-W>h
nmap <Leader>wj <C-W>j
nmap <Leader>wk <C-W>k
nmap <Leader>w= <C-W>=
nmap <Leader>wv :vsplit<CR>
nmap <Leader>ws :split<CR>
let i = 1
while i <= 9
    execute 'nnoremap <Leader>' . i . ' :' . i . 'wincmd w<CR>'
    let i = i + 1
endwhile

nmap <Leader>bp :bprev<CR>
nmap <Leader>bn :bnext<CR>

set laststatus=2
function! WindowNumber()
    let str=tabpagewinnr(tabpagenr())
    return str
endfunction
let g:airline_section_x='column:%c line:%l'
let g:airline_section_z='window:%{WindowNumber()}'

