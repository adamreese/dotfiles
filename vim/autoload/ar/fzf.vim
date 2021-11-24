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

  call fzf#vim#grep(l:initial_cmd, 1, ar#fzf#WithPreview(l:spec), a:fullscreen)
endfunction

function! ar#fzf#Files(dir, fullscreen) abort
  call fzf#vim#files(a:dir, ar#fzf#WithPreview(a:fullscreen), a:fullscreen)
endfunction

function! ar#fzf#WithPreview(fullscreen, ...) abort
  let l:p = s:layout(a:fullscreen)
  return call('fzf#vim#with_preview', a:000 + [l:p, '?'])
endfunction

function! s:layout(fullscreen) abort
  if a:fullscreen
    return 'up:50%:hidden'
  end

  let l:height = &lines
  let l:width = &columns
  let l:ratio = l:width / l:height

  if l:ratio < 2 && l:height > 100
    return 'up:70%:hidden'
  elseif l:ratio < 2 && l:height > 70
    return 'up:65%:hidden'
  elseif l:ratio < 2
    return 'up:55%:hidden'
  elseif l:width > 250
    return 'right:70%:hidden'
  elseif l:width > 220
    return 'right:65%:hidden'
  else
    return 'right:55%:hidden'
  endif
endfunction
