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
  autocmd BufWritePre * call whitespace#clean()

  " disable paste
  autocmd InsertLeave * set nopaste

  " check timestamp more for 'autoread'
  autocmd WinEnter * checktime

  autocmd InsertEnter * setlocal nohlsearch
  autocmd InsertLeave * setlocal hlsearch

  " only show cursorline in current and normal window
  autocmd CursorMoved,CursorMovedI,WinLeave * if ! &l:diff | setlocal nocursorline | endif
  autocmd CursorHold,CursorHoldI,WinEnter   * if ! &l:diff | setlocal cursorline   | endif

  " update diff
  autocmd InsertLeave * if &l:diff | diffupdate | endif

  autocmd BufEnter term://* startinsert

  " quit if quickfix is the only window
  " from https://github.com/now/vim-quit-if-only-quickfix-buffer-left/blob/master/plugin/now/quit-if-only-quickfix-buffer-left.vim
  autocmd WinEnter * if winnr('$') == 1 && &buftype == 'quickfix' | quit | endif

  autocmd BufRead,BufNewFile * call ar#source_project_config()
augroup END

" Modeline {{{1
" -----------------------------------------------------------------------
" vim:foldmethod=marker
