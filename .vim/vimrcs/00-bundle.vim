set nocompatible

" if has('vim_starting')
"
"   " Required:
"   set runtimepath+=~/.vim/bundle/neobundle.vim
"   call neobundle#rc(expand('~/.vim/bundle'))
" endif
"
let neobundle_readme=expand('~/.vim/bundle/neobundle.vim/README.md')

if !filereadable(neobundle_readme)
  echo "Installing NeoBundle..."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim/
endif

" Required:
set runtimepath+=~/.vim/bundle/neobundle.vim
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'


"################################################################
"" NeoBundle install packages
"################################################################

" Unite and VimFiler
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/neomru.vim'


NeoBundle 'scrooloose/nerdtree'

"" vim-surround
NeoBundle 'tpope/vim-surround'

"" Comment out
NeoBundle 'tomtom/tcomment_vim'

"" VimProc for asynchronous
NeoBundle "Shougo/vimproc", {
        \ "build": {
        \   "windows"   : "make -f make_mingw32.mak",
        \   "cygwin"    : "make -f make_cygwin.mak",
        \   "mac"       : "make -f make_mac.mak",
        \   "unix"      : "make -f make_unix.mak",
        \ }}

"" QuickRun
NeoBundle 'thinca/vim-quickrun'

"" Indent guides
NeoBundle "nathanaelkane/vim-indent-guides"

"" Colors
NeoBundle 'tomasr/molokai'
NeoBundle 'altercation/vim-colors-solarized'

"" Beautiful StatusLine
NeoBundle 'bling/vim-airline'

"" AutoComplete
NeoBundle 'Shougo/neocomplete.vim'

"" NeoSnippet
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'

"" Fugitive for git
NeoBundle 'tpope/vim-fugitive'

"" Syntax checker
" NeoBundle 'scrooloose/syntastic'

"" Gtags
NeoBundle 'vim-scripts/gtags.vim'


"---------------------------
"" CoffeeScript
"---------------------------
"" hilighter
NeoBundle 'kchmck/vim-coffee-script'

"---------------------------
"" Less
"---------------------------
"" hilighter
NeoBundle 'groenewege/vim-less'

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

"---------------------------
"" C/C++
"---------------------------
"" AutoComplete for C/C++
NeoBundleLazy 'Rip-Rip/clang_complete', {
            \ 'autoload' : {'filetypes' : ['c', 'cpp']}
            \ }

"---------------------------
"" Python
"---------------------------
"" AutoComplete for Python
NeoBundle 'davidhalter/jedi-vim'
" NeoBundle 'jmcantrell/vim-virtualenv'
NeoBundleLazy 'lambdalisue/vim-pyenv', {
        \ 'depends': ['davidhalter/jedi-vim'],
        \ 'autoload': {
        \   'filetypes': ['python', 'python3'],
        \ }}

"---------------------------
"" Ruby
"---------------------------
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
"" C#
"---------------------------
" AutoComplete for C#
NeoBundleLazy 'OmniSharp/omnisharp-vim', {
\   'autoload': { 'filetypes': [ 'cs', 'csi', 'csx' ] },
\   'build': {
\     'windows' : 'msbuild server/OmniSharp.sln',
\     'mac': 'xbuild server/OmniSharp.sln',
\     'unix': 'xbuild server/OmniSharp.sln',
\   },
\ }

" Connect to OmniSharp
NeoBundle 'tpope/vim-dispatch'

" CRuby
NeoBundle 'mrkn/vim-cruby'


call neobundle#end()

filetype plugin indent on

NeoBundleCheck		" check uninstalled plugins


"################################################################
"" NeoBundle Configuration
"################################################################

"" Shougo/vimfiler
" let g:vimfiler_edit_action = 'tabopen'
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


"" scrooloose/nerdtree
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

"" tomtom/tcomment_vim
" if !exists('g:tcomment_types')
"   let g:tcomment_types = {}
" endif
let g:tcomment_types = {
      \'php_surround' : "<?php %s ?>",
      \'eruby_surround' : "<%% %s %%>",
      \'eruby_surround_minus' : "<%% %s -%%>",
      \'eruby_surround_equality' : "<%%= %s %%>",
\}
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
" for php
au! FileType php nmap <buffer><C-_>c :TCommentAs php_surround<CR>
au! FileType php vmap <buffer><C-_>c :TCommentAs php_surround<CR>


"" thinca/vim-quickrun
let g:quickrun_config = {
\   "_" : {
\       "runner" : "vimproc",
\       "runner/vimproc/updatetime" : 60
\   },
\}
set splitbelow
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"


"" nathanaelkane/vim-indent-guides
let s:hooks = neobundle#get_hooks("vim-indent-guides")
function! s:hooks.on_source(bundle)
  let g:indent_guides_guide_size = 1
  IndentGuidesEnable
endfunction


"" bling/vim-airline
" let g:airline_theme = 'molokai'
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
" let g:airline_section_a = airline#section#create(['mode','','branch'])
let g:airline_section_b =
			\ '%{airline#extensions#branch#get_head()}' .
			\ '%{""!=airline#extensions#branch#get_head()?("  " . g:airline_left_alt_sep . " "):""}' .
			\ '%{airline#parts#readonly()}' .
			\ '%t%( %M%)'
" let g:airline_section_c = pyenv#statusline#component
let s:sep = " %{get(g:, 'airline_right_alt_sep', '')} "
let g:airline_section_x =
    \ "%{strlen(&fileformat)?&fileformat:''}".s:sep.
    \ "%{strlen(&fenc)?&fenc:&enc}".s:sep.
    \ "%{strlen(&filetype)?&filetype:'no ft'}"
let g:airline_section_y = '%3p%%'
let g:airline_section_z = get(g:, 'airline_linecolumn_prefix', '').'%3l:%-2v'
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline_theme='badwolf'
let g:airline_left_sep = '⮀'
let g:airline_right_sep = '⮂'
let g:airline_symbols.linenr = '⭡'
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline#extensions#tabline#left_sep = '⮀'
let g:airline#extensions#tabline#left_alt_sep = '⮀'
" let g:airline_symbols.branch = '⭠'
" let g:airline_symbols.readonly = '⭤'
let g:airline#extensions#readonly#symbol = '⭤ '


"" Shougo/neocomplete.vim
let g:neocomplete#enable_auto_select = 0
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" For other plugins
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
" Completion
imap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
imap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
inoremap <expr><C-Space> pumvisible() ? "\<down>" : neocomplete#start_manual_complete()


"" Rip-Rip/clang_complete
let g:clang_user_options = '-std=c++11 -stdlib=libc++'

let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#force_omni_input_patterns.c =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.cpp =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
let g:neocomplete#force_omni_input_patterns.objc =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.objcpp =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_use_library=1
let g:clang_debug=1
if has('mac')
  let g:clang_library_path="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib"
endif


"" davidhalter/jedi-vim
" let g:jedi#completions_enabled=0
let g:jedi#auto_vim_configuration = 1
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0   " no select
let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'
augroup jedi_augroup
	autocmd!
	autocmd FileType python setlocal completeopt-=preview " docstringは表示しない
	autocmd FileType python setlocal omnifunc=jedi#completions
augroup END


"" marcus/rsense
let g:rsenseUseOmniFunc = 1


"" Shougo/neosnippet
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

if has('conceal')
  set conceallevel=2 concealcursor=i
endif


"" scroolloose/syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
"
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

"" omnishar-vim
" Get Code Issues and syntax errors
let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']
" If you are using the omnisharp-roslyn backend, use the following
" let g:syntastic_cs_checkers = ['code_checker']
augroup omnisharp_commands
	autocmd!

	"Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
	autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

	" Synchronous build (blocks Vim)
	"autocmd FileType cs nnoremap <F5> :wa!<cr>:OmniSharpBuild<cr>
	" Builds can also run asynchronously with vim-dispatch installed
	autocmd FileType cs nnoremap <leader>b :wa!<cr>:OmniSharpBuildAsync<cr>
	" automatic syntax check on events (TextChanged requires Vim 7.4)
	" autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

	" Automatically add new cs files to the nearest project on save
	" autocmd BufWritePost *.cs call OmniSharp#AddToProject()

	"show type information automatically when the cursor stops moving
	autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

	"The following commands are contextual, based on the current cursor position.

	autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
	autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
	autocmd FileType cs nnoremap <leader>ft :OmniSharpFindType<cr>
	autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
	autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
	"finds members in the current buffer
	autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembers<cr>
	" cursor can be anywhere on the line containing an issue
	autocmd FileType cs nnoremap <leader>x  :OmniSharpFixIssue<cr>
	autocmd FileType cs nnoremap <leader>fx :OmniSharpFixUsings<cr>
	autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
	autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
	"navigate up by method/property/field
	autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr>
	"navigate down by method/property/field
	autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr>

augroup END

augroup omnicomplete_augroup
	autocmd!
	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
	autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
	autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
augroup END

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.cs = '.*[^=\);]'


