" =======================================================================
" plugin/plug/tagbar.vim
" =======================================================================
if !ar#is_installed('tagbar') | finish | endif

let g:tagbar_silent = v:true

nnoremap <silent><leader>tt :<C-u>TagbarToggle<CR>
