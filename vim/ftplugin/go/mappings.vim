" =======================================================================
" ftplugin/go/mappings.vim
" =======================================================================
let s:cpo_save = &cpoptions
set cpoptions&vim
" -----------------------------------------------------------------------

nmap <silent><buffer><silent>gs          <Plug>(go-def-split)

nmap <silent><buffer><localleader>tc     <Plug>(go-coverage-toggle)
nmap <silent><buffer><localleader>i      <Plug>(go-info)
nmap <silent><buffer><localleader>f      :<C-u>GoImports<CR>
nmap <silent><buffer><localleader>gt     :<C-u>GoDecls<CR>
nmap <silent><buffer><localleader>gl     :<C-u>Neomake gometalinter<CR>

" -----------------------------------------------------------------------
let &cpoptions = s:cpo_save
unlet s:cpo_save
" Modeline {{{1
" -----------------------------------------------------------------------
" vim: foldmethod=marker

