" =======================================================================
" autoload/statusline.vim
" =======================================================================
scriptencoding utf-8

function! s:is_mode_filetype() abort
  return index(g:lightline_mode_filetypes, &filetype) >= 0
endfunction

function! s:is_no_lineinfo_filetype() abort
  return index(g:lightline_no_lineinfo_filetypes, &filetype) >= 0
endfunction

function! s:is_no_fileformat_filetype() abort
  return index(g:lightline_no_fileformat_filetypes, &filetype) >= 0
endfunction

function! s:is_no_filename_filetype() abort
  return index(g:lightline_no_filename_filetypes, &filetype) >= 0
endfunction

function! s:is_readonly_filetype() abort
  return index(g:lightline_readonly_filetypes, &filetype) >= 0
endfunction

function! s:is_terminal() abort
  return expand('%:t') =~? '^term:\/\/'
endfunction

function! s:is_ctrlp() abort
  return expand('%:t') ==# 'ControlP'
endfunction

function! s:readonly() abort
  if &readonly && !s:is_readonly_filetype()
    return ' [RO]'
  endif
  return ''
endfunction

function! s:filename(fmt) abort
  if s:is_no_filename_filetype()
    return ''
  endif

  if s:is_terminal()
    return s:filename('%:t')
  endif

  if s:is_ctrlp() && has_key(g:lightline, 'ctrlp_item')
    return g:lightline.ctrlp_item
  endif

  if len(expand(a:fmt)) > 0
    return expand(a:fmt)
  endif

  return '[No Name]'
endfunction

function! s:modified() abort
  if s:is_readonly_filetype()
    return ''
  elseif &modified
    return '[+]'
  elseif &modifiable
    return ''
  endif
  return '[-]'
endfunction

function! statusline#filename() abort
  return s:filename('%:.') . s:modified() . s:readonly()
endfunction

function! statusline#git_branch() abort
  if s:is_readonly_filetype()
    return ''
  endif
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

function! statusline#filetype() abort
  if winwidth(0) < 70 || s:is_no_fileformat_filetype()
    return ''
  elseif s:is_ctrlp()
    return ''
  endif
  return strlen(&filetype) ? &filetype : 'no ft'
endfunction

function! statusline#mode() abort
  if s:is_mode_filetype()
    return toupper(&filetype)
  elseif s:is_ctrlp()
    return 'CtrlP'
  endif
  return lightline#mode()
endfunction

function! statusline#statuslineinfo() abort
  if winwidth(0) < 70
    return ''
  elseif s:is_no_lineinfo_filetype()
    return ''
  elseif s:is_terminal()
    return ''
  endif

  return printf('%3.0f%% %3d:%-2d',
        \ round((line('.') * 1.0) / line('$') * 100),
        \ line('.'),
        \ col('.'))
endfunction

function! statusline#lineinfo() abort
  return '%{statusline#statuslineinfo()}'
endfunction

function! statusline#go() abort
  return exists('*go#jobcontrol#Statusline') ? go#jobcontrol#Statusline() : ''
endfunction

function! statusline#neomake() abort
  return exists('*neomake#statusline#LoclistStatus') ? neomake#statusline#LoclistStatus() : ''
endfunction

autocmd vimrc User NeomakeCountsChanged call lightline#update()

function! statusline#ctrlpmark() abort
  if s:is_ctrlp() && has_key(g:lightline, 'ctrlp_item')
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  endif
  return ''
endfunction

let g:ctrlp_status_func = {
      \ 'main': 'CtrlPStatusFunc_1',
      \ 'prog': 'CtrlPStatusFunc_2',
      \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked) abort
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str) abort
  return lightline#statusline(0)
endfunction

" -----------------------------------------------------------------------
" vim:foldmethod=marker
