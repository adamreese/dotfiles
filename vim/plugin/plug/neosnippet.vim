" =======================================================================
" plugin/plug/neosnippet.vim
" =======================================================================
if !ar#is_loaded('neosnippet') | finish | endif

" Settings
" -----------------------------------------------------------------------

let g:neosnippet#disable_runtime_snippets      = { 'go' : 1, }
let g:neosnippet#enable_completed_snippet      = 1
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#expand_word_boundary          = 0

if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" Mappings
" -----------------------------------------------------------------------

imap <expr><C-k> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : ""
smap <expr><C-k> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : ""

" Modeline {{{1
" -----------------------------------------------------------------------
" vim: foldmethod=marker

