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
if g:colors_name ==# 'hybrid'
  highlight! clear SignColumn
  highlight! clear FoldColumn

  highlight! ColorColumn guibg=#2C323C
  highlight! CursorLine  guibg=#2C323C
  highlight! EndOfBuffer guifg=#282c34
  highlight! VertSplit   guifg=#425059
endif

highlight! Comment cterm=italic gui=italic

highlight! clear QuickFixLine
highlight! QuickFixLine cterm=underline gui=underline guibg=none

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

highlight SpellBad    term=reverse   ctermbg=12 gui=undercurl guisp=Red       " badly spelled word
highlight SpellCap    term=reverse   ctermbg=9  gui=undercurl guisp=Blue      " word with wrong caps
highlight SpellRare   term=reverse   ctermbg=13 gui=undercurl guisp=Magenta   " rare word
highlight SpellLocale term=underline ctermbg=11 gui=undercurl guisp=DarkCyan  " word only exists in other region

" Modeline {{{1
" -----------------------------------------------------------------------
" vim:foldmethod=marker
