" Leader key and Escape key
let mapleader="\<Space>"
imap jk <Esc>

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
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'rhysd/vim-clang-format'
Plugin 'hzchirs/vim-material'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'godlygeek/csapprox'
Plugin 'Chiel92/vim-autoformat'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'scrooloose/syntastic'
Plugin 'pangloss/vim-javascript'
Plugin 'marijnh/tern_for_vim'
Plugin 'othree/yajs.vim'

" typescript
Plugin 'leafgarland/typescript-vim'
Plugin 'HerringtonDarkholme/yats.vim'
Plugin 'Quramy/tsuquyomi'

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
    colorscheme vim-material
endif
colorscheme PaperColor
" colorscheme vim-material
set guifont=Consolas\ 13
set background=dark
let g:CSApprox_hook_post = [
            \ 'highlight Normal            ctermbg=NONE',
            \ 'highlight LineNr            ctermbg=NONE',
            \ 'highlight SignifyLineAdd    cterm=bold ctermbg=NONE ctermfg=green',
            \ 'highlight SignifyLineDelete cterm=bold ctermbg=NONE ctermfg=red',
            \ 'highlight SignifyLineChange cterm=bold ctermbg=NONE ctermfg=yellow',
            \ 'highlight SignifySignAdd    cterm=bold ctermbg=NONE ctermfg=green',
            \ 'highlight SignifySignDelete cterm=bold ctermbg=NONE ctermfg=red',
            \ 'highlight SignifySignChange cterm=bold ctermbg=NONE ctermfg=yellow',
            \ 'highlight SignColumn        ctermbg=NONE',
            \ 'highlight CursorLine        ctermbg=NONE cterm=underline',
            \ 'highlight Folded            ctermbg=NONE cterm=bold',
            \ 'highlight FoldColumn        ctermbg=NONE cterm=bold',
            \ 'highlight NonText           ctermbg=NONE',
            \ 'highlight clear LineNr'
            \]


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
set autoindent

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
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
nmap <Leader>ff :edit %%

" create directory on save
function! s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" window
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

" buffer
nmap <Leader>bp :bprev<CR>
nmap <Leader>bn :bnext<CR>
nmap <Leader>bb :CtrlPBuffer<CR>

" backspace
set backspace=indent,eol,start

" airline
set laststatus=2
set t_Co=256
function! WindowNumber()
    let str=tabpagewinnr(tabpagenr())
    return str
endfunction
let g:airline_section_x='column:%c line:%l,%L'
let g:airline_section_z='window:%{WindowNumber()}'
let g:airline_theme='papercolor'


" nerd tree
nmap <leader>ft :NERDTreeToggle<CR>
let NERDTreeMinimalUI=1
let NERDTreeAutoDeleteBuffer=1

" ctrlp
nmap <Leader>pf :CtrlP<CR>

" manual
source $VIMRUNTIME/ftplugin/man.vim
nmap <Leader>man :Man 3 <cword><CR>

" clang format
" let g:clang_format#detect_style_file=1
" let g:clang_format#auto_format=1

" Auto format
au BufWrite * :Autoformat
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
" let g:autoformat_remove_trailing_spaces = 0

" javascript
let g:syntastic_javascript_checkers = ['eslint']
let g:formatdef_eslint = '"SRC=eslint-temp-${RANDOM}.js; cat - >$SRC; eslint --fix $SRC >/dev/null 2>&1; cat $SRC | perl -pe \"chomp if eof\"; rm -f $SRC"'
let g:formatters_javascript = ['eslint']
let g:javascript_plugin_flow = 1

" you complete me
highlight Pmenu ctermfg=2 ctermbg=3 guifg=#005f87 guibg=#EEE8D5
highlight PmenuSel ctermfg=2 ctermbg=3 guifg=#AFD700 guibg=#106900
let g:ycm_complete_in_comments=1
let g:ycm_confirm_extra_conf=0
let g:ycm_collect_identifiers_from_tags_files=1
set tags+=/data/misc/software/misc./vim/stdcpp.tags
set completeopt-=preview
let g:ycm_min_num_of_chars_for_completion=1
let g:ycm_cache_omnifunc=0
let g:ycm_seed_identifiers_with_syntax=1
let g:disable_protodef_sorting=1

if !exists("g:ycm_semantic_triggers")
  let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers['typescript'] = ['.']
