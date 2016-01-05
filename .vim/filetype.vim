augroup filetypedetect
	au!
	au BufRead,BufNewFile Gemfile setfiletype ruby
  au BufRead,BufNewFile *.rb setfiletype ruby
  au BufRead,BufNewFile *.php setfiletype php
  au BufRead,BufNewFile *.swift setfiletype swift
augroup END
