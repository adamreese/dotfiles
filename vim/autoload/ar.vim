" =======================================================================
" autoload/ar.vim
" =======================================================================
if exists('g:loaded_ar') | finish | endif
let g:loaded_ar = v:true

" Reload and sync syntax.
function! ar#ReloadSyntax() abort
  syntax sync fromstart
  redraw!
endfunction
