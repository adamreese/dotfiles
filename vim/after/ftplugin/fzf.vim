" =======================================================================
" after/ftplugin/fzf.vim
" =======================================================================

if has('terminal')
  " tunmap <Esc>
  " tnoremap <nowait><buffer><ESC> <C-g>

  " ensure <c-j> and <c-k> work properly within fzf window
  tnoremap <buffer><C-j> <C-j>
  tnoremap <buffer><C-k> <C-k>
endif

silent! iunmap <buffer><C-a>
silent! cunmap <buffer><C-a>
