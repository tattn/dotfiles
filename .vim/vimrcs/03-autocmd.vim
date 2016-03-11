"" The PC is fast enough, do syntax highlight syncing from start
augroup basic_augroup
	autocmd!
	autocmd BufEnter * :syntax sync fromstart

	"" Remember cursor position
	autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

	"" txt
	autocmd BufRead,BufNewFile *.txt call s:setupWrapping()

	"" make/cmake
	autocmd FileType make setlocal noexpandtab
	autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake

	"" auto compiling for coffee script
	au BufRead,BufNewFile,BufReadPre *.coffee setlocal filetype=coffee
	au BufWritePost *.coffee compiler coffee | silent make!

	if has("gui_running")
		autocmd! BufWritePre * :call TrimWhiteSpace()
	endif
augroup END


"" Add filetypes
augroup addfiletype
	au!
	au BufNewFile,BufRead *.gyp setf gyp
	au BufNewFile,BufRead *.gypi setf gyp
augroup END

"" Tab settings
augroup vimrc
	autocmd!
	autocmd FileType vim setlocal shiftwidth=2 tabstop=2 softtabstop=2
	autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
	autocmd FileType eruby setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
	autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
	autocmd FileType coffee setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
	autocmd FileType perl setlocal shiftwidth=2 tabstop=2 softtabstop=2
	autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2
	autocmd FileType css  setlocal shiftwidth=2 tabstop=2 softtabstop=2
	autocmd FileType scss  setlocal shiftwidth=2 tabstop=2 softtabstop=2
	autocmd FileType gyp  setlocal shiftwidth=2 tabstop=2 softtabstop=2
	autocmd FileType yaml  setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup END

"" Show QuickFix list automatically
augroup quickfix
	autocmd!
	autocmd QuickfixCmdPost make,grep,grepadd,vimgrep,vimgrepadd cwin
	autocmd QuickfixCmdPost lmake,lgrep,lgrepadd,lvimgrep,lvimgrepadd lwin
augroup END

"" カーソルを現在のウィンドウのみに表示
augroup currentcursorline
	autocmd!
	autocmd currentcursorline
	autocmd WinLeave * set nocursorline
	autocmd WinEnter,BufRead * set cursorline
augroup END

"" CRuby
augroup cruby_settings
	autocmd!
	au FileType cruby setl ts=8 sw=4 noexpandtab
	au FileType cruby let g:changelog_timeformat = "%c"
	au FileType cruby let g:changelog_username = "Tatsuya Tanaka tatsuya@sw.it.aoyama.ac.jp"
augroup END

set autoread      " Read automatically when the file is rewrited

