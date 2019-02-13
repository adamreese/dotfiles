" =======================================================================
" plugin/autocmds.vim
" =======================================================================

augroup ar_vimrc
  autocmd!
  " save files when vim loses focus
  autocmd FocusLost * silent! wall

  " automatically resize panes on resize
  autocmd VimResized * wincmd =

  " remove trailing whitespace automatically
  autocmd BufWritePre * call whitespace#clean()

  " disable paste
  autocmd InsertLeave * if &paste | set nopaste | echo 'nopaste' | endif

  autocmd InsertEnter * setlocal nohlsearch
  autocmd InsertLeave * setlocal hlsearch

  " quit if quickfix is the only window
  " from https://github.com/now/vim-quit-if-only-quickfix-buffer-left/blob/master/plugin/now/quit-if-only-quickfix-buffer-left.vim
  autocmd WinEnter * if winnr('$') == 1 && &buftype == 'quickfix' | quit | endif

  autocmd BufRead,BufNewFile * call project#source_config()

  autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
augroup END

augroup ar_cursorline
  autocmd!
  " only show cursorline in current and normal window
  autocmd CursorMoved,CursorMovedI,WinLeave * if ! &l:diff | setlocal nocursorline | endif
  autocmd CursorHold,CursorHoldI,WinEnter   * if ! &l:diff | setlocal cursorline   | endif
augroup END

augroup ar_diff
  autocmd!
  " update diff
  autocmd InsertLeave * if &l:diff | diffupdate | endif
augroup END

augroup ar_autoread
  autocmd!

  " Triger `autoread` when files changes on disk
  " https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
  " https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
  autocmd BufEnter,CursorMoved,CursorMovedI,CursorHold,CursorHoldI * if mode() != 'c' | silent! checktime | endif

  " Notification after file change
  " https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
  autocmd FileChangedShellPost *
        \ echohl WarningMsg | echo 'File changed on disk. Buffer reloaded.' | echohl None
augroup END

augroup ar_terminal
  autocmd!
  autocmd TermOpen * startinsert!
  autocmd TermClose term://* stopinsert
augroup END

" Modeline {{{1
" -----------------------------------------------------------------------
" vim:foldmethod=marker
