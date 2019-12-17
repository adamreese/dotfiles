" =======================================================================
" autoload/ar.vim
" =======================================================================
if exists('g:loaded_ar') | finish | endif
let g:loaded_ar = v:true

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
