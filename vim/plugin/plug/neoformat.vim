" =======================================================================
" plugin/plug/neoformat.vim
" =======================================================================
if !ar#plug#IsInstalled('neoformat') | finish | endif

let g:neoformat_enabled_json = ['prettier', 'jq']
let g:neoformat_enabled_yaml = ['prettier']

if !mapcheck('<leader>f')
  nnoremap <silent><leader>f :Neoformat<CR>
endif
