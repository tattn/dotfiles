augroup filetypedetect
  au!
  au BufRead,BufNewFile *.vim setf vim
  au BufRead,BufNewFile Gemfile setf ruby
  au BufRead,BufNewFile *.rb setf ruby
	au BufRead,BufNewFile [rR]antfile,*.rant,[rR]akefile,*.rake	setf ruby
	au BufRead,BufNewFile *.haml setf haml
	au BufRead,BufNewFile *.slim setf slim
  au BufRead,BufNewFile *.py setf python
  au BufRead,BufNewFile *.php setf php
  au BufRead,BufNewFile *.swift setf swift
	au BufRead,BufNewFile *.markdown,*.md setf markdown
  au BufRead,BufNewFile *.tex setf tex
augroup END
