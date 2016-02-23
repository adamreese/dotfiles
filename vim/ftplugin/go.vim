setlocal tabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal autoindent
setlocal nolist

" vim-go
let g:go_autodetect_gopath = 1
"let g:go_fmt_command = 'goimports'
let g:go_fmt_fail_silently = 0
let g:go_snippet_engine = "neosnippet"

nmap <Leader>dc  <Plug>(go-doc)
nmap <Leader>s   <Plug>(go-def-split)
nmap <Leader>ce  <Plug>(go-callees)
nmap <Leader>cl  <Plug>(go-callers)
nmap <Leader>cs  <Plug>(go-callstack)
nmap <Leader>d   <Plug>(go-describe)
nmap <Leader>in  <Plug>(go-info)
nmap <Leader>ii  <Plug>(go-implements)
nmap <Leader>r   <Plug>(go-referrers)
nmap <Leader>f   :GoImports<CR>

"let g:syntastic_go_checkers = ['go', 'golint', 'govet', 'errcheck']
"let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
