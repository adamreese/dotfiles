" =======================================================================
" plugin/plug/lightline.vim
" =======================================================================
if !ar#is_loaded('lightline.vim') | finish | endif

scriptencoding utf-8

" set showtabline=2

let g:lightline = {
      \ 'colorscheme': 'ar',
      \   'active': {
      \     'left':  [
      \       ['mode', 'paste'],
      \       ['filename', 'readonly', 'modified'],
      \     ],
      \     'right': [
      \       ['gitbranch'],
      \       ['lineinfo', 'percent', 'filetype'],
      \       ['search', 'lsp', 'go', 'spell'],
      \       ['lint_running', 'lint_error', 'lint_warning', 'lint_info', 'trails'],
      \     ],
      \   },
      \   'inactive': {
      \     'left':  [ ['mode'], [], ['filename', 'modified'] ],
      \     'right': [ ['lineinfo'], ['filetype'] ],
      \   },
      \   'tabline': {
      \     'left':  [['tabs']],
      \     'right': [['cwd']],
      \   },
      \   'tab': {
      \     'active': ['tabnum',],
      \     'inactive': ['tabnum'],
      \   },
      \   'mode_map': {
      \       'n':      'ɴ',
      \       'i':      'ɪ',
      \       'c':      'ᴄᴏᴍᴍᴀɴᴅ',
      \       'R':      'ʀ',
      \       's':      's',
      \       'S':      's',
      \       '\<C-s>': 's',
      \       't':      'ᴛᴇʀᴍɪɴᴀʟ',
      \       'v':      'ᴠ',
      \       'V':      'ᴠ',
      \       "\<C-v>": 'ᴠ',
      \   },
      \   'component_function': {
      \     'cwd':            'status#Directory',
      \     'filename':       'status#Filename',
      \     'filetype':       'status#Filetype',
      \     'gitbranch':      'status#GitBranch',
      \     'go':             'status#Go',
      \     'lint_running':   'status#LintRunning',
      \     'lsp':            'status#CocStatus',
      \     'mode':           'status#Mode',
      \     'modified':       'status#Modified',
      \     'readonly':       'status#Readonly',
      \     'search':         'status#Search',
      \     'percent':        'status#Percent',
      \     'paste':          'status#Paste',
      \   },
      \   'component_expand': {
      \     'lint_error':   'status#LintError',
      \     'lint_warning': 'status#LintWarning',
      \     'lint_info':    'status#LintInfo',
      \     'lineinfo':     'status#Lineinfo',
      \     'trails':       'status#Whitespace',
      \   },
      \   'component_type': {
      \     'lint_error':   'error',
      \     'lint_warning': 'warning',
      \     'lint_info':    'info',
      \     'lint_running': 'warning',
      \     'trails':       'error',
      \   },
      \   'separator': { 'left': '', 'right': '' },
      \   'subseparator': { 'left': '', 'right': '' },
      \ }

function! s:lightline_reload() abort
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction

command! LightlineReload call <SID>lightline_reload()

augroup ar_lightline
  autocmd!
  autocmd ColorScheme * call <SID>lightline_reload()
  autocmd User FzfStatusLine call lightline#update()
augroup END
