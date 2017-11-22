" =======================================================================
" ftplugin/qf.vim
" =======================================================================
let s:cpo_save = &cpoptions
set cpoptions&vim
" -----------------------------------------------------------------------

" Wrap quickfix window
setlocal wrap
setlocal linebreak
setlocal nobuflisted

" make quickfix windows take all the lower section of the screen
" when there are multiple windows open
wincmd J

nnoremap <buffer> <silent> q :q<cr>

" Open result in vsplit, tab, split
nnoremap <silent><buffer> h  <C-W><CR><C-W>K
nnoremap <silent><buffer> H  <C-W><CR><C-W>K<C-W>b
nnoremap <silent><buffer> s  <C-W><CR><C-W>K
nnoremap <silent><buffer> S  <C-W><CR><C-W>K<C-W>b
nnoremap <silent><buffer> o  <CR>
nnoremap <silent><buffer> t  <C-W><CR><C-W>T
nnoremap <silent><buffer> T  <C-W><CR><C-W>TgT<C-W><C-W>
nnoremap <silent><buffer> v  <C-W><CR><C-W>H<C-W>b<C-W>J<C-W>t


augroup vimrc_qf
  autocmd!
  autocmd BufEnter,BufLeave <buffer> wincmd J
augroup END

" -----------------------------------------------------------------------
let &cpoptions = s:cpo_save
unlet s:cpo_save
" Modeline {{{1
" -----------------------------------------------------------------------
" vim: foldmethod=marker
