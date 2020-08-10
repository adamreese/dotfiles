" =======================================================================
" plugin/plug/tagbar.vim
" =======================================================================
if !ar#plug#IsInstalled('tagbar') | finish | endif

let g:tagbar_silent      = v:true
let g:tagbar_status_func = 'status#TagbarStatus'

nnoremap <silent><leader>tt :<C-u>TagbarToggle<CR>
