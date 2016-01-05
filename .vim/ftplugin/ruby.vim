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

"" tomtom/tcomment_vim
function! SetErubyMapping2()
  nmap <buffer> <C-_>c :TCommentAs eruby_surround<CR>
  nmap <buffer> <C-_>- :TCommentAs eruby_surround_minus<CR>
  nmap <buffer> <C-_>= :TCommentAs eruby_surround_equality<CR>

  vmap <buffer> <C-_>c :TCommentAs eruby_surround<CR>
  vmap <buffer> <C-_>- :TCommentAs eruby_surround_minus<CR>
  vmap <buffer> <C-_>= :TCommentAs eruby_surround_equality<CR>
endfunction
" for eruby
au! FileType eruby call SetErubyMapping2()
