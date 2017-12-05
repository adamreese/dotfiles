" =======================================================================
" plugin/commands.vim
" =======================================================================

" Common typos
command! W w
command! Q q
command! WQ wq
command! Wq wq

" Plug Upgrade and Update
command! PU PlugUpgrade | PlugUpdate

" Profile
command! -bang Profile call ar#profile(<bang>0)

" ReloadSyntax
command! ReloadSyntax call ar#reload_syntax()

" -----------------------------------------------------------------------
" vim:foldmethod=marker
