" =======================================================================
" autoload/ar.vim
" =======================================================================
if exists('g:loaded_ar') | finish | endif
let g:loaded_ar = 1

let s:profile_enabled = 0
let s:profile_log     = '/tmp/vim_profile.log'

" Toggle vim profiling
function! ar#profile() abort
  if s:profile_enabled
    profile pause
    noautocmd qall
  else
    let s:profile_enabled = 1
    profile start s:profile_log
    profile func *
    profile file *
  endif
endfunction

" Reload and sync syntax.
function! ar#reload_syntax() abort
  syntax sync fromstart
  redraw!
endfunction

" Detect project root directory
function! ar#project_root() abort
  if exists('b:git_dir') && !empty(b:git_dir)
    return fnamemodify(b:git_dir, ':h')
  endif
  return getcwd()
endfunction

" Find and source project-specific Vim configs
function! ar#source_project_config() abort
  let l:projectfile = findfile('.vimrc.local', expand('%:p').';')
  if filereadable(l:projectfile)
    execute 'source' l:projectfile
  endif
endfunction

" -----------------------------------------------------------------------
" Plugins
" -----------------------------------------------------------------------

" Auto install plugin manager if not detected
function! ar#ensure_plugin_manager() abort
  if empty(glob(expand(g:vim_dir . '/autoload/plug.vim')))
    call ar#plug_install()
  endif
endfunction

" Install plugin manager
function! ar#plug_install() abort
  execute 'silent !curl --create-dirs -fLo '
        \  g:vim_dir . '/autoload/plug.vim '
        \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

  augroup ar_plug_install
    autocmd!
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup END
endfunction

" Conditionally load plugins.
" https://github.com/junegunn/vim-plug/wiki/faq
function! ar#plug_if(condition, ...) abort
  let l:enabled = a:condition ? {} : { 'on': [], 'for': [] }
  return a:0 ? extend(l:enabled, a:000[0]) : l:enabled
endfunction

" Returns true if the plugin {name} is loaded.
function! ar#is_loaded(name) abort
  if index(g:plugs_order, a:name) < 0
    return 0
  endif

  let l:plug_dir = g:plugs[a:name].dir
  if empty(l:plug_dir)  || !isdirectory(l:plug_dir)
    return 0
  endif

  return empty(l:plug_dir) ? 0 : stridx(&runtimepath, l:plug_dir) > -1
endfunction

" Returns true if the plugin {name} is installed.
function! ar#is_plugged(name) abort
    return index(g:plugs_order, a:name) > -1
endfunction

" -----------------------------------------------------------------------
" vim:foldmethod=marker
