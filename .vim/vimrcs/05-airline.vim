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
