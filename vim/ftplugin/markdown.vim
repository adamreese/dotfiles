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

let g:vim_markdown_fenced_languages = [
      \ 'bash=sh',
      \ 'erb=eruby',
      \ 'js=javascript',
      \ 'less=css',
      \ 'zsh=sh',
      \ ]
