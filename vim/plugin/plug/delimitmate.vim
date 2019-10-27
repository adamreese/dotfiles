" =======================================================================
" plugin/plug/delimitmate.vim
" =======================================================================
if !ar#is_loaded('delimitMate') | finish | endif

let g:delimitMate_expand_cr    = v:true
let g:delimitMate_expand_space = v:true
let g:delimitMate_smart_quotes = v:true

imap <C-b> <Plug>delimitMateS-BS

" Modeline {{{1
" -----------------------------------------------------------------------
" vim: foldmethod=marker

