" =======================================================================
" plugin/plug/luasnip.vim
" =======================================================================

lua require('ar.snippet')

" Expand or jump
imap <expr> <C-l> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-l>'
smap <expr> <C-l> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-l>'
