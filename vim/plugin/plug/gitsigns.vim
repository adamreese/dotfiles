" =======================================================================
" plugin/plug/gitsigns.vim
" =======================================================================
if !ar#plug#IsLoaded('gitsigns.nvim') | finish | endif

lua require('ar.gitsigns')
