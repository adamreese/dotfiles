" =======================================================================
" autoload/ar/fzf.vim
" =======================================================================
if exists('g:loaded_ar_fzf') | finish | endif
let g:loaded_ar_fzf = 1

function! ar#fzf#Plugs(fullscreen) abort
  function! s:plugopen(e) abort
    let l:path = g:plug_home . '/' . a:e
    execute 'tabedit' l:path
    execute 'tcd' l:path
  endfunction

  call fzf#run(fzf#wrap('Plugs', {
        \ 'dir':     g:plug_home,
        \ 'source':  sort(keys(g:plugs)),
        \ 'sink':    function('s:plugopen'),
        \ 'options': '--prompt='.shellescape('plugs> '),
        \ }, a:fullscreen))
endfunction

function! ar#fzf#Rg(query, fullscreen) abort
  let l:cmd_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'

  let l:initial_cmd = printf(l:cmd_fmt, shellescape(a:query))
  let l:reload_cmd = printf('change:reload:'.l:cmd_fmt, '{q}')

  let l:spec = {'options': [
        \ '--phony',
        \ '--query', a:query,
        \ '--bind', l:reload_cmd,
        \ ]}

  call fzf#vim#grep(l:initial_cmd, 1, fzf#vim#with_preview(l:spec), a:fullscreen)
endfunction

function! ar#fzf#Files(dir, fullscreen) abort
  call fzf#vim#files(a:dir, s:FzfPreview(a:fullscreen), a:fullscreen)
endfunction

function! s:FzfPreview(fullscreen) abort
  let l:p = a:fullscreen ? 'up:60%' : 'right:50%:hidden'
  return fzf#vim#with_preview(l:p, '?')
endfunction
