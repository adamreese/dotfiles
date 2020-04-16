" =======================================================================
" plugin/plug/neoformat.vim
" =======================================================================
if !ar#IsInstalled('neoformat') | finish | endif

let g:neoformat_enabled_json = ['prettier', 'jq']
let g:neoformat_enabled_yaml = ['prettier']

nnoremap <silent><leader>f :Neoformat<CR>
