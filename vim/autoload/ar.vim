" =======================================================================
" autoload/ar.vim
" =======================================================================

if exists('g:loaded_ar') | finish | endif
let g:loaded_ar = 1

" -----------------------------------------------------------------------
" ar#profile
" -----------------------------------------------------------------------
function! ar#profile(bang) abort
  if a:bang
    profile pause
    noautocmd qall
  else
    profile start /tmp/profile.log
    profile func *
    profile file *
  endif
endfunction

" -----------------------------------------------------------------------
" ar#plug_if
" -----------------------------------------------------------------------

function! ar#plug_if(cond, ...) abort
  let l:opts = get(a:000, 0, {})
  return a:cond ? l:opts : extend(l:opts, { 'on': [], 'for': [] })
endfunction

" -----------------------------------------------------------------------
" ar#is_loaded returns true if the plugin is loaded.
" -----------------------------------------------------------------------

function! ar#is_loaded(name) abort
  return has_key(g:plugs, a:name)
endfunction

" -----------------------------------------------------------------------
" ar#reload_syntax
" -----------------------------------------------------------------------
function! ar#reload_syntax() abort
  syntax sync fromstart
  redraw!
endfunction

" -----------------------------------------------------------------------
" vim:foldmethod=marker
