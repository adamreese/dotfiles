" =======================================================================
" plugin/plug/fzf.vim
" =======================================================================
if !ar#is_loaded('fzf.vim') | finish | endif

" Settings
" -----------------------------------------------------------------------
if g:nvim
  let $FZF_DEFAULT_OPTS .= ' --inline-info --bind ctrl-a:select-all '
endif

let g:fzf_layout = { 'down': '16' }

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

let g:fzf_nvim_statusline = 0

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
nnoremap <silent>[FZF]m     :<C-U>Modified<CR>
nnoremap <silent>[FZF]ev    :<C-U>VimFiles<CR>
nnoremap <silent>[FZF]ed    :<C-U>DotFiles<CR>

nnoremap <silent><C-P>      :<C-U>Files<CR>
nnoremap <silent><leader>gb :<C-U>Buffers<CR>
nnoremap <silent><leader>gt :<C-U>BTags<CR>
nnoremap <silent><leader>ev :<C-U>VimFiles<CR>

" Commands
" -----------------------------------------------------------------------
command! Plugs call fzf#run(fzf#wrap('Plugs', extend({
      \ 'dir':     g:plug_home,
      \ 'source':  sort(keys(g:plugs)),
      \ 'sink':    'tabedit',
      \ }, g:fzf_layout)))

command! Modified call fzf#run(fzf#wrap('Modified',
      \   fzf#vim#with_preview(extend({
      \     'source': 'git ls-files --exclude-standard --others --modified',
      \   }, g:fzf_layout), 'right:50%')
      \ ))

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
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
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
  \ 'header':  ['fg', 'Comment'] }

" Modeline {{{1
" -----------------------------------------------------------------------
" vim: foldmethod=marker
