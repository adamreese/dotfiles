" =======================================================================
" plugin/plug/tagbar.vim
" =======================================================================
if !ar#is_installed('tagbar') | finish | endif

noremap <leader>tt :<C-u>TagbarToggle<CR>

" Modeline {{{1
" -----------------------------------------------------------------------
" vim: foldmethod=marker

