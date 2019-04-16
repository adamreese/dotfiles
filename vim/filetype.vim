" =======================================================================
" filetype.vim
" =======================================================================
if exists('did_load_filetypes') | finish | endif

augroup filetypedetect
  autocmd! BufNewFile,BufRead *[Dd]ockerfile\(.vim\)\@!* setfiletype dockerfile

  autocmd! BufNewFile,BufRead *zsh/*          setfiletype zsh
  autocmd! BufNewFile,BufRead .envrc          setfiletype sh

  autocmd! BufNewFile,BufRead Gopkg.lock      setfiletype toml
  autocmd! BufNewFile,BufRead glide.lock      setfiletype yaml
  autocmd! BufNewFile,BufRead go.mod          setfiletype gomod
  autocmd! BufNewFile,BufRead go.sum          setfiletype text
augroup END

" -----------------------------------------------------------------------
" vim: foldmethod=marker