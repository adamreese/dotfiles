" =======================================================================
" plugin/plug/ag.vim
" =======================================================================
if !executable('ag') | finish | end

let &grepprg = 'ag --nocolor --nogroup --hidden --vimgrep'
let g:ackprg = 'ag --nocolor --nogroup --hidden --column'

noremap <leader>a  :<C-u>Ag<space>
noremap <leader>a* :<C-u>Ag<CR>

cnoreabbrev Ag Ack

" Modeline {{{1
" -----------------------------------------------------------------------
" vim: foldmethod=marker
