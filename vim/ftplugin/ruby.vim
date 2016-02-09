setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab
setlocal autoindent

" vim-rspec
let g:rspec_runner = "os_x_iterm2"
let g:rspec_command = "br {spec}"
map <Bslash>t :call RunCurrentSpecFile()<CR>
map <Bslash>s :call RunNearestSpec()<CR>
map <Bslash>l :call RunLastSpec()<CR>
map <Bslash>a :call RunAllSpecs()<CR>
