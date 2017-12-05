" =======================================================================
" plugin/plug/tern_for_vim.vim
" =======================================================================
if !ar#is_plugged('tern_for_vim') | finish | endif

let g:tern#arguments = ['--persistent', '--no-port-file']
let g:tern#command = ['tern']
let g:tern_request_timeout = 1
let g:tern_set_omni_function = 0
let g:tern_show_signature_in_pum = 1

" Modeline {{{1
" -----------------------------------------------------------------------
" vim: foldmethod=marker

