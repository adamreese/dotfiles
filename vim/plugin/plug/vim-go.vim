" =======================================================================
" plugin/plug/vim-go.vim
" =======================================================================
if !ar#is_loaded('vim-go') | finish | endif

" Settings
" -----------------------------------------------------------------------

let g:go_def_mode = 'godef'
let g:go_fmt_command = 'goimports'
let g:go_fmt_fail_silently = 1
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck', 'deadcode', 'unconvert']
let g:go_snippet_engine = 'neosnippet'
let g:go_term_enabled = 1
let g:go_term_mode = 'split'

" Extra highlights
let g:go_highlight_build_constraints = 1
let g:go_highlight_error = 1

" Mappings
" -----------------------------------------------------------------------

nmap <silent>gs     <Plug>(go-def-split)

nmap <leader>tc     <Plug>(go-coverage-toggle)
nmap <leader>i      <Plug>(go-info)
nmap <leader>f      :<C-u>GoImports<CR>
nmap <leader>gt     :<C-u>GoDecls<CR>
nmap <leader>gl     :<C-u>Neomake gometalinter<CR>

command! -bang A  call go#alternate#Switch(<bang>0, 'edit')
command! -bang AS call go#alternate#Switch(<bang>0, 'split')
command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')

" -----------------------------------------------------------------------
" vim: foldmethod=marker

