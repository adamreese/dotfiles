" =======================================================================
" plugin/colorscheme.vim
" =======================================================================

let g:hybrid_custom_term_colors = v:true
" silent! colorscheme hybrid

" Highlights:
" -----------------------------------------------------------------------
highlight! clear QuickFixLine
highlight! QuickFixLine cterm=underline gui=underline guibg=NONE

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

function! s:gruvbox_material() abort
  highlight! link CursorLineNr YellowBold
  highlight! FloatBorder guibg=NONE

  highlight! clear vimCommentTitle

  highlight! link NeoTreeNormal Normal
  highlight! clear NeoTreeEndOfBuffer

endfunction

let g:gruvbox_material_ui_contrast = 'high'
let g:gruvbox_material_colors_override = {
      \ 'bg0':            ['#222526', '234'],
      \ 'bg2':            ['#222526', '235'],
      \ 'bg_statusline1': ['#222526', '235'],
      \ 'yellow':         ['#d6b676', '214'],
      \ }

autocmd! ColorScheme gruvbox-material call s:gruvbox_material()
colorscheme gruvbox-material
