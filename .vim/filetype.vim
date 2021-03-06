" Function used for patterns that end in a star: don't set the filetype if the
" file name matches ft_ignore_pat.
func! s:StarSetf(ft)
  if expand("<amatch>") !~ g:ft_ignore_pat
    exe 'setf ' . a:ft
  endif
endfunc

augroup filetypedetect
  au!
  au BufRead,BufNewFile *.vim setf vim
  au BufRead,BufNewFile Gemfile setf ruby
  au BufRead,BufNewFile *.js,*.jsx setf javascript
  au BufRead,BufNewFile *.json setf json
  au BufRead,BufNewFile *.xml setf xml
  au BufRead,BufNewFile *.coffee setf coffee
  au BufRead,BufNewFile *.html setf html
  au BufRead,BufNewFile *.rb setf ruby
  au BufRead,BufNewFile [rR]antfile,*.rant,[rR]akefile,*.rake,*.podspec,Cartfile,Podfile,Fastfile setf ruby
  au BufRead,BufNewFile *.styl setf stylus
  au BufRead,BufNewFile *.yaml,*yml setf yaml
  au BufRead,BufNewFile *.haml setf haml
  au BufRead,BufNewFile *.slim setf slim
  au BufRead,BufNewFile *.py setf python
  au BufRead,BufNewFile *.php setf php
  au BufRead,BufNewFile *.swift setf swift
  au BufRead,BufNewFile *.dart setf dart
  au BufRead,BufNewFile *.c,*.h setf c
  au BufRead,BufNewFile *.cpp,*.cxx,*hpp setf cpp
  au BufRead,BufNewFile *.zshenv setf zsh
  au BufRead,BufNewFile *.zshrc setf zsh
  au BufRead,BufNewFile *.markdown,*.md setf markdown
  au BufRead,BufNewFile *.tex setf tex
  au BufRead,BufNewFile *.sh,*.zsh setf sh
  au BufNewFile,BufRead .bashrc*,bashrc,bash.bashrc,.bash[_-]profile*,.bash[_-]logout*,.bash[_-]aliases*,*.bash,*/{,.}bash[_-]completion{,.d,.sh}{,/*},*.ebuild,*.eclass call SetFileTypeSH("bash")
  au BufNewFile,BufRead .kshrc*,*.ksh call SetFileTypeSH("ksh")
  au BufNewFile,BufRead */etc/profile,.profile*,*.sh,*.env call SetFileTypeSH(getline(1))
  au BufNewFile,BufRead .zprofile,*/etc/zprofile,.zfbfmarks  setf zsh
  au BufNewFile,BufRead .zsh*,.zlog*,.zcompdump*  call s:StarSetf('zsh')
  au BufNewFile,BufRead *.zsh			setf zsh
  au BufRead,BufNewFile .gitconfig setf gitconfig
	au BufNewFile,BufRead *.gyp,*.gypi setf gyp
	au BufNewFile,BufRead *.swift set ft=swift
	au BufNewFile,BufRead *.go setf go
	au BufNewFile,BufRead *.ts setf typescript
	au BufNewFile,BufRead Dockerfile setf Dockerfile
	au BufNewFile,BufRead *.sql setf sql
augroup END
