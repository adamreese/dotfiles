" =======================================================================
" ftplugin/proto.vim
" =======================================================================

let g:tagbar_type_proto = {
    \ 'ctagstype' : 'protobuf',
    \ 'kinds' : [
        \ 'i:imports:1:0',
        \ 'p:package:0:0',
        \ 'm:message:0:1',
        \ 'e:enum:0:1',
        \ 'f:field:0:0',
    \ ],
    \ 'sro' : '.',
        \ 'kind2scope': { },
        \ 'scope2kind': { }
\}
