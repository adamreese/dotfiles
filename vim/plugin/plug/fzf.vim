" =======================================================================
" plugin/plug/fzf.vim
" =======================================================================
if !ar#is_loaded('fzf.vim') | finish | endif

" Settings
" -----------------------------------------------------------------------
if has('nvim')
  let $FZF_DEFAULT_OPTS .= ' --inline-info'
endif

if !has('nvim') && $TERM_PROGRAM ==# 'iTerm.app'
  let g:fzf_launcher = 'vim-fzf'
endif

let g:fzf_layout = { 'down': '16' }

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

let g:fzf_nvim_statusline = 0

" Mappings
" -----------------------------------------------------------------------
nnoremap [FZF]   <Nop>
nmap     <space> [FZF]

nnoremap [FZF]f :Files<cr>
nnoremap [FZF]b :Buffers<cr>
nnoremap [FZF]h :Helptags<cr>
nnoremap [FZF]t :BTags<cr>
nnoremap [FZF]T :Tags<cr>

nnoremap [FZF]ev :<C-u>execute 'Files ' . g:vim_dir<CR>
nnoremap [FZF]ed :Files ~/.dotfiles<CR>

" Commands
" -----------------------------------------------------------------------
command! Plugs call fzf#run({
      \ 'source':  map(sort(keys(g:plugs)), 'g:plug_home."/".v:val'),
      \ 'options': '--delimiter / --nth -1',
      \ 'sink':    'tabedit',
      \ })

" Modeline {{{1
" -----------------------------------------------------------------------
" vim: foldmethod=marker
