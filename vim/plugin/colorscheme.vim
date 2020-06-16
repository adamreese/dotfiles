" =======================================================================
" plugin/colorscheme.vim
" =======================================================================

let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_enable_bold = v:true
let g:gruvbox_material_enable_italic = v:true
let g:gruvbox_material_palette = 'mix'
let g:gruvbox_material_transparent_background = v:true

function! s:GruvboxInit() abort
  highlight GruvboxRedSign ctermbg=NONE guibg=NONE
  highlight GruvboxGreenSign ctermbg=NONE guibg=NONE
  highlight GruvboxYellowSign ctermbg=NONE guibg=NONE
  highlight GruvboxBlueSign ctermbg=NONE guibg=NONE
  highlight GruvboxPurpleSign ctermbg=NONE guibg=NONE
  highlight GruvboxAquaSign ctermbg=NONE guibg=NONE
  highlight PmenuSel cterm=bold ctermfg=229 ctermbg=109 gui=bold guifg=#fbf1c7 guibg=#83a598

  let g:lightline.colorscheme = 'gruvbox_material'

  call lightline#init()
  call lightline#colorscheme()
endfunction

augroup ar_colorscheme
  autocmd!
  autocmd ColorScheme gruvbox-material call s:GruvboxInit()
augroup END

let g:hybrid_custom_term_colors = v:true
silent! colorscheme hybrid

" Highlights:
" -----------------------------------------------------------------------
highlight! clear QuickFixLine
highlight! QuickFixLine cterm=underline gui=underline guibg=NONE

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
