" Wrap quickfix window
setlocal wrap
setlocal linebreak
setlocal nobuflisted

" make quickfix windows take all the lower section of the screen
" when there are multiple windows open
wincmd J

nnoremap <buffer> <silent>  q :q<cr>