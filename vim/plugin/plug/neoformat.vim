" =======================================================================
" plugin/plug/neoformat.vim
" =======================================================================
if !ar#is_installed('neoformat') | finish | endif

noremap <silent><leader>f :Neoformat<CR>

" Modeline {{{1
" -----------------------------------------------------------------------
" vim: foldmethod=marker
