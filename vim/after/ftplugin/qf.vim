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

" Don't use modelines in quickfix windows.
setlocal nomodeline

nnoremap <silent> <buffer> <leader>k  :Keep<space>
nnoremap <silent> <buffer> <leader>r  :Reject<space>

" navigate between older and newer lists
nnoremap <silent> <buffer> <Left>  :<C-u>call qf#history#Older()<CR>
nnoremap <silent> <buffer> <Right> :<C-u>call qf#history#Newer()<CR>

" jump to previous/next file grouping
nnoremap <silent> <buffer> { :<C-u>call qf#filegroup#PreviousFile()<CR>
nnoremap <silent> <buffer> } :<C-u>call qf#filegroup#NextFile()<CR>
