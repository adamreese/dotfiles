" =======================================================================
" plugin/plug/anzu.vim
" =======================================================================
if !ar#IsLoaded('vim-anzu') | finish | endif

" Default "%p(%i/%l)"
let g:anzu_status_format = '[%i/%l]'

silent! unmap n
silent! unmap N
silent! unmap *
silent! unmap #

nmap n <Plug>(anzu-n)zzzv
nmap N <Plug>(anzu-N)zzzv
nmap * <Plug>(anzu-star)zzzv
nmap # <Plug>(anzu-sharp)zzzv

" Remove search highlight
nmap <silent><leader><CR> :<C-u>nohlsearch<CR><Plug>(anzu-clear-search-status)
