" =======================================================================
" autoload/folding.vim
" =======================================================================
"  vimrc#foldtext() {{{
" -----------------------------------------------------------------------

" See: http://dhruvasagar.com/2013/03/28/vim-better-foldtext
function! folding#text() abort
  let l:line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let l:lines_count = v:foldend - v:foldstart + 1
  let l:lines_count_text = '| ' . printf('%10s', l:lines_count . ' lines') . ' |'
  let l:foldchar = matchstr(&fillchars, 'fold:\zs.')
  let l:foldtextstart = strpart('+' . repeat(l:foldchar, v:foldlevel*2) . l:line, 0, (winwidth(0)*2)/3)
  let l:foldtextend = l:lines_count_text . repeat(l:foldchar, 8)
  let l:foldtextlength = strlen(substitute(l:foldtextstart . l:foldtextend, '.', 'x', 'g')) + &foldcolumn
  return l:foldtextstart . repeat(l:foldchar, winwidth(0)-l:foldtextlength) . l:foldtextend
endfunction "}}}

" -----------------------------------------------------------------------
" vim:foldmethod=marker
