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
highlight! clear SignColumn
highlight! clear FoldColumn
highlight! Comment cterm=italic gui=italic
highlight! ColorColumn guibg=#303030

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" -----------------------------------------------------------------------
" vim:foldmethod=marker
