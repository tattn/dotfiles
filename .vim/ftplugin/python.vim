filetype off

" if has('vim_starting')
"   set runtimepath+=~/.vim/bundle/neobundle.vim                 
"   call neobundle#rc(expand('~/.vim/bundle/'))
" endif   

"" AutoComplete for Python
NeoBundle 'davidhalter/jedi-vim'
" NeoBundle 'jmcantrell/vim-virtualenv'
NeoBundle 'lambdalisue/vim-pyenv'

filetype plugin indent on

"" davidhalter/jedi-vim
" let g:jedi#completions_enabled=0
let g:jedi#auto_vim_configuration = 1
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0   " no select
let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'
setlocal completeopt-=preview " docstringは表示しない
setlocal omnifunc=jedi#completions
