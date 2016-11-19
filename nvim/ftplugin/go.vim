setlocal tabstop=4
setlocal shiftwidth=4
setlocal noexpandtab
setlocal autoindent
setlocal nolist

" vim-go
let g:go_fmt_fail_silently = 1
" let g:go_fmt_options = "-s"
let g:go_highlight_build_constraints = 1
let g:go_highlight_error = 1
let g:go_term_enabled = 1
let g:go_term_mode = 'split'
let g:go_def_mode = 'godef'
let g:go_fmt_command = 'goimports'

nmap <buffer> <silent> gd <Plug>(go-def)
nmap <buffer> <silent> gs <Plug>(go-def-split)
nmap <buffer> <silent> gk <Plug>(go-doc)
nmap <buffer> <silent> gV <Plug>(go-vet)
nmap <buffer> <Leader>c   <Plug>(go-coverage-toggle)
nmap <buffer> <Leader>i   <Plug>(go-info)
nmap <buffer> <Leader>f   :GoImports<CR>
nmap <buffer> <Leader>gt  :GoDecls<CR>

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
