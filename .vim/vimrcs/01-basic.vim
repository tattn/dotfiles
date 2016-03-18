"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac

"" Fix backspace indent
set backspace=indent,eol,start

" Fix arrow keys
imap OA <UP>
imap OB <DOWN>
imap OC <RIGHT>
imap OD <LEFT>

"" Tabs. May be overriten by autocmd rules
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

"" Map leader to ,
let mapleader=','

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase
set wrapscan
" Centering the word after searching
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

"" Encoding
set bomb
set ttyfast
set lazyredraw
set binary

"" Indenting
"set smartindent "indent automatically
set autoindent   "indent automatically

"" Directories for swp files
set nobackup
set noswapfile

"" Use modeline
set modeline
set modelines=10

"" IME
set noimdisable
set iminsert=0 imsearch=0
set noimcmdline
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

set showcmd                    " on status bar
set shell=/bin/sh

set vb t_vb=                   " sound no beap
set formatoptions=lmq
set whichwrap=b,s,h,l,<,>,[,]  " no stop the line of head/tail
set clipboard=unnamed          " use clipboard


"################################################################
"" Visual Settings
"################################################################

syntax on
set ruler                      " show cursor position
set number
set showmode
set showmatch                  "hilight the bracket
set mouse=a                    " use mouse
if !has('nvim')
	set ttymouse=xterm2
endif

let no_buffers_menu=1
highlight BadWhitespace ctermbg=red guibg=red
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
highlight Normal ctermbg=none
let g:molokai_original = 1
let g:rehash256 = 1
colorscheme molokai
" :set background=dark
" colorscheme solarized

set mousemodel=popup           " show menu by right click
set t_Co=256
set cursorline
"set guioptions+=a
set guioptions=egmrti          " メニュー等の設定

if has("gui_running")
  if has("gui_mac") || has("gui_macvim")
    set guifont=Menlo:h12
    set transparency=5
  endif
else
  let g:CSApprox_loaded = 1

  if $COLORTERM == 'gnome-terminal'
    set term=gnome-256color
  else
    if $TERM == 'xterm'
      set term=xterm-256color
    endif
  endif
endif

if &term =~ '256color'
  set t_ut=
endif

"" CursorLine changes to underline
hi clear CursorLine
hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black

"" Disable the blinking cursor.
set guicursor=a:blinkon0

set scrolloff=5   " Space when scrolling

"" Status bar
set laststatus=2  " always show statusline

set title
set titleold="Terminal"
set titlestring=%F

" if has('nvim')
  " let $NVIM_TUI_ENABLE_TRUE_COLOR=1
" endif

