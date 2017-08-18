" =======================================================================
" plugin/view.vim
" =======================================================================
scriptencoding utf-8

" UI: {{{1
" -----------------------------------------------------------------------
let &listchars='tab:⋮ ,extends:⟫,precedes:⟪,nbsp:␣,trail:·'
let &fillchars='diff:⣿,vert:│,fold:─'
let &showbreak='↳ '

" Highlights: {{{1
" -----------------------------------------------------------------------

if g:colors_name ==# 'hybrid'
  highlight! clear SignColumn
  highlight! clear FoldColumn
  highlight! ColorColumn guibg=#2C323C
  highlight! CursorLine guibg=#2C323C
  highlight! EndOfBuffer guifg=#282c34
  highlight! VertSplit guifg=#425059
endif

highlight! Comment cterm=italic gui=italic

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" -----------------------------------------------------------------------
" vim:foldmethod=marker
