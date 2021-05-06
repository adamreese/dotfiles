" =======================================================================
" plugin/plug/nvim-treesitter.vim
" =======================================================================
if !ar#plug#IsLoaded('nvim-treesitter') | finish | endif

lua require('ar.treesitter')
