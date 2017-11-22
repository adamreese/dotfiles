" =======================================================================
" ftplugin/make.vim
" =======================================================================

setlocal noexpandtab
setlocal nolist

let g:tagbar_type_make = {
    \ 'ctagstype': 'make',
    \ 'kinds':[
        \ 'm:macros',
        \ 't:targets'
        \ ]
    \}

" Modeline {{{1
" -----------------------------------------------------------------------
" vim: foldmethod=marker

