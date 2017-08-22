" =======================================================================
" ftplugin/go.vim
" =======================================================================
scriptencoding utf-8

setlocal tabstop=4
setlocal shiftwidth=4
setlocal noexpandtab
setlocal autoindent
setlocal listchars=tab:\ \ ,extends:⟫,precedes:⟪,nbsp:␣,trail:·

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

" Mappings
" -----------------------------------------------------------------------

nmap <buffer><silent>gs          <Plug>(go-def-split)

nmap <buffer><localleader>tc     <Plug>(go-coverage-toggle)
nmap <buffer><localleader>i      <Plug>(go-info)
nmap <buffer><localleader>f      :<C-u>GoImports<CR>
nmap <buffer><localleader>gt     :<C-u>GoDecls<CR>
nmap <buffer><localleader>gl     :<C-u>Neomake gometalinter<CR>

command! -buffer -bang A  call go#alternate#Switch(<bang>0, 'edit')
command! -buffer -bang AS call go#alternate#Switch(<bang>0, 'split')
command! -buffer -bang AV call go#alternate#Switch(<bang>0, 'vsplit')

" -----------------------------------------------------------------------
" vim: foldmethod=marker
