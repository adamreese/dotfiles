" =======================================================================
" plugin/plug/lightline.vim
" =======================================================================
if !ar#IsLoaded('lightline.vim') | finish | endif

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
      \     'n':      'ɴ',
      \     'i':      'ɪ',
      \     'c':      'ᴄᴏᴍᴍᴀɴᴅ',
      \     'R':      'ʀ',
      \     's':      's',
      \     'S':      's',
      \     '\<C-s>': 's',
      \     't':      'ᴛᴇʀᴍɪɴᴀʟ',
      \     'v':      'ᴠ',
      \     'V':      'ᴠ',
      \     "\<C-v>": 'ᴠ',
      \   },
      \   'component_function': {
      \     'cwd':            'status#Directory',
      \     'filename':       'status#Filename',
      \     'filetype':       'status#Filetype',
      \     'gitbranch':      'status#GitBranch',
      \     'go':             'status#Go',
      \     'lineinfo':       'status#Lineinfo',
      \     'lint_running':   'status#LintRunning',
      \     'lsp':            'status#CocStatus',
      \     'mode':           'status#Mode',
      \     'modified':       'status#Modified',
      \     'paste':          'status#Paste',
      \     'percent':        'status#Percent',
      \     'readonly':       'status#Readonly',
      \     'search':         'status#Search',
      \     'spell':          'status#Spell',
      \     'trails':         'status#Whitespace',
      \   },
      \   'component_expand': {
      \     'lint_error':   'status#LintError',
      \     'lint_warning': 'status#LintWarning',
      \     'lint_info':    'status#LintInfo',
      \   },
      \   'component_type': {
      \     'lint_error':   'error',
      \     'lint_warning': 'warning',
      \     'lint_info':    'info',
      \   },
      \   'separator': { 'left': '', 'right': '' },
      \   'subseparator': { 'left': '', 'right': '' },
      \ }


function! s:LightlineReload() abort
  call lightline#init()
  call lightline#colorscheme()
  call lightline#update()
endfunction

command! LightlineReload call <SID>LightlineReload()

augroup ar_lightline
  autocmd!
  autocmd User FzfStatusLine call lightline#update()
augroup END
