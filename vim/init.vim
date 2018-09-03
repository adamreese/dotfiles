" =======================================================================
" Neovim specific config
" =======================================================================

" -----------------------------------------------------------------------
" Python Setup
" -----------------------------------------------------------------------

if executable('/usr/local/bin/python2')
  let g:python_host_skip_check = 1
  let g:python_host_prog = '/usr/local/bin/python2'
endif
if executable('/usr/local/bin/python3')
  let g:python3_host_skip_check = 1
  let g:python3_host_prog = '/usr/local/bin/python3'
endif

" -----------------------------------------------------------------------
" Vim Configuration
" -----------------------------------------------------------------------

execute 'source' fnamemodify(resolve(expand('<sfile>')), ':p:h').'/vimrc'

" Modeline {{{1
" -----------------------------------------------------------------------
" vim:foldmethod=marker
