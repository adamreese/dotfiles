" =======================================================================
" Neovim specific config
" =======================================================================

" -----------------------------------------------------------------------
" Python Setup
" -----------------------------------------------------------------------

if executable('python2')
  let g:python_host_skip_check = v:true
  let g:python_host_prog = exepath('python2')
endif
if executable('python3')
  let g:python3_host_skip_check = v:true
  let g:python3_host_prog = exepath('python3')
endif

if executable('neovim-ruby-host')
  let g:ruby_host_prog = exepath('neovim-ruby-host')
endif

" -----------------------------------------------------------------------
" Vim Configuration
" -----------------------------------------------------------------------

execute 'source' fnamemodify(resolve(expand('<sfile>')), ':p:h').'/vimrc'
