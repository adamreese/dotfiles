" =======================================================================
" plugin/plug/neoformat.vim
" =======================================================================
if !ar#plug#IsInstalled('neoformat') | finish | endif

" Enable alignment globally
let g:neoformat_basic_format_align = 1

let g:neoformat_enabled_json = ['prettier', 'jq']
let g:neoformat_enabled_yaml = ['prettier']
let g:neoformat_enabled_lua = ['stylua', 'luafmt']

let g:neoformat_lua_stylua = {
      \ 'exe': 'stylua',
      \ 'args': [ '--config-path', '~/.config/stylua/stylua.toml', '-' ],
      \ 'stdin': 1,
      \ }

let g:neoformat_lua_luafmt = {
      \ 'exe': 'luafmt',
      \ 'args': ['--indent-count', '2', '--stdin'],
      \ 'stdin': 1,
      \ }

let g:neoformat_hcl_hclfmt = {'exe': 'hclfmt'}
let g:neoformat_enabled_hcl = ['hclfmt']

let g:neoformat_nomad_hclfmt = {'exe': 'hclfmt'}
let g:neoformat_enabled_nomad = ['hclfmt']

if !mapcheck('<leader>f')
  nnoremap <silent><leader>f :Neoformat<CR>
endif
