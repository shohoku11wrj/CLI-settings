" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd            " Show (partial) command in status line.
"set showmatch          " Show matching brackets.
set ignorecase         " Do case insensitive matching
"set smartcase          " Do smart case matching
"set incsearch          " Incremental search
"set autowrite          " Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a            " Enable mouse usage (all modes)
"set hlsearch            " highlight search content
set title
set cursorline
highlight clear CursorLine
highlight CursorLine gui=underline ctermbg=17
highlight Pmenu ctermbg=brown gui=bold

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

let &termencoding=&encoding
set encoding=utf-8
set fileencoding=utf-8
"set bomb "Linux不支持BOM
set termencoding=utf-8
set fileencodings=utf-8,gbk

filetype indent on
set autoindent
set cindent

set tabstop=4

set expandtab
set shiftwidth=4
set softtabstop=4

set number
set expandtab

" paste from system clipboard
nmap <F2> :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
imap <F2> <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>

" previous buffer
nmap <C-h> :bprevious<CR>
" next buffer
nmap <C-l> :bnext<CR>

" Show whitespaces
set listchars=tab:>-,trail:·
set list

" ======== Vundle ========
set nocompatible    " be iMproved
filetype off        " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" vim-scripts repos
Bundle 'The-NERD-tree'
" 中文输入
"Bundle 'fcitx.vim'
Bundle 'ctrlp.vim'

" auto-complete
Bundle 'delimitMate.vim'

filetype plugin indent on    " required!

" NERDTree
let NERDTreeIgnore = ['\.class*']
nmap <leader>t :NERDTreeToggle<CR>      " <leader> is \, or defined by :let mapleader = "-"
nmap <leader>T :NERDTreeFind<cr>

" CtrlP
" Use <leader>t to open ctrlp
let g:ctrlp_map = '<leader>p'
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=64
let g:ctrlp_working_path_mode=''
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:1024'
"nnoremap <leader>t :CtrlPTag<CR>

" grep
nnoremap <leader>r :grep! --include=\*.java -ri <c-r>=expand("<cword>")<cr> .<CR>:copen<CR>
" grep with params
nnoremap <leader>q :call Grep2()<CR>
function! Grep2()
    call inputsave()
    let filePattern = input('f: ')
    let contentPattern = input('c: ')
    call inputrestore()

    call Grep(filePattern, contentPattern)
endfunction
function! Grep(filePattern, contentPattern)
    sil execute "grep! --color=always --include={" . a:filePattern . "} -riE \"" . a:contentPattern . "\" ."
    exe 'redraw!'
endfunction

" find
nnoremap <leader>f :call Find()<CR>
fun! Find()
    call inputsave()
    let filePattern = input('FindFile: ')
    call inputrestore()

    let error_file = tempname()
    sil exe '!find . -iname "'. filePattern .'" | xargs file | sed "s/:/:0:/" > ' . error_file
    exe "cg ". error_file
    copen 30
    call delete(error_file)
    exe 'redraw!'
endfun

" close selection window
nnoremap <leader>c :ccl<CR>
" Ignore these directories
set wildignore+=*/target/**,*/.git/**,*.html,*.js,*.css,*.iml,*/hive-frontend/**,*/hive-tools/**
" disable caching
"let g:ctrlp_use_caching=0
