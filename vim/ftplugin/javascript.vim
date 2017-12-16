" =======================================================================
" ftplugin/javascript.vim
" =======================================================================

setlocal nofoldenable
setlocal foldmethod=syntax

nmap <buffer><silent> K  :<C-U>TernDoc<CR>
nmap <buffer><silent> gd :<C-U>TernDef<CR>
nmap <buffer><silent> gs :<C-U>TernDefSplit<CR>

" Modeline {{{1
" -----------------------------------------------------------------------
" vim: foldmethod=marker
