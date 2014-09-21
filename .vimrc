set nocompatible

"#### Basics ####
let mapleader="," " Key map leader
" Escape insert mode
imap <C-j>  <ESC>
" imap <C-k>  <ESC>
imap <C-c> <ESC>
set expandtab
set ts=4 sw=4 sts=0
set scrolloff=5   " Space when scrolling
set nobackup
set autoread      " Read automatically when the file is rewrited
set noswapfile
set hidden
set backspace=indent,eol,start
set formatoptions=lmoq
set vb t_vb=                   " sound no beap
set whichwrap=b,s,h,l,<,>,[,]  " no stop the line of head/tail
set showcmd                    " show commands on status bar
set showmode
set clipboard+=unnamed         " use clipboard
set mouse=a                    " use mouse
set guioptions+=a
set ttymouse=xterm2
set clipboard=unnamed          " yank to clipboard


"#### NeoBundle ####
filetype plugin indent off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle'))
endif 

call neobundle#begin(expand('~/.vim/bundle/'))

" NERDTree
NeoBundle 'scrooloose/nerdtree'

" caw.vim for comment out
NeoBundle 'tyru/caw.vim.git'
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

" QuickRun
NeoBundle 'thinca/vim-quickrun'
let g:quickrun_config={'*': {'split': ''}}
set splitbelow

NeoBundle "nathanaelkane/vim-indent-guides"
let g:indent_guides_auto_colors=0
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd   ctermbg=110
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven  ctermbg=140
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=4
let g:indent_guides_guide_size=1

" AutoComplete
NeoBundle 'Shougo/neocomplete.vim'
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

" AutoComplete for Python
NeoBundle 'davidhalter/jedi-vim'
NeoBundle 'jmcantrell/vim-virtualenv'
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


" molokai [ColorScheme]
NeoBundle 'tomasr/molokai'

" Solarized [ColorScheme]
NeoBundle 'altercation/vim-colors-solarized'

" Beautiful StatusLine
NeoBundle 'bling/vim-airline'
" let g:airline_theme = 'molokai'
let g:airline_enable_branch = 0
" let g:airline_section_a = airline#section#create(['mode','','branch'])
let g:airline_section_b = "%t %M"
let g:airline_section_c = ''
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

call neobundle#end()

" :set background=dark
set t_Co=256
colorscheme molokai
" colorscheme solarized
highlight Normal ctermbg=none

filetype plugin indent on

NeoBundleCheck		" check not installed plugins 


"#### StatusLine ####
set laststatus=2               " always show statusline
set ruler                      " show cursor position

" " show encording
" function! GetStatusEx()
"   let str = ''
"   if &ft != ''
"     let str = str . '[' . &ft . ']'
"   endif
"   if has('multi_byte')
"     if &fenc != ''
"       let str = str . '[' . &fenc . ']'
"     elseif &enc != ''
"       let str = str . '[' . &enc . ']'
"     endif
"   endif
"   if &ff != ''
"     let str = str . '[' . &ff . ']'
"   endif
"   return str
" endfunction
" set statusline=%<%f\ %m%r%h%w%=%{GetStatusEx()}\ \ %l,%c%V%8P
"
" "入力モード時、ステータスラインのカラーを変更
" let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'
"
" if has('syntax')
"   augroup InsertHook
"     autocmd!
"     autocmd InsertEnter * call s:StatusLine('Enter')
"     autocmd InsertLeave * call s:StatusLine('Leave')
"   augroup END
" endif
"
" let s:slhlcmd = ''
" function! s:StatusLine(mode)
"   if a:mode == 'Enter'
"     silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
"     silent exec g:hi_insert
"   else
"     highlight clear StatusLine
"     silent exec s:slhlcmd
"   endif
" endfunction
"
" function! s:GetHighlight(hi)
"   redir => hl
"   exec 'highlight '.a:hi
"   redir END
"   let hl = substitute(hl, '[\r\n]', '', 'g')
"   let hl = substitute(hl, 'xxx', '', '')
"   return hl
" endfunction

"自動的に QuickFix リストを表示する
autocmd QuickfixCmdPost make,grep,grepadd,vimgrep,vimgrepadd cwin
autocmd QuickfixCmdPost lmake,lgrep,lgrepadd,lvimgrep,lvimgrepadd lwin


"##### View #####
set number
set title
set showmatch   "Emphasize the bracket corresponding to when you input a bracket
syntax on 
"set list        " show invisible character
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
set cursorline
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END
hi clear CursorLine
hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black

" コマンド実行中は再描画しない
set lazyredraw
" 高速ターミナル接続を行う
set ttyfast


"#### Search ####
set ignorecase "Ignore upper/lower case
set smartcase "Distinguish cases when contains upper case
set wrapscan "Back to top when finds until the end
set incsearch
set hlsearch   " 検索文字をハイライト
"Escの2回押しでハイライト消去
nmap <ESC><ESC> ;nohlsearch<CR><ESC>


"#### Edit ####
" insertモードを抜けるとIMEオフ
"set smartindent "indent automatically
set autoindent   "indent automatically
" set paste
set noimdisable
set iminsert=0 imsearch=0
set noimcmdline
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
" XMLの閉タグを自動挿入
augroup MyXML
  autocmd!
  autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
augroup END
" カーソルから行頭まで削除
nnoremap <silent> <C-d> d0

" カーソルから行頭まで削除(インサートモード)
inoremap <silent> <C-k> <Esc>lc^
" カーソルから行末まで削除(インサートモード)
inoremap <silent> <C-d> <Esc>lc$
" カーソルから行頭までヤンク(インサートモード)
inoremap <silent> <C-y>e <Esc>ly0<Insert>
" カーソルから行末までヤンク(インサートモード)
inoremap <silent> <C-y>0 <Esc>ly$<Insert>


"#### KeyBindings ####
" paste clipboard using Ctrl+p
imap <C-p>  <ESC>"*pa
" " インサートモードでもhjklで移動
" inoremap <C-j> <Down>
" inoremap <C-k> <Up>
" inoremap <C-h> <Left>
" inoremap <C-l> <Right>


