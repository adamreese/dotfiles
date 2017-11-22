" =======================================================================
" ftplugin/go/mappings.vim
" =======================================================================
let s:cpo_save = &cpoptions
set cpoptions&vim
" -----------------------------------------------------------------------

nmap <buffer><silent>gs          <Plug>(go-def-split)

nmap <buffer><localleader>tc     <Plug>(go-coverage-toggle)
nmap <buffer><localleader>i      <Plug>(go-info)
nmap <buffer><localleader>f      :<C-u>GoImports<CR>
nmap <buffer><localleader>gt     :<C-u>GoDecls<CR>
nmap <buffer><localleader>gl     :<C-u>Neomake gometalinter<CR>

" -----------------------------------------------------------------------
let &cpoptions = s:cpo_save
unlet s:cpo_save
" Modeline {{{1
" -----------------------------------------------------------------------
" vim: foldmethod=marker

