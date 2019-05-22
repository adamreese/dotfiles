" =======================================================================
" plugin/plug/fugitive.vim
" =======================================================================

augroup ar_fugitive
  autocmd!
  autocmd BufReadPost fugitive://* setlocal bufhidden=delete
augroup END

" Modeline {{{1
" -----------------------------------------------------------------------
" vim: foldmethod=marker
