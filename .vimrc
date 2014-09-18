"#### Basics ####
let mapleader="," "Key map reader
set scrolloff=5   "Space when scrolling
set nobackup
set autoread      "Read automatically when the file is rewrited
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
filetype plugin on             " judge filetype


"#### StatusLine ####
set laststatus=2               " always show statusline
set ruler                      " show cursor position

" show encording
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

"入力モード時、ステータスラインのカラーを変更
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction

"自動的に QuickFix リストを表示する
autocmd QuickfixCmdPost make,grep,grepadd,vimgrep,vimgrepadd cwin
autocmd QuickfixCmdPost lmake,lgrep,lgrepadd,lvimgrep,lvimgrepadd lwin


"##### View #####
set number
set title
set showmatch   "Emphasize the bracket corresponding to when you input a bracket
syntax on
set tabstop=4
set smartindent "indent automatically
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
" インサートモードでもhjklで移動（Ctrl押すけどね）
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
" 対応する括弧に移動
nnoremap ( %
nnoremap ) %
