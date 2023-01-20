" =======================================================================
" autoload/profile.vim
" =======================================================================
if exists('g:loaded_profile') | finish | endif
let g:loaded_profile = v:true

" Toggle profiling
function! profile#() abort
  if v:profiling
    profile pause
    noautocmd qall
  else
    profile start /tmp/profile.log
    profile func *
    profile file *

    set verbose=9
    set verbosefile=/tmp/verbose.log
  endif
endfunction
