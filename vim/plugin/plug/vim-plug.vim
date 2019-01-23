" =======================================================================
" plugin/plug/vim-plug.vim
" =======================================================================

let g:plug_pwindow = 'vertical rightbelow new'
let g:plug_window  = 'tabnew'

" Plug Upgrade and Update
command! PU source $MYVIMRC | PlugUpgrade | PlugUpdate

" Modeline {{{1
" -----------------------------------------------------------------------
" vim: foldmethod=marker

