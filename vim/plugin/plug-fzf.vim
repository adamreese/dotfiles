" =======================================================================
" plugin/plug-fzf.vim
" =======================================================================

if has('nvim')
  let $FZF_DEFAULT_OPTS .= ' --inline-info'
endif

if !has('nvim') && $TERM_PROGRAM ==# 'iTerm.app'
  let g:fzf_launcher = 'vim-fzf'
endif

let g:fzf_nvim_statusline = 0

nnoremap <silent> <leader>t :<C-u>FZF<CR>
nnoremap <silent> <c-b>     :<C-u>Buffers<CR>

" -----------------------------------------------------------------------
" vim: foldmethod=marker
