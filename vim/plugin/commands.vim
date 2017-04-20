" =======================================================================
" plugin/commands.vim
" =======================================================================

" Common typos
command! W w
command! Q q
command! WQ wq
command! Wq wq

" Profile
command! -bang Profile call acr#profile(<bang>0)

" ReloadSyntax
function! s:reload() abort
  syntax sync fromstart
  redraw!
endfunction
command! ReloadSyntax :call s:reload()

" -----------------------------------------------------------------------
" vim:foldmethod=marker