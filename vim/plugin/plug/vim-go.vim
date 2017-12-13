" =======================================================================
" plugin/plug/vim-go.vim
" =======================================================================
if !ar#is_loaded('vim-go') | finish | endif

" Settings
" -----------------------------------------------------------------------

let g:go_decls_mode = 'fzf'
let g:go_def_mode = 'godef'
let g:go_echo_command_info = 0
let g:go_fmt_command = 'goimports'
let g:go_fmt_fail_silently = 1
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck', 'deadcode', 'unconvert']
let g:go_snippet_engine = 'neosnippet'
let g:go_term_enabled = 1
let g:go_term_mode = 'split'

" Extra highlights
let g:go_highlight_build_constraints = 1
let g:go_highlight_error = 1

" Modeline {{{1
" -----------------------------------------------------------------------
" vim: foldmethod=marker

