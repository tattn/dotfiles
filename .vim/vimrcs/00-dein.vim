if has('nvim')
if &compatible
  set nocompatible
endif
" dein.vimのディレクトリ
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" なければgit clone
if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set runtimepath^=' . s:dein_repo_dir

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " 管理するプラグインを記述したファイル
  let s:toml      = '~/.vim/.dein.toml'
  let s:lazy_toml = '~/.vim/.dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" vimprocだけは最初にインストールしてほしい
if dein#check_install(['vimproc'])
  call dein#install(['vimproc'])
endif
" その他インストールしていないものはこちらに入れる
if dein#check_install()
  call dein#install()
endif


""#######################################################################
"" Configuration

if dein#tap('deoplete.nvim') "{{{
	let g:deoplete#enable_at_startup = 1
endif "}}}

if dein#tap('tcomment_vim') "{{{
	let g:tcomment_types = {
				\'php_surround' : "<?php %s ?>",
				\'eruby_surround' : "<%% %s %%>",
				\'eruby_surround_minus' : "<%% %s -%%>",
				\'eruby_surround_equality' : "<%%= %s %%>",
				\}
	" for php
	au! FileType php nmap <buffer><C-_>c :TCommentAs php_surround<CR>
	au! FileType php vmap <buffer><C-_>c :TCommentAs php_surround<CR>
endif "}}}

if dein#tap('vim-quickrun') "{{{
	let g:quickrun_config = {
				\   "_" : {
				\       "runner" : "vimproc",
				\       "runner/vimproc/updatetime" : 60
				\   },
				\}
	set splitbelow
	nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
endif "}}}

if dein#tap('vim-indent-guides') "{{{
	" let s:hooks = neobundle#get_hooks("vim-indent-guides")
	" function! s:hooks.on_source(bundle)
		" let g:indent_guides_guide_size = 1
		" IndentGuidesEnable
	" endfunction
endif "}}}

if dein#tap('neosnippet') "{{{
	imap <C-k>     <Plug>(neosnippet_expand_or_jump)
	smap <C-k>     <Plug>(neosnippet_expand_or_jump)
	xmap <C-k>     <Plug>(neosnippet_expand_target)
	xmap <TAB>     <Plug>(neosnippet_expand_target)

	if has('conceal')
		set conceallevel=2 concealcursor=i
	endif
endif "}}}

endif
