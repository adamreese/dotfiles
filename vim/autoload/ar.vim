" =======================================================================
" autoload/ar.vim
" =======================================================================

if exists('g:loaded_ar') | finish | endif
let g:loaded_ar = 1

" -----------------------------------------------------------------------
"  ar#profile() {{{1
" -----------------------------------------------------------------------
function! ar#profile(bang) abort
  if a:bang
    profile pause
    noautocmd qall
  else
    profile start /tmp/profile.log
    profile func *
    profile file *
  endif
endfunction

" -----------------------------------------------------------------------
" ar#reload_syntax() {{{1
" -----------------------------------------------------------------------
function! ar#reload_syntax() abort
  syntax sync fromstart
  redraw!
endfunction

" -----------------------------------------------------------------------
" vim:foldmethod=marker
