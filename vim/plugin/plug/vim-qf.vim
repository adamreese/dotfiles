" =======================================================================
" plugin/plug/vim-qf.vim
" =======================================================================
if !ar#is_plugged('vim-qf') | finish | endif

let g:qf_auto_open_loclist  = 0
let g:qf_auto_open_quickfix = 0
let g:qf_auto_resize        = 0
let g:qf_mapping_ack_style  = 1
let g:qf_resize_min_height  = 4

nmap <leader>tl <Plug>qf_loc_toggle

nmap [l <Plug>qf_loc_previous
nmap ]l <Plug>qf_loc_next

nmap [q <Plug>qf_qf_previous
nmap ]q <Plug>qf_qf_next

nmap [e <Plug>qf_loc_previous
nmap ]e <Plug>qf_loc_next

" Modeline {{{1
" -----------------------------------------------------------------------
" vim: foldmethod=marker

