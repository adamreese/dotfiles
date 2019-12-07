" =======================================================================
" plugin/plug/deoplete.vim
" =======================================================================
if !ar#is_loaded('deoplete.nvim') | finish | endif

let g:echodoc_enable_at_startup  = 1
let g:deoplete#enable_at_startup = 1
let s:deoplete_custom_option = {
      \ 'auto_complete_delay': 5,
      \ 'auto_refresh_delay': 30,
      \ 'ignore_sources': {
      \   '_': ['around', 'dictionary', 'omni', 'tag'],
      \   'go': ['around', 'dictionary', 'omni', 'tag', 'buffer', 'member'],
      \   'sh': ['around', 'dictionary', 'omni', 'tag'],
      \   'yaml': ['around', 'dictionary', 'omni', 'tag', 'neosnippet'],
      \   'zsh': ['around', 'dictionary', 'omni', 'tag'],
      \ },
      \ 'num_processes': 6,
      \ 'ignore_case': v:true,
      \ 'smart_case': v:true,
      \ }

" deoplete-go
let g:deoplete#sources#go#gocode_binary       = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#package_dot         = 1
let g:deoplete#sources#go#pointer             = 1
let g:deoplete#sources#go#sort_class          = ['func', 'type', 'var', 'const', 'package']
let g:deoplete#sources#go#builtin_objects     = 1
let g:deoplete#sources#go#auto_goos           = 1

" ternjs
let g:deoplete#sources#ternjs#types            = 1
let g:deoplete#sources#ternjs#docs             = 1
let g:deoplete#sources#ternjs#case_insensitive = 1
"Add extra filetypes
let g:deoplete#sources#ternjs#filetypes = [
      \ 'ts',
      \ 'tsx',
      \ 'typescript.tsx',
      \ 'typescript',
      \ 'javascript',
      \ 'jsx',
      \ 'javascript.jsx',
      \ ]

let g:necovim#complete_functions     = get(g:, 'necovim#complete_functions', {})
let g:necovim#complete_functions.Ref = 'ref#complete'

call deoplete#custom#option(s:deoplete_custom_option)

call deoplete#custom#source('_', 'converters', [
      \ 'converter_auto_paren',
      \ 'converter_remove_overlap',
      \ 'converter_truncate_abbr',
      \ 'converter_truncate_menu',
      \ ])

call deoplete#custom#source('omni', 'functions', { 'sh': 'LanguageClient#complete'})

call deoplete#custom#source('go', 'sorters', [])

call deoplete#custom#source('buffer', 'mark', 'buffer')
call deoplete#custom#source('file',   'mark', 'file')
call deoplete#custom#source('go',     'mark', '')
call deoplete#custom#source('omni',   'mark', 'omni')
call deoplete#custom#source('ternjs', 'mark', 'tern')

call deoplete#custom#source('go',         'rank', 9999)
call deoplete#custom#source('ternjs',     'rank', 9999)
call deoplete#custom#source('buffer',     'rank', 0)
call deoplete#custom#source('neosnippet', 'rank', 0)

call deoplete#custom#source('neosnippet', 'disabled_syntaxes', ['goComment'])
call deoplete#custom#source('vim',        'disabled_syntaxes', ['Comment'])

if get(g:, 'enable_debug', 0)
  let g:deoplete#enable_profile = 1
  call deoplete#custom#source('deoplete', 'debug_enabled', 1)
  call deoplete#custom#source('buffer', 'debug_enabled', 1)
  call deoplete#custom#source('core', 'debug_enabled', 1)
  call deoplete#custom#source('go', 'debug_enabled', 1)
  call deoplete#enable_logging('DEBUG', g:cache_dir . '/deoplete.log')
endif

inoremap <expr><C-g> deoplete#refresh()
