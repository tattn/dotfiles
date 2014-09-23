set nocompatible

"#### Basics ####
let mapleader="," " Key map leader
" Escape insert mode
imap <C-j>  <ESC>
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

" Unite and VimFiler
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/neomru.vim'
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,uu :<C-u>Unite file_mru buffer<CR>

" rails.vim
NeoBundle 'tpope/vim-rails'

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

"AutoComplete for Ruby
NeoBundleLazy 'marcus/rsense', {
      \ 'autoload': {
      \   'filetypes': 'ruby',
      \ },
      \ }

NeoBundle 'supermomonga/neocomplete-rsense.vim', {
      \ 'depends': ['Shougo/neocomplete.vim', 'marcus/rsense'],
      \ }
let g:rsenseUseOmniFunc = 1

" NeoSnippet
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
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

" show QuickFix list automatically 
autocmd QuickfixCmdPost make,grep,grepadd,vimgrep,vimgrepadd cwin
autocmd QuickfixCmdPost lmake,lgrep,lgrepadd,lvimgrep,lvimgrepadd lwin


"##### View #####
set number
set title
set showmatch   "hilight the bracket corresponding to when you input a bracket
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

set lazyredraw
set ttyfast


"#### Search ####
set ignorecase "Ignore upper/lower case
set smartcase  "Distinguish cases when contains upper case
set wrapscan   "Back to top when finds until the end
set incsearch
set hlsearch   " hilight word
" cancel hilight
nnoremap <ESC><ESC> :noh<CR><ESC>


"#### Edit ####
"set smartindent "indent automatically
set autoindent   "indent automatically
" set paste
set noimdisable
set iminsert=0 imsearch=0
set noimcmdline
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
" auto input end bracket
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
vnoremap { "zdi^V{<C-R>z}<ESC>
vnoremap [ "zdi^V[<C-R>z]<ESC>
vnoremap ( "zdi^V(<C-R>z)<ESC>
vnoremap " "zdi^V"<C-R>z^V"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>
" fix arrow keys
imap OA <UP>
imap OB <DOWN>
imap OC <RIGHT>
imap OD <LEFT>


