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

