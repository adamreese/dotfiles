" =======================================================================
" ftplugin/qf.vim
" =======================================================================

" Wrap quickfix window
setlocal wrap
setlocal linebreak
setlocal nobuflisted

" make quickfix windows take all the lower section of the screen
" when there are multiple windows open
wincmd J

nnoremap <buffer> <silent> q :q<cr>

" Open result in vsplit, tab, split
nnoremap <buffer> s <C-w><CR>
nnoremap <buffer> v <C-w><CR><C-w>L
nnoremap <buffer> t <C-W><CR><C-W>T
