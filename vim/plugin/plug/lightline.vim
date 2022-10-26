" =======================================================================
" plugin/plug/lightline.vim
" =======================================================================
scriptencoding utf-8

set showtabline=2

let g:lightline = {
      \ 'colorscheme': 'ar',
      \   'active': {
      \     'left':  [
      \       ['mode', 'paste'],
      \       ['gitbranch'],
      \       ['modified', 'filename', 'readonly'],
      \     ],
      \     'right': [
      \       ['percent', 'lineinfo'],
      \       ['filetype'],
      \       ['go', 'spell', 'search', 'neomake'],
      \       ['lsp'],
      \     ],
      \   },
      \   'inactive': {
      \     'left':  [['mode'], ['modified', 'filename']],
      \     'right': [['percent', 'lineinfo'], ['filetype'], ['lsp']],
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
      \     'n':      '◼',
      \     'i':      'ɪ',
      \     'c':      '❯',
      \     'R':      'ʀ',
      \     's':      's',
      \     'S':      's',
      \     '\<C-s>': 's',
      \     't':      'ᴛᴇʀᴍɪɴᴀʟ',
      \     'v':      'ᴠ',
      \     'V':      'ᴠ',
      \     "\<C-v>": 'ᴠ',
      \   },
      \   'component': {
      \     'spell': '%{&spell?"s":""}',
      \     'paste': '%{&paste?"ᴘ":""}',
      \   },
      \   'component_function': {
      \     'cwd':              'status#Directory',
      \     'filename':         'status#Filename',
      \     'filetype':         'status#Filetype',
      \     'gitbranch':        'status#GitBranch',
      \     'go':               'status#Go',
      \     'lsp':              'status#LSPStatus',
      \     'mode':             'status#Mode',
      \     'modified':         'status#Modified',
      \     'readonly':         'status#Readonly',
      \     'search':           'status#Search',
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
  autocmd User LspDiagnosticChange call lightline#update()
augroup END
