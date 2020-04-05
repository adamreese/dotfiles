" =======================================================================
" after/ftplugin/qf.vim
" =======================================================================

" Disable relative numbers and use just numbers.
setlocal norelativenumber
setlocal number

" Start with all folds open.
setlocal foldlevel=99

" Make quickfix buffer hidden.
setlocal nobuflisted

nnoremap <silent> <buffer> <leader>k  :Keep<space>
nnoremap <silent> <buffer> <leader>r  :Reject<space>
