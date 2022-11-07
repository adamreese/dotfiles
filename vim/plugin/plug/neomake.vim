" =======================================================================
" plugin/plug/neomake.vim
" =======================================================================
scriptencoding utf-8

" Still used for docker and markdown

let g:neomake_warning_sign = { 'text': '❯', 'texthl': 'NeomakeWarningSign' }
let g:neomake_error_sign   = { 'text': '❯', 'texthl': 'NeomakeErrorSign' }
let g:neomake_message_sign = { 'text': '❯', 'texthl': 'NeomakeMessageSign' }
let g:neomake_info_sign    = { 'text': '❯', 'texthl': 'NeomakeInfoSign' }

let g:neomake_virtualtext_current_error = v:false

let g:neomake_go_enabled_makers = ['go', 'govet']

let s:ignore = ['cs', 'go', 'js', 'lua', 'rust', 'sh']

function! s:ignored() abort
  return index(s:ignore, &filetype) >= 0
endfunction

function! s:Run() abort
  if &buftype ==# 'nofile'    | return | endif
  if s:ignored()              | return | endif
  if empty(glob(expand('%'))) | return | endif

  Neomake
endfunction

" Print message when Neomake completes a job.  I want to migrate all linting
" to LSP. This is temporary to help me find out where I rely on neomake.
function! s:PrintNeomakeResult() abort
  echohl ModeMsg
  echomsg printf('[Neomake] %s exited with %d',
        \ g:neomake_hook_context.jobinfo.maker.name,
        \ g:neomake_hook_context.jobinfo.exit_code)
  echohl None
endfunction

function! s:neomake_finished() abort
  call s:PrintNeomakeResult()
endfunction

augroup ar_neomake
  autocmd!
  autocmd BufWritePost * call <SID>Run()
  autocmd User NeomakeJobFinished call <SID>neomake_finished()
augroup END
