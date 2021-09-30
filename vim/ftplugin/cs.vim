" =======================================================================
" ftplugin/cs.vim
" =======================================================================

setlocal tabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal autoindent

" Set the commentstring
setlocal commentstring=//%s

let b:undo_ftplugin = get(b:, 'undo_ftplugin', 'exe')
      \. ' | setlocal commentstring<'
