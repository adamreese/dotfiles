" =======================================================================
" plugin/plug-neosnippet.vim
" =======================================================================
if !has_key(g:plugs, 'neosnippet') | finish | endif

imap <expr><C-k> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : ""
smap <expr><C-k> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : ""

if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" -----------------------------------------------------------------------
" vim: foldmethod=marker

