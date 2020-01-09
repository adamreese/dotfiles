" =======================================================================
" plugin/plug/vista.vim
" =======================================================================
scriptencoding utf-8

if !ar#is_installed('vista.vim') | finish | endif

nmap <leader>v :Vista!!<CR>

let g:vista_ctags_cmd            = {'go': 'gotags -sort -silent'}
let g:vista_echo_cursor_strategy = 'both'
let g:vista_fzf_preview          = ['right:50%']
let g:vista_icon_indent          = ['▸ ','']
let g:vista_sidebar_width        = 40
let g:vista_stay_on_open         = 0

let g:vista_executive_for = {
      \ 'javascript':     'coc',
      \ 'javascript.jsx': 'coc',
      \ 'markdown':       'toc',
      \ 'rust':           'coc',
      \ 'typescript':     'coc',
      \ }
