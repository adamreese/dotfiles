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
  " https://github.com/neovim/neovim/issues/7994
  autocmd InsertLeave * set nopaste

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
  autocmd WinLeave,InsertEnter * setlocal nocursorline
  autocmd WinEnter,InsertLeave *
        \ if &filetype !=# 'qf' && &buftype !=# 'terminal' && !&diff |
        \   setlocal cursorline |
        \ endif
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
augroup END

if has('nvim')
  augroup ar_terminal
    autocmd!
    autocmd TermOpen * startinsert!
    autocmd TermClose term://* stopinsert
  augroup END
endif
