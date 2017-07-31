" =======================================================================
" plugin/plug-ctrlp.vim
" =======================================================================
if !ar#is_loaded('ctrlp.vim') | finish | endif

noremap <leader>gb :<C-u>CtrlPBuffer<CR>
noremap <leader>gt :<C-u>CtrlPBufTag<CR>
noremap <leader>ev :<C-u>execute 'CtrlP ' . g:vim_dir<CR>

if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -i --nogroup -l --nocolor --hidden --ignore ''BUILD'' --ignore ''_output'' -g ""'
endif

" ag is fast enough that CtrlP doesn't need to cache
let g:ctrlp_use_caching = 0

" Set no file limit, we are building a big project
let g:ctrlp_max_files = 0

" Use python fuzzy matcher for better performance
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

let g:ctrlp_buftag_types = {'go' : '--language-force=go --golang-types=ft'}

" -----------------------------------------------------------------------
" vim: foldmethod=marker
