" =======================================================================
" ftplugin/go/commands.vim
" =======================================================================
let s:cpo_save = &cpoptions
set cpoptions&vim
" -----------------------------------------------------------------------

command! -buffer -bang A  call go#alternate#Switch(<bang>0, 'edit')
command! -buffer -bang AS call go#alternate#Switch(<bang>0, 'split')
command! -buffer -bang AV call go#alternate#Switch(<bang>0, 'vsplit')

" -----------------------------------------------------------------------
let &cpoptions = s:cpo_save
unlet s:cpo_save
" Modeline {{{1
" -----------------------------------------------------------------------
" vim: foldmethod=marker
