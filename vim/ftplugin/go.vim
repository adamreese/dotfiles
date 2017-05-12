" =======================================================================
" ftplugin/go.vim
" =======================================================================
scriptencoding utf-8

setlocal tabstop=4
setlocal shiftwidth=4
setlocal noexpandtab
setlocal autoindent
setlocal listchars=tab:\ \ ,extends:⟫,precedes:⟪,nbsp:␣,trail:·

" vim-go
let g:go_def_mode = 'godef'
let g:go_fmt_command = 'goimports'
" let g:go_fmt_options = "-s"
let g:go_fmt_fail_silently = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_error = 1
let g:go_snippet_engine = 'neosnippet'
let g:go_term_enabled = 1
let g:go_term_mode = 'split'

nmap <buffer> <silent> K  <Plug>(go-doc)
nmap <buffer> <silent> gd <Plug>(go-def)
nmap <buffer> <silent> gs <Plug>(go-def-split)
nmap <buffer> <silent> gV <Plug>(go-vet)

nmap <buffer> <localleader>tc  <Plug>(go-coverage-toggle)
nmap <buffer> <localleader>i   <Plug>(go-info)
nmap <buffer> <localleader>f   :<C-u>GoImports<CR>
nmap <buffer> <localleader>gt  :<C-u>GoDecls<CR>

command! -bang AS call go#alternate#Switch(<bang>0, 'split')

let g:tagbar_type_go = {
      \ 'ctagstype' : 'go',
      \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
      \ ],
      \ 'sro' : '.',
      \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
      \ },
      \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
      \ },
      \ 'ctagsbin'  : 'gotags',
      \ 'ctagsargs' : '-sort -silent'
      \ }

let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck', 'deadcode', 'unconvert']
let g:neomake_go_enabled_makers = ['go', 'govet']
