" =======================================================================
" autoload/vimrc.vim
" =======================================================================
"  vimrc#foldtext() {{{
" -----------------------------------------------------------------------
" See: http://dhruvasagar.com/2013/03/28/vim-better-foldtext
function! vimrc#foldtext() abort
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
"  vimrc#synstack() {{{
" -----------------------------------------------------------------------
function! vimrc#synstack() abort
  if !exists('*synstack')
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc "}}}
" -----------------------------------------------------------------------
"  vimrc#profile() {{{
" -----------------------------------------------------------------------
function! vimrc#profile(bang) abort
  if a:bang
    profile pause
    noautocmd qall
  else
    profile start /tmp/profile.log
    profile func *
    profile file *
  endif
endfunction "}}}
