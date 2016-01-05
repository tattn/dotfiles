filetype off

"" AutoComplete for Ruby
NeoBundleLazy 'marcus/rsense', {
      \ 'autoload': {
      \   'filetypes': 'ruby',
      \ },
      \ }
NeoBundle 'supermomonga/neocomplete-rsense.vim', {
      \ 'depends': ['Shougo/neocomplete.vim', 'marcus/rsense'],
      \ }

"---------------------------
"" Rails
"---------------------------
"" rails.vim
NeoBundle 'tpope/vim-rails'

"" unite-rails.vim
NeoBundle 'basyura/unite-rails'

"" vim-ruby
NeoBundle 'vim-ruby/vim-ruby'

"" hilighter
NeoBundle 'slim-template/vim-slim'

filetype plugin indent on

"" marcus/rsense
let g:rsenseUseOmniFunc = 1

