" =======================================================================
" plugin/plug/fzf.vim
" =======================================================================
if !ar#is_loaded('fzf.vim') | finish | endif

let s:cpo_save = &cpoptions
set cpoptions&vim

" Settings
" -----------------------------------------------------------------------
if has('nvim')
  let $FZF_DEFAULT_OPTS = ' --inline-info --bind ctrl-a:select-all,ctrl-d:deselect-all'
endif

let g:fzf_layout          = { 'down': '16' }
let g:fzf_buffers_jump    = 1
let g:fzf_history_dir     = g:data_dir . '/fzf-history'
let g:fzf_colors = {
      \ 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment']
      \ }

" Mappings
" -----------------------------------------------------------------------
nnoremap [FZF]   <Nop>
nmap     <space> [FZF]

nnoremap <silent>[FZF]f     :<C-U>Files<CR>
nnoremap <silent>[FZF]p     :<C-U>Plugs<CR>
nnoremap <silent>[FZF]b     :<C-U>Buffers<CR>
nnoremap <silent>[FZF]h     :<C-U>Helptags<CR>
nnoremap <silent>[FZF]t     :<C-U>BTags<CR>
nnoremap <silent>[FZF]T     :<C-U>Tags<CR>
nnoremap <silent>[FZF]m     :<C-U>GFiles?<CR>
nnoremap <silent>[FZF]ev    :<C-U>VimFiles<CR>
nnoremap <silent>[FZF]ed    :<C-U>DotFiles<CR>

" -----------------------------------------------------------------------

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit',
      \ 'ctrl-t': 'tabedit',
      \ 'ctrl-q': function('s:build_quickfix_list'),
      \ }

" Commands
" -----------------------------------------------------------------------
function! s:fzf_preview(bang) abort
  return a:bang ? fzf#vim#with_preview('up:60%') : fzf#vim#with_preview('right:50%:hidden', '?')
endfunction

command! -bang Plugs call fzf#run(fzf#wrap('Plugs', extend({
      \ 'dir':     g:plug_home,
      \ 'source':  sort(keys(g:plugs)),
      \ 'sink':    'tabedit',
      \ }, g:fzf_layout), <bang>0))

command! VimFiles call fzf#run(fzf#wrap('VimFiles',
      \   fzf#vim#with_preview(extend({
      \     'dir': g:vim_dir,
      \   }, g:fzf_layout), 'right:50%')
      \ ))

command! DotFiles call fzf#run(fzf#wrap('DotFiles',
      \   fzf#vim#with_preview(extend({
      \     'dir': '~/.dotfiles',
      \   }, g:fzf_layout), 'right:50%')
      \ ))

command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, s:fzf_preview(<bang>0), <bang>0)

command! -bang -nargs=* Agr
      \ call fzf#vim#ag_raw(<q-args>, s:fzf_preview(<bang>0), <bang>0)

let s:rg_command = 'rg --color=always --column --hidden --line-number --no-heading --ignore-file ~/.agignore '
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(s:rg_command . shellescape(<q-args>), 1, s:fzf_preview(<bang>0), <bang>0)

augroup ar_fzf
  autocmd!
  autocmd User FzfStatusLine silent
augroup END

let &cpoptions = s:cpo_save
unlet s:cpo_save
