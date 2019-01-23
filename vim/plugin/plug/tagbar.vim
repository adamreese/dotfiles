" =======================================================================
" plugin/plug/tagbar.vim
" =======================================================================
if !ar#is_installed('tagbar') | finish | endif

let g:tagbar_silent = v:true

noremap <silent><leader>tt :<C-u>TagbarToggle<CR>

" Modeline {{{1
" -----------------------------------------------------------------------
" vim: foldmethod=marker

