" =======================================================================
" plugin/mappings.vim
" =======================================================================

" -----------------------------------------------------------------------
" Mapping: Terminal
" -----------------------------------------------------------------------

" Add neovim terminal escape with ESC mapping
" tnoremap <ESC> <C-\><C-n>

" Recursive mappings so that the rebound <C-direction> mappings are triggerd
tmap <C-h> <C-\><C-n><C-h>
tmap <C-j> <C-\><C-n><C-j>
tmap <C-k> <C-\><C-n><C-k>
tmap <C-l> <C-\><C-n><C-l>
