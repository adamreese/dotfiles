" =======================================================================
" plugin/plug/vim-qf.vim
" =======================================================================
if !ar#IsInstalled('vim-qf') | finish | endif

let g:qf_auto_open_loclist  = v:false
let g:qf_auto_open_quickfix = v:false
let g:qf_auto_resize        = v:false
let g:qf_mapping_ack_style  = v:false

nmap [l <Plug>(qf_loc_previous)
nmap ]l <Plug>(qf_loc_next)

nmap [q <Plug>(qf_qf_previous)
nmap ]q <Plug>(qf_qf_next)

nmap [e <Plug>(qf_loc_previous)
nmap ]e <Plug>(qf_loc_next)
