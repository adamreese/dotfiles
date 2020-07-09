" =======================================================================
" after/ftplugin/rust.vim
" =======================================================================

" this hack is to block highlighting of code in comments.
let b:current_syntax_embed = v:false

let g:tagbar_type_rust = {
    \ 'kinds' : [
        \ 'n:module:0:0',
        \ 's:struct',
        \ 'i:trait',
        \ 'c:implementation:0:0',
        \ 'f:function',
        \ 'g:enum',
        \ 't:type alias',
        \ 'v:global variable',
        \ 'M:macro',
        \ 'm:struct field',
        \ 'e:enum variant',
        \ 'P:method',
        \ '?:unknown',
    \ ],
\ }
