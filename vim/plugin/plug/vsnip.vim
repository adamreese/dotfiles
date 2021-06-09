" =======================================================================
" plugin/plug/vsip.vim
" =======================================================================
if !ar#plug#IsLoaded('vim-vsnip') | finish | endif

" Expand or jump
imap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l> vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
