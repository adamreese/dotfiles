" =======================================================================
" plugin/plug/vim-go.vim
" =======================================================================
if !ar#is_loaded('vim-go') | finish | endif

" Settings
" -----------------------------------------------------------------------

let g:go_decls_mode            = 'fzf'
let g:go_def_mode              = 'godef'
let g:go_echo_command_info     = 0
let g:go_fmt_command           = 'goimports'
let g:go_fmt_fail_silently     = 1
let g:go_gocode_propose_source = 1
let g:go_snippet_engine        = 'neosnippet'
let g:go_term_enabled          = 1
let g:go_term_mode             = 'split'

let g:go_gocode_unimported_packages = 1  " Include suggestions for unimported packages.

let s:pkgroot = substitute(ar#project_root(), expand('$GOPATH/src/'), '', '')
if !empty(s:pkgroot)
  let g:go_fmt_options = { 'goimports': '-local ' . s:pkgroot }
endif

" Extra highlights
let g:go_highlight_build_constraints = 1
let g:go_highlight_error = 1

" Modeline {{{1
" -----------------------------------------------------------------------
" vim: foldmethod=marker

