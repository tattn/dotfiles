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
	au BufWritePost *.coffee compiler coffee | silent make!

	if has("gui_running")
		autocmd! BufWritePre * :call TrimWhiteSpace()
	endif
augroup END


"" Tab settings
augroup vimrc
	autocmd!
	autocmd FileType vim setlocal shiftwidth=2 tabstop=2 softtabstop=2
	autocmd FileType ruby setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
	autocmd FileType eruby setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
	autocmd FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
	autocmd FileType coffee setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
	autocmd FileType perl setlocal shiftwidth=2 tabstop=2 softtabstop=2
	autocmd FileType html setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
	autocmd FileType css setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
	autocmd FileType scss setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
	autocmd FileType stylus setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
	autocmd FileType gyp setlocal shiftwidth=2 tabstop=2 softtabstop=2
	autocmd FileType yaml setlocal shiftwidth=2 tabstop=2 softtabstop=2 expandtab
	autocmd FileType swift setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab
	autocmd FileType c setlocal shiftwidth=4 tabstop=4 softtabstop=4 expandtab
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

set autoread      " Read automatically when the file is rewrited

