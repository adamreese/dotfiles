" =======================================================================
" plugin/plug/neomake.vim
" =======================================================================
scriptencoding utf-8

if !ar#plug#IsInstalled('neomake') | finish | endif

let g:neomake_warning_sign = { 'text': '❯', 'texthl': 'NeomakeWarningSign' }
let g:neomake_error_sign   = { 'text': '❯', 'texthl': 'NeomakeErrorSign' }
let g:neomake_message_sign = { 'text': '❯', 'texthl': 'NeomakeMessageSign' }
let g:neomake_info_sign    = { 'text': '❯', 'texthl': 'NeomakeInfoSign' }

let g:neomake_virtualtext_current_error = v:false

let g:neomake_go_enabled_makers = ['go', 'govet']
let g:neomake_javascript_enabled_makers = ['eslint']

function! s:Run() abort
  if &buftype ==# 'nofile'    | return | endif
  if &filetype ==# 'rust'     | return | endif
  if &filetype ==# 'lua'      | return | endif
  if empty(glob(expand('%'))) | return | endif

  Neomake
endfunction

augroup ar_neomake
  autocmd!
  autocmd BufWritePost * call <SID>Run()
  autocmd User NeomakeJobFinished call lightline#update()
  autocmd User NeomakeJobInit     call lightline#update()
augroup END
