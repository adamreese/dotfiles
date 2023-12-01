" =======================================================================
" ftplugin/typescript.vim
" =======================================================================
let s:cpo_save = &cpoptions
set cpoptions&vim
" -----------------------------------------------------------------------

let g:tagbar_type_typescript = {
      \   'ctagstype': 'typescript',
      \   'kinds': [
      \     'C:constants',
      \     'G:generators',
      \     'a:aliases',
      \     'c:classes',
      \     'e:enumerators',
      \     'f:functions',
      \     'g:enums',
      \     'i:interfaces',
      \     'l:local variables',
      \     'm:methods',
      \     'n:namespaces',
      \     'p:properties',
      \     'v:variables',
      \     'z:parameters',
      \   ],
      \   'sro' : '.',
      \   'sort' : 0,
      \   'kind2scope' : {
      \     'g' : 'enums',
      \     'c' : 'classes',
      \     'n' : 'namespaces',
      \     'i' : 'interfaces',
      \   },
      \   'scope2kind' : {
      \     'enums' : 'g',
      \     'classes' : 'c',
      \     'namespaces' : 'n',
      \     'interfaces' : 'i',
      \   },
      \ }

" -----------------------------------------------------------------------
let &cpoptions = s:cpo_save
unlet s:cpo_save
