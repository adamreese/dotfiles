" =======================================================================
" plugin/plug/neoformat.vim
" =======================================================================
if !ar#is_installed('neoformat') | finish | endif

let g:neoformat_enabled_yaml = ['prettier']

noremap <silent><leader>f :Neoformat<CR>
