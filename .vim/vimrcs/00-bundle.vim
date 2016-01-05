set nocompatible

let neobundle_readme=expand('~/.vim/bundle/neobundle.vim/README.md')

if !filereadable(neobundle_readme)
  echo "Installing NeoBundle..."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim/
endif

set runtimepath+=~/.vim/bundle/neobundle.vim
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'


"################################################################
"" NeoBundle install packages
"################################################################

" Unite and VimFiler
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/neomru.vim'

"" vim-surround
NeoBundle 'tpope/vim-surround'

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

"" Fugitive for git
NeoBundle 'tpope/vim-fugitive'

"" Syntax checker
" NeoBundle 'scrooloose/syntastic'

"" Gtags
NeoBundle 'vim-scripts/gtags.vim'


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
"" C/C++
"---------------------------
"" AutoComplete for C/C++
NeoBundleLazy 'Rip-Rip/clang_complete', {
            \ 'autoload' : {'filetypes' : ['c', 'cpp']}
            \ }

" CRuby
NeoBundle 'mrkn/vim-cruby'


call neobundle#end()

filetype plugin indent on

NeoBundleCheck		" check uninstalled plugins


"################################################################
"" NeoBundle Configuration
"################################################################

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
" for php
au! FileType php nmap <buffer><C-_>c :TCommentAs php_surround<CR>
au! FileType php vmap <buffer><C-_>c :TCommentAs php_surround<CR>


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

"" Shougo/neosnippet
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

if has('conceal')
  set conceallevel=2 concealcursor=i
endif


"" scroolloose/syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
"
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

