" =======================================================================
" plugin/plug-gitgutter.vim
" =======================================================================
scriptencoding utf-8

let g:gitgutter_enabled = get(g:, 'gitgutter_enabled', 0)

let g:gitgutter_sign_added            = '▏'
let g:gitgutter_sign_modified         = '▏'
let g:gitgutter_sign_removed          = '▏'
let g:gitgutter_sign_modified_removed = '║'

nnoremap <leader>tgg :<C-u>GitGutterToggle<CR>

" -----------------------------------------------------------------------
" vim: foldmethod=marker
