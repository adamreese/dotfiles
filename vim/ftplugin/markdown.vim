" =======================================================================
" ftplugin/mardown.vim
" =======================================================================

" Enable spellchecking
setlocal spell

" Automatically wrap at 80 characters
setlocal textwidth=80

setlocal nofoldenable

setlocal conceallevel=0

let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:Heading_L1',
        \ 'i:Heading_L2',
        \ 'k:Heading_L3'
    \ ]
    \ }
