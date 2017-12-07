" =======================================================================
" plugin/plug/fzf.vim
" =======================================================================
if !ar#is_loaded('fzf.vim') | finish | endif

" Settings
" -----------------------------------------------------------------------
if has('nvim')
  let $FZF_DEFAULT_OPTS .= ' --inline-info --bind ctrl-a:select-all '
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

nnoremap <silent>[FZF]f  :<C-u>Files<CR>
nnoremap <silent>[FZF]p  :<C-u>Plugs<CR>
nnoremap <silent>[FZF]b  :<C-u>Buffers<CR>
nnoremap <silent>[FZF]h  :<C-u>Helptags<CR>
nnoremap <silent>[FZF]t  :<C-u>BTags<CR>
nnoremap <silent>[FZF]T  :<C-u>Tags<CR>
nnoremap <silent>[FZF]ev :<C-u>VimFiles<CR>
nnoremap <silent>[FZF]ed :<C-u>DotFiles<CR>

nnoremap <silent><C-p> :Files<CR>
noremap <leader>gb :<C-u>Buffers<CR>
noremap <leader>gt :<C-u>BTags<CR>
noremap <leader>ev :<C-u>VimFiles<CR>

" Commands
" -----------------------------------------------------------------------
command! Plugs call fzf#run(fzf#wrap('Plugs', {
      \ 'dir':     g:plug_home,
      \ 'source':  sort(keys(g:plugs)),
      \ 'options': '--delimiter / --nth -1',
      \ 'sink':    'tabedit',
      \ }))

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


" Modeline {{{1
" -----------------------------------------------------------------------
" vim: foldmethod=marker
