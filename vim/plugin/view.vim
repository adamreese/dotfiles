" =======================================================================
" plugin/view.vim
" =======================================================================

scriptencoding utf-8

let &listchars='tab:⋮ ,extends:⟫,precedes:⟪,nbsp:␣,trail:·'
let &fillchars='vert:┃,fold:─'
let &showbreak='↳ '

highlight! clear SignColumn
highlight! clear FoldColumn
highlight! Comment cterm=italic gui=italic
highlight! ColorColumn guibg=#303030

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'