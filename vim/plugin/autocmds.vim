" =======================================================================
" plugin/autocmds.vim
" =======================================================================

function! s:OnWinEnter() abort
  if &previewwindow
    setlocal nospell concealcursor=nv nocursorline colorcolumn=
  endif
endfunction

augroup ar_vimrc
  autocmd!

  autocmd WinEnter * call s:OnWinEnter()

  " automatically resize panes on resize
  autocmd VimResized * wincmd =

  " remove trailing whitespace automatically
  autocmd BufWritePre * call whitespace#TrimTrailingSpace()
  autocmd BufWritePre * call whitespace#RemoveTrailingLines()

  autocmd InsertEnter * setlocal nohlsearch
  autocmd InsertLeave * setlocal hlsearch

  " Find and source project-specific config
  autocmd VimEnter * call project#SourceConfig()
augroup END

augroup ar_cursorline
  autocmd!
  autocmd WinEnter * if get(g:, 'loaded_cursed') && !cursed#is_disabled() | set cursorline | endif
  autocmd User CursedStartedMoving :set nocursorline
  autocmd User CursedStoppedMoving :set cursorline
augroup END

augroup ar_diff
  autocmd!
  " update diff
  autocmd InsertLeave * if &l:diff | diffupdate | endif
augroup END

augroup ar_autoread
  autocmd!

  " automatically check if file was changed on disk. skipping the command line
  autocmd BufEnter,CursorHold * if getcmdwintype() == '' | checktime | endif

  " Notification after file change
  " https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
  autocmd FileChangedShellPost *
        \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

augroup END

function! s:OnTermOpen() abort
    setlocal nolist nonumber sidescrolloff=0 nocursorline
    startinsert!
endfunction

augroup ar_terminal
  autocmd!
  autocmd TermOpen * call s:OnTermOpen()
  autocmd BufLeave term://* stopinsert
augroup END
