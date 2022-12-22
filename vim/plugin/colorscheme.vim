" =======================================================================
" plugin/colorscheme.vim
" =======================================================================

let g:hybrid_custom_term_colors = v:true
" silent! colorscheme hybrid
colorscheme gruvbox-material

" Highlights:
" -----------------------------------------------------------------------
highlight! clear QuickFixLine
highlight! QuickFixLine cterm=underline gui=underline guibg=NONE

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
