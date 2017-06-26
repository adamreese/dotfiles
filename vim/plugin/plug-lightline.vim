" =======================================================================
" plugin/plug-lightline.vim
" =======================================================================

let g:lightline = {
      \ 'colorscheme': 'default',
      \ 'active': {
      \   'left':  [
      \     [ 'mode', 'paste' ], [ 'git_branch' ], [ 'filename' ],
      \   ],
      \   'right': [
      \     [ 'neomake', 'lineinfo' ], [ 'filetype' ], [ 'go', 'ctrlpmark' ],
      \   ]
      \ },
      \ 'inactive': {
      \   'left': [
      \     [ 'filename' ],
      \   ],
      \   'right': [
      \     [ 'lineinfo' ], [ 'filetype' ],
      \   ]
      \ },
      \ 'component_function': {
      \   'git_branch':   'statusline#git_branch',
      \   'filename':     'statusline#filename',
      \   'filetype':     'statusline#filetype',
      \   'mode':         'statusline#mode',
      \   'go':           'statusline#go',
      \   'ctrlpmark':    'statusline#CtrlPMark',
      \ },
      \ 'component_expand': {
      \   'neomake':   'statusline#neomake',
      \   'lineinfo':  'statusline#lineinfo',
      \ },
      \ 'component_type': {
      \   'neomake': 'error',
      \ },
      \ 'subseparator': {
      \   'left': '|',
      \   'right': '|',
      \ },
      \ }

" -----------------------------------------------------------------------
" vim: foldmethod=marker
