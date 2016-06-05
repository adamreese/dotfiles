setlocal tabstop=4
setlocal shiftwidth=4
setlocal noexpandtab
setlocal autoindent
setlocal nolist

" vim-go
let g:go_fmt_fail_silently = 1
let g:go_fmt_options = "-s"
let g:go_highlight_build_constraints = 1
let g:go_highlight_error = 1
let g:go_list_type = "locationlist"
let g:go_snippet_engine = "ultisnips"
let g:go_term_enabled = 1
let g:go_term_mode = "split"

nmap <buffer> <silent> gd <Plug>(go-def)
nmap <buffer> <silent> gs <Plug>(go-def-split)
nmap <buffer> <silent> gk <Plug>(go-doc)
nmap <buffer> <silent> gV <Plug>(go-vet)

nmap <buffer> <Leader>ce  <Plug>(go-callees)
nmap <buffer> <Leader>cl  <Plug>(go-callers)
nmap <buffer> <Leader>cs  <Plug>(go-callstack)
nmap <buffer> <Leader>d   <Plug>(go-describe)
nmap <buffer> <Leader>in  <Plug>(go-info)
nmap <buffer> <Leader>ii  <Plug>(go-implements)
nmap <buffer> <Leader>r   <Plug>(go-referrers)
nmap <buffer> <Leader>f   :GoImports<CR>
nmap <buffer> <Leader>i   :GoImport<space>

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
let g:syntastic_go_checkers = ['go', 'govet']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }