" =======================================================================
" plugin/plug-nerdtree.vim
" =======================================================================

" let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeIgnore=['\.git$', '\.zwc$', '\.pyc$', '^BUILD$', '^tags$', '\.old$']
let g:NERDTreeShowHidden=1
let g:NERDTreeMapJumpNextSibling='<Nop>'
let g:NERDTreeMapJumpPrevSibling='<Nop>'
let g:NERDTreeMinimalUI=1

noremap <leader>e :<C-u>NERDTreeFind<CR>
noremap <Leader>n :<C-u>NERDTreeToggle<CR>

" -----------------------------------------------------------------------
" vim: foldmethod=marker

