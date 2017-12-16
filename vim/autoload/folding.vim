" =======================================================================
" autoload/folding.vim
" =======================================================================
scriptencoding utf-8

" -----------------------------------------------------------------------
" folding#text
" -----------------------------------------------------------------------

function! folding#text() abort
  let l:linelen = winwidth( 0 ) - (&number ? &numberwidth : 0) - &foldcolumn - 3

  let l:marker  = strpart(&foldmarker, 0, stridx(&foldmarker, ',')) . '\d*'
  let l:range   = foldclosedend(v:foldstart) - foldclosed(v:foldstart) + 1

  let l:left    = substitute(getline(v:foldstart), l:marker, '', '')
  let l:leftlen = len(l:left)

  let l:right    = printf('%d [%d]', l:range, v:foldlevel)
  let l:rightlen = len(l:right)

  let l:tmp    = strpart(l:left, 0, l:linelen - l:rightlen)
  let l:tmplen = len(l:tmp)

  if l:leftlen > len(l:tmp)
    let l:left    = strpart(l:tmp, 0, l:tmplen - 4) . '... '
    let l:leftlen = l:tmplen
  endif

  let l:fill = repeat(' ', l:linelen - (l:leftlen + l:rightlen))

  return l:left . l:fill . l:right . repeat(' ', 100)
endfunction

" -----------------------------------------------------------------------
" vim:foldmethod=marker
