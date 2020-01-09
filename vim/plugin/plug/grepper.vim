" =======================================================================
" plugin/plug/grepper.vim
" =======================================================================
if !ar#is_loaded('vim-grepper') | finish | endif

nnoremap <Leader>g :Grepper<CR>
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

" nnoremap <Leader>a :Grepper -tool ag<CR>
" nnoremap <Leader>a* :Grepper -tool ag -cword -noprompt<CR>
