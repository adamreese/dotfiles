" =======================================================================
" ftplugin/go.vim
" =======================================================================
let s:cpo_save = &cpoptions
set cpoptions&vim
" -----------------------------------------------------------------------
scriptencoding utf-8

setlocal tabstop=4
setlocal shiftwidth=4
setlocal noexpandtab
setlocal autoindent
setlocal listchars+=tab:\ \ ,

" -----------------------------------------------------------------------
let &cpoptions = s:cpo_save
unlet s:cpo_save
" Modeline {{{1
" -----------------------------------------------------------------------
" vim: foldmethod=marker
