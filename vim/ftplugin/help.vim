" =======================================================================
" ftplugin/help.vim
" =======================================================================
let s:cpo_save = &cpoptions
set cpoptions&vim
" -----------------------------------------------------------------------

setlocal keywordprg=:help
setlocal iskeyword+=-

nnoremap <buffer><silent>  q :bd<cr>

" -----------------------------------------------------------------------
let &cpoptions = s:cpo_save
unlet s:cpo_save
