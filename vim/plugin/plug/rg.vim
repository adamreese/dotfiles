" =======================================================================
" plugin/plug/rg.vim
" =======================================================================
let &grepprg = 'rg --no-heading --column --line-number --hidden'
let g:ackprg = &grepprg

set grepformat^=%f:%l:%c:%m

let g:ack_apply_lmappings = v:false
let g:ack_apply_qmappings = v:false

nnoremap <leader>a  :<C-u>Ack<space>
nnoremap <leader>a* :<C-u>Ack<CR>
