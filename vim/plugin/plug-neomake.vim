" =======================================================================
" plugin/plug-neomake.vim
" =======================================================================
scriptencoding utf-8

if !ar#is_loaded('neomake') | finish | endif

let g:neomake_enable = 1
let g:neomake_warning_sign = { 'text': '!', 'texthl': 'WarningMsg' }
let g:neomake_error_sign   = { 'text': '❯', 'texthl': 'ErrorMsg'   }

let g:neomake_go_enabled_makers = ['go', 'govet']
let g:neomake_javascript_enabled_makers = ['eslint']

function! s:neomake_run() abort
  if &buftype ==# 'nofile'    | return | endif
  if empty(glob(expand('%'))) | return | endif
  if !g:neomake_enable        | return | endif

  Neomake
endfunction

augroup vimrc_neomake
  autocmd!
  autocmd  BufWritePost * call <SID>neomake_run()
augroup END

" -----------------------------------------------------------------------
" vim: foldmethod=marker
