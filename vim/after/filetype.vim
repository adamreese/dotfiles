" =======================================================================
" after/filetype.vim
" =======================================================================
if exists('did_load_filetypes_userafter') | finish | endif
let g:did_load_filetypes_userafter = 1

augroup filetypedetect
  autocmd! BufNewFile,BufRead *[Dd]ockerfile\(.vim\)\@!* setfiletype=dockerfile

  autocmd! BufNewFile,BufRead *zsh/*          setfiletype=zsh
  autocmd! BufNewFile,BufRead .envrc          setfiletype=sh
  autocmd! BufNewFile,BufRead Gopkg.lock      setfiletype=toml
  autocmd! BufNewFile,BufRead glide.lock      setfiletype=yaml
augroup END

" -----------------------------------------------------------------------
" vim: foldmethod=marker
