" =======================================================================
" plugin/plug/incsearch.vim
" =======================================================================
if !ar#plug#IsLoaded('incsearch.vim') | finish | endif

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
