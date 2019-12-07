" =======================================================================
" plugin/plug/easy-align.vim
" =======================================================================
if !ar#is_installed('vim-easy-align') | finish | endif

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
