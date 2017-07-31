" =======================================================================
" autoload/folding.vim
" =======================================================================
scriptencoding utf-8

" -----------------------------------------------------------------------
"  folding#text
" -----------------------------------------------------------------------

" See: http://dhruvasagar.com/2013/03/28/vim-better-foldtext
function! folding#text() abort
  let l:line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '

  let l:range   = foldclosedend(v:foldstart) - foldclosed(v:foldstart) + 1
  let l:foldchar = matchstr(&fillchars, 'fold:\zs.')

  let l:foldtextstart = '+' . strpart(repeat(l:foldchar, v:foldlevel*2) . l:line, 0, (winwidth(0)*2)/3)

  let l:foldtextend = printf('┤ %3s ├%s', l:range, repeat(l:foldchar, 8))
  let l:foldtextlength = strlen(substitute(l:foldtextstart . l:foldtextend, '.', 'x', 'g')) + &foldcolumn
  return l:foldtextstart . repeat(l:foldchar, winwidth(0)-l:foldtextlength) . l:foldtextend
endfunction

" -----------------------------------------------------------------------
" vim:foldmethod=marker
