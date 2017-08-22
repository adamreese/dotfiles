" =======================================================================
" ftplugin/typescript.vim
" =======================================================================

let g:tagbar_type_typescript = {
    \ 'ctagstype' : 'typescript',
    \ 'kinds'     : [
      \ 'c:classes',
      \ 'a:abstract classes',
      \ 't:types',
      \ 'n:modules',
      \ 'f:functions',
      \ 'v:variables',
      \ 'l:varlambdas',
      \ 'm:members',
      \ 'i:interfaces',
      \ 'e:enums'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
      \ 'c' : 'classes',
      \ 'a' : 'abstract classes',
      \ 't' : 'types',
      \ 'f' : 'functions',
      \ 'v' : 'variables',
      \ 'l' : 'varlambdas',
      \ 'm' : 'members',
      \ 'i' : 'interfaces',
      \ 'e' : 'enums'
    \ },
    \ 'scope2kind' : {
      \ 'classes'    : 'c',
      \ 'abstract classes'    : 'a',
      \ 'types'      : 't',
      \ 'functions'  : 'f',
      \ 'variables'  : 'v',
      \ 'varlambdas' : 'l',
      \ 'members'    : 'm',
      \ 'interfaces' : 'i',
      \ 'enums'      : 'e'
    \ }
    \ }

" -----------------------------------------------------------------------
" vim: foldmethod=marker
