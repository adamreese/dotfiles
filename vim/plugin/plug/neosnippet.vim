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
let g:neosnippet#snippets_directory            = g:vim_dir . '/snippets'

" Mappings
" -----------------------------------------------------------------------
let s:cpo_save = &cpoptions
set cpoptions&vim

imap <special> <C-k> <Plug>(neosnippet_expand_or_jump)
smap <special> <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <special> <C-k> <Plug>(neosnippet_expand_target)

" Autocmds
" -----------------------------------------------------------------------
augroup ar_neosnippet
  autocmd!
  " Remove remaining markers when leaving insert mode
  autocmd InsertLeave * NeoSnippetClearMarkers
augroup END

let &cpoptions = s:cpo_save
unlet s:cpo_save

" Modeline {{{1
" -----------------------------------------------------------------------
" vim: foldmethod=marker

