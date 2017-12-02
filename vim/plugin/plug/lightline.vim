" =======================================================================
" plugin/plug/lightline.vim
" =======================================================================
if !ar#is_loaded('lightline.vim') | finish | endif

let g:lightline_readonly_filetypes      = ['help', 'man', 'nerdtree', 'qf', 'tagbar']
let g:lightline_mode_filetypes          = ['fzf', 'help', 'man', 'nerdtree', 'tagbar', 'qf']
let g:lightline_no_lineinfo_filetypes   = ['fzf', 'tagbar']
let g:lightline_no_fileformat_filetypes = ['fzf', 'help', 'man', 'nerdtree', 'tagbar', 'qf']
let g:lightline_no_filename_filetypes   = ['fzf', 'nerdtree', 'tagbar', 'qf']

let g:lightline = {
      \ 'active': {
      \   'left':  [
      \     [ 'mode', 'paste' ], [ 'git_branch' ], [ 'filename' ],
      \   ],
      \   'right': [
      \     [ 'lint_error', 'lint_warning', 'lint_info', 'lineinfo' ], [ 'filetype' ], [ 'search', 'go', 'ctrlp_mark' ],
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
      \   'git_branch':    'statusline#git_branch',
      \   'filename':      'statusline#filename',
      \   'filetype':      'statusline#filetype',
      \   'mode':          'statusline#mode',
      \   'search':        'statusline#search',
      \   'go':            'statusline#go',
      \   'ctrlp_mark':    'statusline#ctrlp_mark',
      \ },
      \ 'component_expand': {
      \   'lint_error':   'statusline#neomake_error',
      \   'lint_warning': 'statusline#neomake_warning',
      \   'lint_info':    'statusline#neomake_info',
      \   'lineinfo':     'statusline#lineinfo',
      \ },
      \   'component_type': {
      \   'lint_error':   'error',
      \   'lint_warning': 'warning',
      \   'lint_info':    'warning',
      \ },
      \ 'separator':    { 'left': "\ue0b8", 'right': "\ue0ba"},
      \ 'subseparator': { 'left': '|', 'right': '|' },
      \ }

let g:tagbar_status_func = 'statusline#tagbar_status'

augroup lightline_neovim
  autocmd!
  autocmd User NeomakeCountsChanged call lightline#update()
augroup END

" Modeline {{{1
" -----------------------------------------------------------------------
" vim: foldmethod=marker
