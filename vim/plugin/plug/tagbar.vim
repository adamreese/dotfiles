" =======================================================================
" plugin/plug/tagbar.vim
" =======================================================================
if !ar#is_plugged('tagbar') | finish | endif

noremap <leader>tt :<C-u>TagbarToggle<CR>

" Modeline {{{1
" -----------------------------------------------------------------------
" vim: foldmethod=marker

