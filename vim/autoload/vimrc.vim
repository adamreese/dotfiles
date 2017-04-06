" =======================================================================
" autoload/vimrc.vim
" =======================================================================

" -----------------------------------------------------------------------
"  vimrc#profile() {{{
" -----------------------------------------------------------------------
function! vimrc#profile(bang) abort
  if a:bang
    profile pause
    noautocmd qall
  else
    profile start /tmp/profile.log
    profile func *
    profile file *
  endif
endfunction "}}}
