augroup filetype
  au! BufRead,BufNewFile *.proto setfiletype proto
augroup end

setlocal tabstop=2
setlocal shiftwidth=2
setlocal noexpandtab
setlocal nolist

let g:tagbar_type_proto = {
    \ 'kinds' : [
        \ 'm:messages',
    \ ]
\}
