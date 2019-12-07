" =======================================================================
" ftplugin/go/mappings.vim
" =======================================================================
let s:cpo_save = &cpoptions
set cpoptions&vim
" -----------------------------------------------------------------------

nmap <silent><buffer>gs              <Plug>(go-def-split)
nmap <silent><buffer>gK              <Plug>(go-doc-browser)

nmap <silent><buffer><localleader>tc     <Plug>(go-coverage-toggle)
nmap <silent><buffer><localleader>tf     <Plug>(go-test-function)
nmap <silent><buffer><localleader>i      <Plug>(go-info)
nmap <silent><buffer><localleader>gt     <Plug>(go-decls)

" -----------------------------------------------------------------------
let &cpoptions = s:cpo_save
unlet s:cpo_save

