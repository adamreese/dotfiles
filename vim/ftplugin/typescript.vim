" =======================================================================
" ftplugin/typescript.vim
" =======================================================================
let s:cpo_save = &cpoptions
set cpoptions&vim
" -----------------------------------------------------------------------

setlocal nofoldenable
setlocal foldmethod=syntax

nmap <buffer><silent>K                   :<C-U>TSDoc<CR>
nmap <buffer><silent>gd                  :<C-U>TSTypeDef<CR>
nmap <buffer><silent>gs                  :<C-U>TSDefPreview<CR>
nmap <silent><buffer><localleader>i      :<C-U>TSType<CR>

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
let &cpoptions = s:cpo_save
unlet s:cpo_save
