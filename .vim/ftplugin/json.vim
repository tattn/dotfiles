filetype off

set runtimepath+=~/.vim/bundle/neobundle.vim
call neobundle#begin(expand('~/.vim/bundle/'))

"" A better JSON for Vim
NeoBundle 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0

call neobundle#end()
filetype plugin indent on

NeoBundleCheck		" check uninstalled plugins

