" =======================================================================
" autoload/ar.vim
" =======================================================================
if exists('g:loaded_ar') | finish | endif
let g:loaded_ar = v:true

" Reload and sync syntax.
function! ar#ReloadSyntax() abort
  syntax sync fromstart
  redraw!
endfunction

" -----------------------------------------------------------------------
" Plugins
" -----------------------------------------------------------------------

" Auto install plugin manager if not detected
function! ar#EnsurePluginManager() abort
  if empty(glob(expand(g:vim_dir . '/autoload/plug.vim')))
    call ar#PlugInstall()
  endif
endfunction

" Install plugin manager
function! ar#PlugInstall() abort
  execute 'silent !curl --create-dirs -fLo '
        \  g:vim_dir . '/autoload/plug.vim '
        \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

  augroup ar_plug_install
    autocmd!
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup END
endfunction

" Returns true if the plugin {plugin} is loaded.
function! ar#IsLoaded(plugin) abort
  let l:plug_dir = s:PlugDir(a:plugin)
  if empty(l:plug_dir)  || !isdirectory(l:plug_dir)
    return 0
  endif

  return stridx(&runtimepath, l:plug_dir) >= 0
endfunction

" Returns true if the plugin {plugin} is installed.
function! ar#IsInstalled(plugin) abort
    return has_key(g:plugs, a:plugin) && isdirectory(g:plugs[a:plugin].dir)
endfunction

function! ar#PlugExists(name) abort
  return index(get(g:, 'plugs_order', []), a:name) > -1
endfunction

function! s:PlugDir(name) abort
  let l:dir = ar#PlugExists(a:name) ? g:plugs[a:name].dir : ''
  let l:dir = substitute(l:dir, '/$', '', '')
  return l:dir
endfunction
