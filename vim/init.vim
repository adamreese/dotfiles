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

if executable('/usr/local/bin/neovim-node-host')
  let g:node_host_prog = '/usr/local/bin/neovim-node-host'
endif

if executable('/usr/local/bin/neovim-ruby-host')
  let g:ruby_host_prog = exepath('neovim-ruby-host')
endif

" -----------------------------------------------------------------------
" Vim Configuration
" -----------------------------------------------------------------------

execute 'source' fnamemodify(resolve(expand('<sfile>')), ':p:h').'/vimrc'
