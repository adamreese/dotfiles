" =======================================================================
" plugin/plug-nerdtree.vim
" =======================================================================

" let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeAutoDeleteBuffer    = 1
let g:NERDTreeHighlightCursorline = 0
let g:NERDTreeIgnore              = ['^\.git$', '\.zwc$', '\.pyc$', '^BUILD$', '^tags$', '\.old$']
let g:NERDTreeMapJumpNextSibling  = '<Nop>'
let g:NERDTreeMapJumpPrevSibling  = '<Nop>'
let g:NERDTreeMinimalUI           = 1
let g:NERDTreeRespectWildIgnore   = 1
let g:NERDTreeShowHidden          = 1

noremap <silent><leader>e :NERDTreeFind<CR>
noremap <silent><leader>n :call NERDTreeFindOrClose()<CR>

" Run NERDTreeFind or Toggle based on current buffer
function! NERDTreeFindOrClose() abort
  if exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1
    NERDTreeClose
  elseif bufname('%') ==# ''
    NERDTree
  else
    NERDTreeFind
  endif
endfunction

" -----------------------------------------------------------------------
" vim: foldmethod=marker

