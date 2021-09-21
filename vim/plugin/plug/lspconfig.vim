" =======================================================================
" plugin/plug/lspconfig.vim
" =======================================================================
scriptencoding utf-8

if !ar#plug#IsLoaded('nvim-lspconfig') | finish | endif

let s:cpo_save = &cpoptions
set cpoptions&vim

" go get golang.org/x/tools/gopls@latest
"
" npm install -g bash-language-server
" npm install -g dockerfile-language-server-nodejs
" npm install -g graphql-language-service-cli
" npm install -g typescript-language-server
" npm install -g vim-language-server
" npm install -g vscode-json-languageserver
" npm install -g yaml-language-server
"
" pip install python-language-server
"
" https://github.com/sumneko/lua-language-server

function! s:format() abort
  if get(b:, 'lsp_formatting')
    lua vim.lsp.buf.formatting()
  else
    Neoformat
  endif
endfunction

lua require('ar.lsp')

nnoremap <silent><leader>f call s:format()

if ar#plug#IsLoaded('nvim-cmp')
  lua require('ar.cmp')
endif

" -----------------------------------------------------------------------
let &cpoptions = s:cpo_save
unlet s:cpo_save
