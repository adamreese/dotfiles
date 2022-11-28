" =======================================================================
" plugin/mappings.vim
" =======================================================================

" Fast saving
nnoremap <silent><leader>w :<C-u>write!<CR>
nnoremap <silent><leader>q :<C-u>quit!<CR>
nnoremap <silent><leader>Q :<C-u>qall!<CR>

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
" Mapping: Copy & Paste
" -----------------------------------------------------------------------

" Copy to system clipboard
nnoremap <silent> <leader>y "*y
nnoremap <silent> <leader>Y "*Y
vnoremap <silent> <leader>y "*y
vnoremap <silent> <leader>Y "*Y

" Paste from system clipboard
nnoremap <silent> <leader>,p "*p

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
