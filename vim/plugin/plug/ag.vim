" =======================================================================
" plugin/plug/ag.vim
" =======================================================================

let g:ag_mapping_message = 0

if executable('ag')
  let &grepprg = 'ag --nocolor --nogroup --hidden --vimgrep'
  let g:ag_prg = 'ag --nocolor --nogroup --hidden --column'

  noremap <leader>a  :<C-u>Ag<space>
  noremap <leader>a* :<C-u>call SearchWordWithAg()<CR>

  function! SearchWordWithAg()
    execute 'Ag' expand('<cword>')
  endfunction
endif

" Modeline {{{1
" -----------------------------------------------------------------------
" vim: foldmethod=marker
