" =======================================================================
" plugin/plug-easy-align.vim
" =======================================================================

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

noremap  <leader>ah :<C-u>Align =><CR>
nnoremap <leader>a= :<C-u>Align =<CR>
noremap  <leader>a# :<C-u>Align #<CR>
noremap  <leader>a{ :<C-u>Align {<CR>

" -----------------------------------------------------------------------
" vim: foldmethod=marker

