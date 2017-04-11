" =======================================================================
" autoload/acr.vim
" =======================================================================

if exists('g:loaded_acr') | finish | endif
let g:loaded_acr = 1

" -----------------------------------------------------------------------
"  arc#profile() {{{
" -----------------------------------------------------------------------
function! acr#profile(bang) abort
  if a:bang
    profile pause
    noautocmd qall
  else
    profile start /tmp/profile.log
    profile func *
    profile file *
  endif
endfunction "}}}

" -----------------------------------------------------------------------
" vim:foldmethod=marker
