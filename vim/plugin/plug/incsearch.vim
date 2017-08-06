" =======================================================================
" plugin/plug/incsearch.vim
" =======================================================================
if !ar#is_loaded('incsearch.vim') | finish | endif

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" -----------------------------------------------------------------------
" vim: foldmethod=marker
