" =======================================================================
" plugin/plug/vim-go.vim
" =======================================================================
if !ar#is_loaded('vim-go') | finish | endif

" Settings
" -----------------------------------------------------------------------

let g:go_code_completion_enabled = v:false
let g:go_decls_mode              = 'fzf'
let g:go_def_mapping_enabled     = v:false
let g:go_doc_keywordprg_enabled  = v:false
let g:go_echo_go_info            = v:false
let g:go_fmt_command             = 'goimports'
let g:go_fmt_fail_silently       = v:true
let g:go_gopls_enabled           = v:false

let s:pkgroot = substitute(project#root(), expand('$GOPATH/src/'), '', '')
if !empty(s:pkgroot)
  let g:go_fmt_options = { 'goimports': '-local ' . s:pkgroot }
endif

" Extra highlights
let g:go_highlight_build_constraints = v:true
let g:go_highlight_error = v:true
