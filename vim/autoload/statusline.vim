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
  endif
  return strlen(&filetype) ? &filetype : 'no ft'
endfunction

function! statusline#mode() abort
  if s:is_mode_filetype()
    return toupper(&filetype)
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

  let l:line = line('.')
  let l:max_line = line('$')
  let l:col = virtcol('.')
  let l:percent = round((l:line * 1.0) / l:max_line * 100)

  return printf('%3.0f%% %3d/%d:%-2d', l:percent, l:line, l:max_line, l:col)
endfunction

function! statusline#lineinfo() abort
  return '%{statusline#statuslineinfo()}'
endfunction

function! statusline#go() abort
  return exists('*go#statusline#Show') ? go#statusline#Show() : ''
endfunction

function! statusline#search() abort
  return exists('*anzu#search_status') ? anzu#search_status() : ''
endfunction

function! statusline#neomake() abort
  return exists('g:loaded_neomake') ? neomake#statusline#LoclistStatus() : ''
endfunction

function! statusline#neomake_error() abort
  return s:neomake_count('E')
endfunction

function! statusline#neomake_warning() abort
  return s:neomake_count('W')
endfunction

function! statusline#neomake_info() abort
  return s:neomake_count('I')
endfunction

function! s:neomake_count(group) abort
  if ! exists('g:loaded_neomake')
    return ''
  endif
  let l:counts = neomake#statusline#LoclistCounts()
  let l:g = get(l:counts, a:group, 0)
  return l:g > 0 ? printf('%s:%d', a:group, l:g) : ''
endfunction

autocmd vimrc User NeomakeCountsChanged call lightline#update()

function! statusline#tagbar_status(current, sort, fname, ...) abort
  return lightline#statusline(0)
endfunction

" -----------------------------------------------------------------------
" vim:foldmethod=marker
