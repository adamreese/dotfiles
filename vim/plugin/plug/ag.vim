" =======================================================================
" plugin/plug/ag.vim
" =======================================================================
if !executable('ag') | finish | end

let &grepprg = 'rg --no-heading --column --line-number --hidden'
let g:ackprg = &grepprg

set grepformat^=%f:%l:%c:%m

noremap <leader>a  :<C-u>Ack<space>
noremap <leader>a* :<C-u>Ack<CR>
