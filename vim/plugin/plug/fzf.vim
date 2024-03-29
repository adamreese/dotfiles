" =======================================================================
" plugin/plug/fzf.vim
" =======================================================================
let s:cpo_save = &cpoptions
set cpoptions&vim

" Settings
" -----------------------------------------------------------------------
let $FZF_DEFAULT_OPTS = ' --inline-info --bind esc:cancel,ctrl-a:select-all,ctrl-d:deselect-all'

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }
let g:fzf_buffers_jump    = 1
let g:fzf_history_dir     = stdpath('state') . '/fzf-history'
let g:fzf_colors = {
      \ 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'Visual', 'CursorLine', 'Normal'],
      \ 'bg+':     ['bg', 'Visual', 'CursorLine'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'],
      \ 'gutter':  ['bg', 'Normal'],
      \ }

" Mappings
" -----------------------------------------------------------------------
nnoremap [FZF]   <Nop>
nmap     <Space> [FZF]

nnoremap <silent>[FZF]/     :<C-U>History/<CR>
nnoremap <silent>[FZF]:     :<C-U>History:<CR>
nnoremap <silent>[FZF]T     :<C-U>Tags<CR>
nnoremap <silent>[FZF]b     :<C-U>Buffers<CR>
nnoremap <silent>[FZF]f     :<C-U>Files<CR>
nnoremap <silent>[FZF]h     :<C-U>Helptags<CR>
nnoremap <silent>[FZF]m     :<C-U>GFiles?<CR>
nnoremap <silent>[FZF]r     :<C-U>History<CR>
nnoremap <silent>[FZF]t     :<C-U>BTags<CR>

let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit',
      \ 'ctrl-t': 'tabedit',
      \ }

" Commands
" -----------------------------------------------------------------------
command! -bang -nargs=0 Plugs
      \ call ar#fzf#Plugs(<bang>0)

command! -bang -nargs=? -complete=dir Files
      \ call ar#fzf#Files(<q-args>, <bang>0)

let &cpoptions = s:cpo_save
unlet s:cpo_save
