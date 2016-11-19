scriptencoding utf-8

function! s:is_filetype_mode_filetype() abort
  return index(['nerdtree', 'help', 'tagbar', 'man', 'qf', 'fzf'], &filetype) >= 0
endfunction

function! s:is_no_lineinfo_filetype() abort
  return index(['nerdtree', 'tagbar', 'fzf'], &filetype) >= 0
endfunction

function! s:is_no_fileformat_filetype() abort
  return index(['nerdtree', 'help', 'tagbar', 'man', 'qf', 'fzf'], &filetype) >= 0
endfunction

function! s:is_no_filename_filetype() abort
  return index(['nerdtree', 'tagbar', 'qf', 'fzf'], &filetype) >= 0
endfunction

function! s:is_readonly_filetype() abort
  return index(['nerdtree', 'help', 'tagbar', 'man', 'qf'], &filetype) >= 0
endfunction

function! s:readonly() abort
  if &readonly && !s:is_readonly_filetype()
    return ' '
  endif
  return ''
endfunction

function! s:filename(fmt) abort
  if s:is_no_filename_filetype()
    return ''
  endif

  let l:fname = expand(a:fmt)
  if l:fname =~? '^term:\/\/'
    return s:filename('%:t')
  elseif l:fname ==# 'ControlP' && has_key(g:lightline, 'ctrlp_item')
    return g:lightline.ctrlp_item
  elseif l:fname != ''
    return l:fname
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

function! statusline#lightlineFilename() abort
  return s:filename('%') . s:modified() . s:readonly()
endfunction

function! statusline#lightlineFugitive() abort
  if s:is_readonly_filetype()
    return ''
  endif
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

function! statusline#lightlineFileformat() abort
  if winwidth(0) < 70 || s:is_no_fileformat_filetype()
    return ''
  endif
  return &fileformat
endfunction

function! statusline#lightlineFiletype() abort
  if winwidth(0) < 70 || s:is_no_fileformat_filetype()
    return ''
  endif
  return strlen(&filetype) ? &filetype : 'no ft'
endfunction

function! statusline#lightlineFileencoding() abort
  if winwidth(0) < 70 || s:is_no_fileformat_filetype()
    return ''
  endif
  return strlen(&fileencoding) ? &fileencoding : &encoding
endfunction

function! statusline#lightlineMode() abort
  if s:is_filetype_mode_filetype()
    return toupper(&filetype)
  elseif expand('%:t') ==# 'ControlP'
    return 'CtrlP'
  endif
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! statusline#StatusLineLineInfo() abort
  if winwidth(0) < 70 || s:is_no_lineinfo_filetype()
    return ''
  elseif expand('%:f') =~? '^term:\/\/'
    return ''
  endif
  return printf('%d/%d', line('.'), line('$') )
endfunction

function! statusline#lightlineLineInfo() abort
  return '%{statusline#StatusLineLineInfo()}'
endfunction

function! statusline#lightlineGo() abort
  return exists('*go#jobcontrol#Statusline') ? go#jobcontrol#Statusline() : ''
endfunction

function! statusline#lightlineNeomake() abort
  return exists('*neomake#statusline#LoclistStatus') ? neomake#statusline#LoclistStatus() : ''
endfunction

autocmd vimrc User NeomakeCountsChanged call lightline#update()

function! statusline#CtrlPMark() abort
  if expand('%:t') =~? 'ControlP' && has_key(g:lightline, 'ctrlp_item')
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

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
  let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction
