" =======================================================================
" plugin/view.vim
" =======================================================================
scriptencoding utf-8

" UI:
" -----------------------------------------------------------------------
let &listchars='tab:⋮ ,extends:⟫,precedes:⟪,nbsp:␣,trail:·'
let &fillchars='diff:⣿,vert:│,fold: '
let &showbreak='↳ '

" Highlights:
" -----------------------------------------------------------------------
highlight! clear QuickFixLine
highlight! QuickFixLine cterm=underline gui=underline guibg=none

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Modeline {{{1
" -----------------------------------------------------------------------
" vim:foldmethod=marker
