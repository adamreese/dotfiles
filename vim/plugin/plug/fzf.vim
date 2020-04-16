" =======================================================================
" plugin/plug/fzf.vim
" =======================================================================
if !ar#IsLoaded('fzf.vim') | finish | endif

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
nmap     <Space> [FZF]

nnoremap <silent>[FZF]/     :<C-U>History/<CR>
nnoremap <silent>[FZF]:     :<C-U>History:<CR>
nnoremap <silent>[FZF]T     :<C-U>Tags<CR>
nnoremap <silent>[FZF]b     :<C-U>Buffers<CR>
nnoremap <silent>[FZF]f     :<C-U>Files<CR>
nnoremap <silent>[FZF]g     :<C-U>RG<Space>
nnoremap <silent>[FZF]h     :<C-U>Helptags<CR>
nnoremap <silent>[FZF]m     :<C-U>GFiles?<CR>
nnoremap <silent>[FZF]p     :<C-U>Plugs<CR>
nnoremap <silent>[FZF]r     :<C-U>History<CR>
nnoremap <silent>[FZF]t     :<C-U>BTags<CR>

" -----------------------------------------------------------------------

function! s:BuildQuickfixList(lines)
  call setqflist(map(copy(a:lines), {_, v -> {'filename': v} }), 'a')
  copen
  cc
endfunction

function! s:BuildLocationList(lines)
  call setloclist(0, map(copy(a:lines), {_, v -> {'filename': v} }), 'a')
  lopen
  ll
endfunction

let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit',
      \ 'ctrl-t': 'tabedit',
      \ 'ctrl-q': function('s:BuildQuickfixList'),
      \ 'ctrl-l': function('s:BuildLocationList'),
      \ }

" Commands
" -----------------------------------------------------------------------
command! -bang -nargs=0 Plugs        call ar#fzf#Plugs(<bang>0)
command! -bang -nargs=* RG           call ar#fzf#Rg(<q-args>, <bang>0)

command! -bang -nargs=? -complete=dir Files call ar#fzf#Files(<q-args>, <bang>0)

" -----------------------------------------------------------------------

" Enable Floating FZF for NeoVim 0.4.0+ or Vim 8.0+
let s:has_float = has('nvim-0.4.0') || v:version >= 800

if s:has_float
  let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.6, 'border': 'rounded' } }
endif

let &cpoptions = s:cpo_save
unlet s:cpo_save
