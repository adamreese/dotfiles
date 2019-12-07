" =======================================================================
" ftplugin/proto.vim
" =======================================================================

let g:tagbar_type_proto = {
    \ 'ctagstype' : 'Protobuf',
    \ 'kinds' : [
        \ 'p:packages',
        \ 'e:enum constants',
        \ 'f:fields',
        \ 'g:enum types',
        \ 'i:imports',
        \ 'm:messages',
        \ 'r:rpc',
        \ 's:services',
    \ ],
    \ 'sro' : '.',
    \ 'sort' : 0,
\}
