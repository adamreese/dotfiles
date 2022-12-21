" =======================================================================
" plugin/mappings.vim
" =======================================================================

" Close quickfix/location window
nnoremap <silent><leader>c :<C-u>cclose<bar>lclose<CR>

" Format buffer
nnoremap <leader>= ggVG=<CR>

" Toggle spell checking
nnoremap <silent><leader>ss :<C-u>setlocal spell!<CR>

" Toggle wrapping
nnoremap <leader>tw :<C-u>setlocal wrap! breakindent! wrap?<CR>

" Sorting
vnoremap <leader>srt :<C-u>sort<CR>

" Remove search highlight
nmap <silent><leader><CR> :<C-u>nohlsearch<CR>

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
