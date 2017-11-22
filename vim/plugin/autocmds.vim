" =======================================================================
" plugin/autocmds.vim
" =======================================================================

augroup vimrc
  autocmd!
  " save files when vim loses focus
  autocmd FocusLost * silent! wall

  " automatically resize panes on resize
  autocmd VimResized * wincmd =

  " remove trailing whitespace automatically
  autocmd BufWritePre * :%s/\s\+$//e

  " check timestamp more for 'autoread'
  autocmd WinEnter * checktime

  autocmd InsertEnter * setlocal nohlsearch
  autocmd InsertLeave * setlocal hlsearch

  " only show cursorline in current and normal window
  autocmd CursorMoved,CursorMovedI,WinLeave * setlocal nocursorline
  autocmd CursorHold,CursorHoldI,WinEnter   * setlocal cursorline

  autocmd BufEnter term://* startinsert

  " quit if quickfix is the only window
  " from https://github.com/now/vim-quit-if-only-quickfix-buffer-left/blob/master/plugin/now/quit-if-only-quickfix-buffer-left.vim
  autocmd WinEnter * if winnr('$') == 1 && &buftype == 'quickfix' | quit | endif

augroup END

" Modeline {{{1
" -----------------------------------------------------------------------
" vim:foldmethod=marker
