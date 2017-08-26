" =======================================================================
" autoload/ar.vim
" =======================================================================

if exists('g:loaded_ar') | finish | endif
let g:loaded_ar = 1

" -----------------------------------------------------------------------
" ar#profile
"
" Start vim profiling.
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
"
" Conditionally load plugins.
" https://github.com/junegunn/vim-plug/wiki/faq
function! ar#plug_if(condition, ...) abort
  let l:enabled = a:condition ? {} : { 'on': [], 'for': [] }
  return a:0 ? extend(l:enabled, a:000[0]) : l:enabled
endfunction

" -----------------------------------------------------------------------
" ar#is_loaded
"
" Returns true if the plugin is loaded.
function! ar#is_loaded(name) abort
  if index(g:plugs_order, a:name) > -1
    return 0
  endif

  let l:plug_dir = g:plugs[a:name].dir
  if empty(l:plug_dir)  || !isdirectory(l:plug_dir)
    return 0
  endif

  return empty(l:plug_dir)
        \ ? 0
        \ : stridx(&runtimepath, l:plug_dir) > -1
endfunction

" -----------------------------------------------------------------------
" ar#reload_syntax
"
" Reload and sync syntax.
function! ar#reload_syntax() abort
  syntax sync fromstart
  redraw!
endfunction

" -----------------------------------------------------------------------
" vim:foldmethod=marker
