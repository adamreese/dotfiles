" =======================================================================
" autoload/ar/plug.vim
" =======================================================================
if exists('g:loaded_ar_plug') | finish | endif
let g:loaded_ar_plug = v:true

" -----------------------------------------------------------------------
" Plugins
" -----------------------------------------------------------------------

" Auto install plugin manager if not detected
function! ar#plug#EnsureManager() abort
  if empty(glob(expand(g:vim_dir . '/autoload/plug.vim')))
    call s:InstallManager()
  endif
endfunction

" Install plugin manager
function! s:InstallManager() abort
  execute 'silent !curl --create-dirs -fLo '
        \  g:vim_dir . '/autoload/plug.vim '
        \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

  augroup ar_plug_install
    autocmd!
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup END
endfunction

" Returns true if the plugin {plugin} is loaded.
function! ar#plug#IsLoaded(plugin) abort
  let l:plug_dir = s:PlugDir(a:plugin)
  if empty(l:plug_dir)  || !isdirectory(l:plug_dir)
    return 0
  endif

  return stridx(&runtimepath, l:plug_dir) >= 0
endfunction

" Returns true if the plugin {plugin} is installed.
function! ar#plug#IsInstalled(plugin) abort
    return has_key(g:plugs, a:plugin) && isdirectory(g:plugs[a:plugin].dir)
endfunction

function! s:Exists(name) abort
  return index(get(g:, 'plugs_order', []), a:name) > -1
endfunction

function! s:PlugDir(name) abort
  let l:dir = s:Exists(a:name) ? g:plugs[a:name].dir : ''
  let l:dir = substitute(l:dir, '/$', '', '')
  return l:dir
endfunction
