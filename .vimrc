set runtimepath+=~/.vim/
let vimrcs = split(glob("~/.vim/vimrcs/*"), "\n")
for vimrc in vimrcs
  execute ':source ' . vimrc
endfor

