" swap(:, ;)
nnoremap ; :
nnoremap : ;

" Escape insert mode
inoremap <C-j> <ESC>

" Cancel hilight
nnoremap <ESC><ESC> :noh<CR><ESC>

"" Split
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

"" Git
noremap <Leader>ga :!git add .<CR>
noremap <Leader>gc :!git commit -m '<C-R>="'"<CR>
noremap <Leader>gsh :!git push<CR>
noremap <Leader>gll :!git pull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>

"" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

"" Opens an edit command with the path of the currently edited file filled in
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

"" Opens a tab edit command with the path of the currently edited file filled
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

"" CTags
nnoremap <C-]> g<C-]>

"" Gtags
" Grep in source codes
nnoremap <C-g> :Gtags -g<CR>
" Show functions in current file
nnoremap <C-l> :Gtags -f %<CR>
" Search definition
nnoremap <C-d> :Gtags <C-r><C-w><CR>
" Search reference
nnoremap <C-k> :Gtags -r <C-r><C-w><CR>
" Jump to next
nnoremap <C-n> :cn<CR>
" Jump to previous
nnoremap <C-p> :cp<CR>

"" QuickFix
" Close quickfix
nnoremap <S-Q> :ccl<CR>

" Save as a super user
cmap w!! w !sudo tee > /dev/null %

" Terminal emurator
if has('nvim')
  nnoremap <leader>t  :vsplit +terminal<cr>
  tnoremap <C-j>      <c-\><c-n>
  tnoremap <esc>      <c-\><c-n>
  tnoremap <a-h>      <c-\><c-n><c-w>h
  tnoremap <a-j>      <c-\><c-n><c-w>j
  tnoremap <a-k>      <c-\><c-n><c-w>k
  tnoremap <a-l>      <c-\><c-n><c-w>l
endif

augroup keymap_html
	autocmd!
	autocmd FileType html nnoremap <F5> :w <Bar> !open %<CR>
augroup END

