" =======================================================================
" ftplugin/go.vim
" =======================================================================
let s:cpo_save = &cpoptions
set cpoptions&vim
" -----------------------------------------------------------------------
scriptencoding utf-8

setlocal tabstop=4
setlocal shiftwidth=4
setlocal listchars+=tab:\ \ ,
setlocal formatoptions+=r

" -----------------------------------------------------------------------

nmap <silent><buffer>gK                  <Plug>(go-doc-browser)

nmap <silent><buffer><localleader>tc     <Plug>(go-coverage-toggle)
nmap <silent><buffer><localleader>tf     <Plug>(go-test-function)
nmap <silent><buffer><localleader>i      <Plug>(go-info)

" -----------------------------------------------------------------------

command! -buffer -bang A  call go#alternate#Switch(<bang>0, 'edit')
command! -buffer -bang AS call go#alternate#Switch(<bang>0, 'split')
command! -buffer -bang AV call go#alternate#Switch(<bang>0, 'vsplit')

" -----------------------------------------------------------------------

let g:tagbar_type_go = {
      \ 'ctagstype' : 'go',
      \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
      \ ],
      \ 'sro' : '.',
      \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
      \ },
      \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
      \ },
      \ 'ctagsbin'  : 'gotags',
      \ 'ctagsargs' : '-sort -silent'
      \ }

" -----------------------------------------------------------------------
let &cpoptions = s:cpo_save
unlet s:cpo_save
