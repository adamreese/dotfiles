" =======================================================================
" plugin/plug/vim-lookup.vim
" =======================================================================

augroup ar_vim_lookup
  autocmd!
  autocmd FileType vim nnoremap <buffer><silent> gd
        \ :<C-U>call lookup#lookup()<CR>
augroup END
