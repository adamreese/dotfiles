" =======================================================================
" plugin/plug-neomake.vim
" =======================================================================
scriptencoding utf-8

let g:neomake_enable = 1
let g:neomake_warning_sign = { 'text': '❯', 'texthl': 'WarningMsg' }
let g:neomake_error_sign   = { 'text': '❯', 'texthl': 'ErrorMsg'   }

function! s:neomake_run() "{{{
  if &buftype ==# 'nofile' | return | endif

  let l:filetypes = [
        \ 'css', 'go', 'html', 'json', 'markdown',
        \ 'ruby', 'sh', 'vim', 'yaml' ]
  if g:neomake_enable && index(l:filetypes, &filetype) > -1
    Neomake
  endif
endfunction "}}}

augroup vimrc_neomake
  autocmd!
  autocmd  BufWritePost * call <SID>neomake_run()
augroup END

" -----------------------------------------------------------------------
" vim: foldmethod=marker
