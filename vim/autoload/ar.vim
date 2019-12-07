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

" Returns true if the plugin {plugin} is loaded.
function! ar#is_loaded(plugin) abort
  return has_key(g:plugs, a:plugin) && stridx(&runtimepath, g:plugs[a:plugin].dir) >= 0
endfunction

" Returns true if the plugin {plugin} is installed.
function! ar#is_installed(plugin) abort
    return has_key(g:plugs, a:plugin) && isdirectory(g:plugs[a:plugin].dir)
endfunction
