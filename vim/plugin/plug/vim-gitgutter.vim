" =======================================================================
" plugin/plug/vim-gitgutter.vim
" =======================================================================
if !ar#is_loaded('vim-gitgutter') | finish | endif

scriptencoding utf-8

" Settings
" -----------------------------------------------------------------------

let g:gitgutter_enabled = get(g:, 'gitgutter_enabled', 0)

let g:gitgutter_sign_added              = '┃'
let g:gitgutter_sign_modified           = '┃'
let g:gitgutter_sign_modified_removed   = '┃'
let g:gitgutter_sign_removed            = '﹍'
let g:gitgutter_sign_removed_first_line = '﹉'

" Mappings
" -----------------------------------------------------------------------

nnoremap <leader>tgg :<C-u>GitGutterToggle<CR>

" Modeline {{{1
" -----------------------------------------------------------------------
" vim: foldmethod=marker
