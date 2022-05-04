" =======================================================================
" plugin/plug/tagbar.vim
" =======================================================================

let g:tagbar_silent      = v:true
let g:tagbar_status_func = 'status#TagbarStatus'

nnoremap <silent><leader>tt :<C-u>TagbarToggle<CR>
