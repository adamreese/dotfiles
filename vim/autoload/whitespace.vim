" =======================================================================
" autoload/whitespace.vim
" =======================================================================
if exists('g:loaded_whitespace') | finish | endif
let g:loaded_whitespace = 1

function! whitespace#clean() abort
  let l:pos = winsaveview()
  let l:search=@/

  execute '%s/\s\+$//e'

  let @/=l:search
  call winrestview(l:pos)
endfunction
