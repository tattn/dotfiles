"################################################################
"" NeoBundle
"################################################################

if has('vim_starting')
  set nocompatible

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle'))
endif

let neobundle_readme=expand('~/.vim/bundle/neobundle.vim/README.md')

if !filereadable(neobundle_readme)
  echo "Installing NeoBundle..."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'


"################################################################
"" NeoBundle install packages
"################################################################

" Unite and VimFiler
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/neomru.vim'


NeoBundle 'scrooloose/nerdtree'

"" Comment out
NeoBundle 'tomtom/tcomment_vim'

"" VimProc for asynchronous
NeoBundle "Shougo/vimproc", {
        \ "build": {
        \   "windows"   : "make -f make_mingw32.mak",
        \   "cygwin"    : "make -f make_cygwin.mak",
        \   "mac"       : "make -f make_mac.mak",
        \   "unix"      : "make -f make_unix.mak",
        \ }}

"" QuickRun
NeoBundle 'thinca/vim-quickrun'

"" Indent guides
NeoBundle "nathanaelkane/vim-indent-guides"

"" Colors
NeoBundle 'tomasr/molokai'
NeoBundle 'altercation/vim-colors-solarized'

"" Beautiful StatusLine
NeoBundle 'bling/vim-airline'

"" AutoComplete
NeoBundle 'Shougo/neocomplete.vim'

"" NeoSnippet
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'


"---------------------------
"" CoffeeScript
"---------------------------
"" hilighter
NeoBundle 'kchmck/vim-coffee-script'

"---------------------------
"" Less
"---------------------------
"" hilighter
NeoBundle 'groenewege/vim-less'

"---------------------------
"" Rails
"---------------------------
"" rails.vim
NeoBundle 'tpope/vim-rails'

"---------------------------
"" Python
"---------------------------
"" AutoComplete for Python
NeoBundle 'davidhalter/jedi-vim'
" NeoBundle 'jmcantrell/vim-virtualenv'
NeoBundleLazy 'lambdalisue/vim-pyenv', {
        \ 'depends': ['davidhalter/jedi-vim'],
        \ 'autoload': {
        \   'filetypes': ['python', 'python3'],
        \ }}

"---------------------------
"" Ruby
"---------------------------
"" AutoComplete for Ruby
NeoBundleLazy 'marcus/rsense', {
      \ 'autoload': {
      \   'filetypes': 'ruby',
      \ },
      \ }
NeoBundle 'supermomonga/neocomplete-rsense.vim', {
      \ 'depends': ['Shougo/neocomplete.vim', 'marcus/rsense'],
      \ }


call neobundle#end()

filetype plugin indent on

NeoBundleCheck		" check uninstalled plugins


"################################################################
"" NeoBundle Configuration
"################################################################

"" Shougo/unite
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<CR>


"" tomtom/tcomment_vim
" if !exists('g:tcomment_types')
"   let g:tcomment_types = {}
" endif
let g:tcomment_types = {
      \'php_surround' : "<?php %s ?>",
      \'eruby_surround' : "<%% %s %%>",
      \'eruby_surround_minus' : "<%% %s -%%>",
      \'eruby_surround_equality' : "<%%= %s %%>",
\}
function! SetErubyMapping2()
  nmap <buffer> <C-_>c :TCommentAs eruby_surround<CR>
  nmap <buffer> <C-_>- :TCommentAs eruby_surround_minus<CR>
  nmap <buffer> <C-_>= :TCommentAs eruby_surround_equality<CR>

  vmap <buffer> <C-_>c :TCommentAs eruby_surround<CR>
  vmap <buffer> <C-_>- :TCommentAs eruby_surround_minus<CR>
  vmap <buffer> <C-_>= :TCommentAs eruby_surround_equality<CR>
endfunction
" for eruby
au FileType eruby call SetErubyMapping2()
" for php
au FileType php nmap <buffer><C-_>c :TCommentAs php_surround<CR>
au FileType php vmap <buffer><C-_>c :TCommentAs php_surround<CR>


"" thinca/vim-quickrun
let g:quickrun_config = {
\   "_" : {
\       "runner" : "vimproc",
\       "runner/vimproc/updatetime" : 60
\   },
\}
set splitbelow
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"


"" nathanaelkane/vim-indent-guides
let s:hooks = neobundle#get_hooks("vim-indent-guides")
function! s:hooks.on_source(bundle)
  let g:indent_guides_guide_size = 1
  IndentGuidesEnable
endfunction


"" bling/vim-airline
" let g:airline_theme = 'molokai'
let g:airline_enable_branch = 0
" let g:airline_section_a = airline#section#create(['mode','','branch'])
let g:airline_section_b = "%t %M"
" let g:airline_section_c = pyenv#statusline#component
let s:sep = " %{get(g:, 'airline_right_alt_sep', '')} "
let g:airline_section_x =
    \ "%{strlen(&fileformat)?&fileformat:''}".s:sep.
    \ "%{strlen(&fenc)?&fenc:&enc}".s:sep.
    \ "%{strlen(&filetype)?&filetype:'no ft'}"
let g:airline_section_y = '%3p%%'
let g:airline_section_z = get(g:, 'airline_linecolumn_prefix', '').'%3l:%-2v'
let g:airline#extensions#whitespace#enabled = 0
let g:airline_theme='badwolf'
let g:airline_left_sep = '⮀'
let g:airline_right_sep = '⮂'
let g:airline_linecolumn_prefix = '⭡'
let g:airline_branch_prefix = '⭠'
let g:airline#extensions#tabline#left_sep = '⮀'
let g:airline#extensions#tabline#left_alt_sep = '⮀'
let g:airline#extensions#readonly#symbol = '⭤ '


"" Shougo/neocomplete.vim
let g:neocomplete#enable_auto_select = 0
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'


"" davidhalter/jedi-vim
" let g:jedi#completions_enabled=0
let g:jedi#auto_vim_configuration = 1
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0   " no select
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'
autocmd FileType python setlocal completeopt-=preview " docstringは表示しない
autocmd FileType python setlocal omnifunc=jedi#completions


"" marcus/rsense
let g:rsenseUseOmniFunc = 1


"" Shougo/neosnippet
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

if has('conceal')
  set conceallevel=2 concealcursor=i
endif



"################################################################
"" Basic Setup
"################################################################

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
set softtabstop=0
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
set ttymouse=xterm2

let no_buffers_menu=1
highlight BadWhitespace ctermbg=red guibg=red
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
highlight Normal ctermbg=none
colorscheme molokai
" :set background=dark
" colorscheme solarized

set mousemodel=popup           " show menu by right click
set t_Co=256
set cursorline
"set guioptions+=a
set guioptions=egmrti          " メニュー等の設定
set guifont=Monospace\ 8

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




"################################################################
"" Functions
"################################################################
if !exists('*s:setupWrapping')
  function s:setupWrapping()
    set wrap
    set wm=2
    set textwidth=79
  endfunction
endif

if !exists('*TrimWhiteSpace')
  function TrimWhiteSpace()
    let @*=line(".")
    %s/\s*$//e
    ''
  endfunction
endif



"################################################################
"" Autocmd Rules
"################################################################

"" The PC is fast enough, do syntax highlight syncing from start
autocmd BufEnter * :syntax sync fromstart

"" Remember cursor position
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

"" txt
autocmd BufRead,BufNewFile *.txt call s:setupWrapping()

"" make/cmake
autocmd FileType make setlocal noexpandtab
autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake

"" auto compiling for coffee script
autocmd BufWritePost *.coffee silent make!

if has("gui_running")
  autocmd BufWritePre * :call TrimWhiteSpace()
endif


"" Add filetypes
augroup addfiletype
	au BufNewFile,BufRead *.gyp setf gyp
	au BufNewFile,BufRead *.gypi setf gyp
augroup END

"" Tab settings
augroup vimrc
	autocmd! FileType vim setlocal shiftwidth=2 tabstop=2 softtabstop=2
	autocmd! FileType ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2
	autocmd! FileType eruby setlocal shiftwidth=2 tabstop=2 softtabstop=2
	autocmd! FileType coffee setlocal shiftwidth=2 tabstop=2 softtabstop=2
	autocmd! FileType perl setlocal shiftwidth=4 tabstop=2 softtabstop=2
	autocmd! FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
	autocmd! FileType css  setlocal shiftwidth=4 tabstop=2 softtabstop=2
	autocmd! FileType gyp  setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup END

"" Show QuickFix list automatically
augroup quickfix
autocmd QuickfixCmdPost make,grep,grepadd,vimgrep,vimgrepadd cwin
autocmd QuickfixCmdPost lmake,lgrep,lgrepadd,lvimgrep,lvimgrepadd lwin
augroup END

"" カーソルを現在のウィンドウのみに表示
augroup currentcursorline
    autocmd! currentcursorline
    autocmd WinLeave * set nocursorline
    autocmd WinEnter,BufRead * set cursorline
  augroup END

set autoread      " Read automatically when the file is rewrited





"################################################################
"" Mappings
"################################################################

" Escape insert mode
inoremap <C-j> <ESC>

" Cancel hilight
nnoremap <ESC><ESC> :noh<CR><ESC>

"" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

"" Git
noremap <Leader>ga :!git add .<CR>
noremap <Leader>gc :!git commit -m '<C-R>="'"<CR>
noremap <Leader>gsh :!git push<CR>
noremap <Leader>gll :!git pull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>

"" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

"" Opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"" Opens a tab edit command with the path of the currently edited file filled
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>




