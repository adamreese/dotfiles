" =======================================================================
" plugin/plug/ag.vim
" =======================================================================
if !executable('ag') | finish | end

let &grepprg = 'ag --nocolor --nogroup --hidden --vimgrep'
let g:ackprg = 'ag --nocolor --nogroup --hidden --column'

noremap <leader>a  :<C-u>Ack<space>
noremap <leader>a* :<C-u>Ack<CR>

" Modeline {{{1
" -----------------------------------------------------------------------
" vim: foldmethod=marker
