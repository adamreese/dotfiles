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
  let l:command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let l:initial_command = printf(l:command_fmt, shellescape(a:query))
  let l:reload_command = printf(l:command_fmt, '{q}')
  let l:spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.l:reload_command]}
  call fzf#vim#grep(l:initial_command, 1, fzf#vim#with_preview(l:spec), a:fullscreen)
endfunction

function! ar#fzf#Files(dir, fullscreen) abort
  call fzf#vim#files(a:dir, s:FzfPreview(a:fullscreen), a:fullscreen)
endfunction

function! s:FzfPreview(fullscreen) abort
  return a:fullscreen ? fzf#vim#with_preview('up:60%') : fzf#vim#with_preview('right:50%:hidden', '?')
endfunction
