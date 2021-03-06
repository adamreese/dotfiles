" =======================================================================
" plugin/plug/nerdtree.vim
" =======================================================================
scriptencoding utf-8

let g:NERDTreeAutoDeleteBuffer    = v:true
let g:NERDTreeHighlightCursorline = v:false
let g:NERDTreeIgnore              = ['^\.git$', '\.zwc$', '\.pyc$', '^BUILD$[[file]]', '^tags$[[file]]', '\.old$']
let g:NERDTreeMapJumpNextSibling  = '<Nop>'
let g:NERDTreeMapJumpPrevSibling  = '<Nop>'
let g:NERDTreeMinimalUI           = v:true
let g:NERDTreeRespectWildIgnore   = v:true
let g:NERDTreeShowHidden          = v:true
let g:NERDTreeStatusline          = -1

nnoremap <silent><leader>e :NERDTreeFind<CR>
nnoremap <silent><leader>n :call NERDTreeFindOrClose()<CR>

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
