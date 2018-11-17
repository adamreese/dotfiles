" =======================================================================
" ftplugin/mardown.vim
" =======================================================================

" Enable spellchecking
setlocal spell

" Automatically wrap at 80 characters
setlocal textwidth=80
setlocal colorcolumn=+3

setlocal nofoldenable

setlocal conceallevel=0

let g:markdown_fenced_languages = [
      \ 'bash=sh',
      \ 'css',
      \ 'erb=eruby',
      \ 'html',
      \ 'javascript',
      \ 'js=javascript',
      \ 'json=json',
      \ 'less=css',
      \ 'python',
      \ 'ruby',
      \ 'sass',
      \ 'scss=sass',
      \ 'sh',
      \ 'stylus=css',
      \ 'vim',
      \ 'xml',
      \ 'zsh=sh',
      \ ]


let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:Heading_L1',
        \ 'i:Heading_L2',
        \ 'k:Heading_L3'
    \ ]
    \ }

" Modeline {{{1
" -----------------------------------------------------------------------
" vim: foldmethod=marker

