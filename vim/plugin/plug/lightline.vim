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
      \     [ 'mode', 'paste' ], [ 'git_branch' ], [ 'filename', 'gitgutter' ],
      \   ],
      \   'right': [
      \     [ 'lint_error', 'lint_warning', 'lint_info', 'lineinfo' ], [ 'filetype' ], [ 'search', 'go' ],
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
      \   'gitgutter':     'statusline#gitgutter',
      \   'filename':      'statusline#filename',
      \   'filetype':      'statusline#filetype',
      \   'mode':          'statusline#mode',
      \   'search':        'statusline#search',
      \   'go':            'statusline#go',
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
