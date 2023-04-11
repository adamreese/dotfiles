" =======================================================================
" autoload/ar/fzf.vim
" =======================================================================
if exists('g:loaded_ar_fzf') | finish | endif
let g:loaded_ar_fzf = 1

function! ar#fzf#Files(dir, fullscreen) abort
  call fzf#vim#files(a:dir, ar#fzf#WithPreview(a:fullscreen), a:fullscreen)
endfunction

function! ar#fzf#WithPreview(fullscreen, ...) abort
  let l:p = s:layout(a:fullscreen)
  return call('fzf#vim#with_preview', a:000 + [l:p, '?'])
endfunction

function! s:layout(fullscreen) abort
  if a:fullscreen
    return 'up:50%:hidden'
  end

  let l:height = &lines
  let l:width = &columns
  let l:ratio = l:width / l:height

  if l:ratio < 2 && l:height > 100
    return 'up:70%:hidden'
  elseif l:ratio < 2 && l:height > 70
    return 'up:65%:hidden'
  elseif l:ratio < 2
    return 'up:55%:hidden'
  elseif l:width > 250
    return 'right:70%:hidden'
  elseif l:width > 220
    return 'right:65%:hidden'
  else
    return 'right:55%:hidden'
  endif
endfunction
