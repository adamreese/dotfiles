" =======================================================================
" after/filetype.vim
" =======================================================================
if exists('did_load_filetypes_userafter') | finish | endif
let g:did_load_filetypes_userafter = 1

augroup filetypedetect
  autocmd! BufNewFile,BufRead *[Dd]ockerfile\(.vim\)\@!* setlocal filetype=dockerfile

  autocmd! BufNewFile,BufRead *zsh/* setlocal filetype=zsh
augroup END

" -----------------------------------------------------------------------
" vim: foldmethod=marker
