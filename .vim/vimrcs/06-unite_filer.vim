"" Shougo/vimfiler
let g:vimfiler_edit_action = 'tabopen'
let g:vimfiler_safe_mode_by_default = 0
augroup vimfiler_augroup
	autocmd!
	" open tree by enter
	autocmd FileType vimfiler nmap <buffer> <CR> <Plug>(vimfiler_expand_or_edit)
augroup END

"" Shougo/unite
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable =1
let g:unite_source_file_mru_limit = 200
let g:unite_source_menu_menus = {
\   "shortcut" : {
\       "description" : "Utility functions",
\       "command_candidates" : [
\           ["Change current directory", ":lcd %:p:h"],
\           ["Edit vimrc", "edit ~/.vimrc"],
\           ["Reload vimrc", "source ~/.vimrc"],
\           ["Keymapping", "Unite mapping"],
\           ["Unite Beautiful Attack", "Unite -auto-preview colorscheme"],
\           ["Unite-output:message", "Unite output:message"],
\       ],
\   },
\}
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif
nnoremap <silent> ,uy  :<C-u>Unite history/yank<CR>
nnoremap <silent> ,ub  :<C-u>Unite buffer<CR>
nnoremap <silent> ,uf  :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,ur  :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> ,uu  :<C-u>Unite file_mru buffer<CR>
nnoremap <silent> ,um  :<C-u>Unite menu:shortcut<CR>
nnoremap <silent> ,ug  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> ,ugr :<C-u>UniteResume search-buffer<CR>
