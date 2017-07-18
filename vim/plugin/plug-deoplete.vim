" =======================================================================
" plugin/plug-deoplete.vim
" =======================================================================
if !has_key(g:plugs, 'deoplete.nvim') | finish | endif

let s:enable_debug = 0

let g:echodoc_enable_at_startup = 1

let g:deoplete#enable_at_startup          = 1
let g:deoplete#auto_complete_delay        = 0
" let g:deoplete#auto_complete_delay        = 50
" let g:deoplete#auto_complete_start_length = 1
let g:deoplete#auto_refresh_delay         = 100
let g:deoplete#file#enable_buffer_path    = 1
let g:deoplete#max_abbr_width             = 0
let g:deoplete#max_menu_width             = 0

let g:deoplete#sources#go#align_class    = 1
let g:deoplete#sources#go#gocode_binary  = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#json_directory = g:cache_dir . 'deoplete/go/darwin_amd64'
let g:deoplete#sources#go#package_dot    = 1
let g:deoplete#sources#go#pointer        = 1
let g:deoplete#sources#go#sort_class     = ['func', 'type', 'var', 'const', 'package']
let g:deoplete#sources#go#use_cache      = 0

let g:necovim#complete_functions     = get(g:, 'necovim#complete_functions', {})
let g:necovim#complete_functions.Ref = 'ref#complete'

let g:deoplete#ignore_sources    = get(g:, 'deoplete#ignore_sources', {})
let g:deoplete#ignore_sources._  = ['around', 'neosnippet']
let g:deoplete#ignore_sources.go = ['buffer', 'dictionary', 'member', 'omni', 'tag', 'syntax', 'around']

if s:enable_debug
  call deoplete#custom#set('deoplete', 'debug_enabled', 1)
  call deoplete#custom#set('buffer', 'debug_enabled', 0)
  call deoplete#custom#set('core', 'debug_enabled', 1)
  call deoplete#custom#set('go', 'debug_enabled', 1)
  call deoplete#enable_logging('DEBUG', g:cache_dir . 'deoplete.log')
endif

call deoplete#custom#set('_', 'converters', [
      \ 'converter_auto_paren',
      \ 'converter_remove_overlap',
      \ 'converter_truncate_abbr',
      \ 'converter_truncate_menu',
      \ ])
call deoplete#custom#set('_', 'matchers', ['matcher_fuzzy'])
call deoplete#custom#set('go', 'sorters', [])

call deoplete#custom#set('go', 'mark', '')
call deoplete#custom#set('buffer', 'mark', 'buffer')
call deoplete#custom#set('omni', 'mark', 'omni')
call deoplete#custom#set('file', 'mark', 'file')

call deoplete#custom#set('go', 'rank', 9999)

call deoplete#custom#set('neosnippet', 'disabled_syntaxes', ['goComment'])"
call deoplete#custom#set('vim', 'disabled_syntaxes', ['Comment'])

" -----------------------------------------------------------------------
" vim: foldmethod=marker

