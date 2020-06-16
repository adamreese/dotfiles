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
  autocmd BufWritePre * call whitespace#Clean()

  " disable paste
  " https://github.com/neovim/neovim/issues/7994
  if !has('nvim-0.4')
    autocmd InsertLeave * set nopaste
  endif

  autocmd InsertEnter * setlocal nohlsearch
  autocmd InsertLeave * setlocal hlsearch

  " Find and source project-specific config
  if exists('##DirChanged')
    autocmd DirChanged,VimEnter * call project#SourceConfig()
  endif
augroup END

augroup ar_cursorline
  autocmd!
  " only show cursorline in current and normal window
  autocmd CursorMoved,CursorMovedI,WinLeave,InsertEnter * setlocal nocursorline
  autocmd CursorHold,WinEnter,InsertLeave *
        \ if empty(&buftype) | setlocal cursorline | endif
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
  autocmd BufEnter,CursorHold * if mode() != 'c' | checktime | endif

  " Notification after file change
  " https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
  autocmd FileChangedShellPost *
        \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

augroup END

function! s:OnTermOpen() abort
    setlocal nolist nonumber sidescrolloff=0 nocursorline
    startinsert!
endfunction

if has('nvim')
  augroup ar_terminal
    autocmd!
    autocmd TermOpen * call s:OnTermOpen()
    autocmd BufLeave term://* stopinsert
  augroup END
endif
