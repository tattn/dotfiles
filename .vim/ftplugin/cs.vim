filetype off

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

filetype plugin indent on

"" omnishar-vim
" Get Code Issues and syntax errors
let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']
" If you are using the omnisharp-roslyn backend, use the following
" let g:syntastic_cs_checkers = ['code_checker']

setlocal omnifunc=OmniSharp#Complete

" Synchronous build (blocks Vim)
"autocmd FileType cs nnoremap <F5> :wa!<cr>:OmniSharpBuild<cr>
" Builds can also run asynchronously with vim-dispatch installed
nnoremap <leader>b :wa!<cr>:OmniSharpBuildAsync<cr>
" automatic syntax check on events (TextChanged requires Vim 7.4)
" autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

" Automatically add new cs files to the nearest project on save
" autocmd BufWritePost *.cs call OmniSharp#AddToProject()

"show type information automatically when the cursor stops moving
call OmniSharp#TypeLookupWithoutDocumentation()

nnoremap gd :OmniSharpGotoDefinition<cr>
nnoremap <leader>fi :OmniSharpFindImplementations<cr>
nnoremap <leader>ft :OmniSharpFindType<cr>
nnoremap <leader>fs :OmniSharpFindSymbol<cr>
nnoremap <leader>fu :OmniSharpFindUsages<cr>
"finds members in the current buffer
nnoremap <leader>fm :OmniSharpFindMembers<cr>
" cursor can be anywhere on the line containing an issue
nnoremap <leader>x  :OmniSharpFixIssue<cr>
nnoremap <leader>fx :OmniSharpFixUsings<cr>
nnoremap <leader>tt :OmniSharpTypeLookup<cr>
nnoremap <leader>dc :OmniSharpDocumentation<cr>
"navigate up by method/property/field
nnoremap <C-K> :OmniSharpNavigateUp<cr>
"navigate down by method/property/field
nnoremap <C-J> :OmniSharpNavigateDown<cr>

