" =======================================================================
" plugin/plug/tern_for_vim.vim
" =======================================================================
if !ar#is_plugged('tern_for_vim') | finish | endif

let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent', '--no-port-file']
let g:tern_request_timeout = 1
let g:tern_set_omni_function = 0

" Modeline {{{1
" -----------------------------------------------------------------------
" vim: foldmethod=marker

