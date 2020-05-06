" =======================================================================
" autoload/folding.vim
" =======================================================================
scriptencoding utf-8

" Adapted from http://dhruvasagar.com/2013/03/28/vim-better-foldtext
"
" Assuming your fold fillchar is "-", it produces folds that look like this:
"
" +-- public function example() { ... } ------------------------------   20 lines ----
" +-- public function folding($len, $char) { ... } -------------------  143 lines ----
"
function! folding#Text() abort
  let l:line = substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{{\d*\s*', '', 'g')

  if l:line =~# '\s*{\s*' && getline(v:foldend) =~# '^\s*}\s*'
    let l:line .= ' ... }'
  endif

  let l:line .= ' '

  let l:foldchar = matchstr(&fillchars, 'fold:\zs.')
  let l:foldchar = (l:foldchar ==# '') ? ' ' : l:foldchar

  let l:right= ''

  if winwidth(0) > 60
    let l:lines = v:foldend - v:foldstart + 1
    let l:right= printf(' %10d lines %s', l:lines, repeat(l:foldchar, 4))
  endif

  let l:gutterlen = &foldcolumn + &numberwidth

  let l:foldindent = (v:foldlevel - 1) * exists('*shiftwidth') ? shiftwidth() : &shiftwidth

  let l:foldprefix = l:foldindent > 0 ? '+' . repeat(l:foldchar, l:foldindent - 2) . ' ' : ''
  let l:left = strpart(l:foldprefix . l:line, 0, winwidth(0) - strlen(l:right) - l:gutterlen)
  let l:foldtextlength = strlen(substitute(l:left. l:right, '.', 'x', 'g')) + l:gutterlen

  return l:left. repeat(l:foldchar, winwidth(0) - l:foldtextlength) . l:right
endfunction
