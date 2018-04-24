" =======================================================================
" plugin/plug/deoplete.vim
" =======================================================================
if !ar#is_loaded('deoplete.nvim') | finish | endif

let g:echodoc_enable_at_startup = 1

let g:deoplete#auto_complete_delay        = 0
let g:deoplete#auto_refresh_delay         = 100
let g:deoplete#enable_at_startup          = 1
let g:deoplete#file#enable_buffer_path    = 1
let g:deoplete#max_abbr_width             = 0
let g:deoplete#max_menu_width             = 0

" go
let g:deoplete#sources#go#align_class    = 1
let g:deoplete#sources#go#gocode_binary  = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#json_directory = g:cache_dir . 'deoplete/go/darwin_amd64'
let g:deoplete#sources#go#package_dot    = 1
let g:deoplete#sources#go#pointer        = 1
let g:deoplete#sources#go#sort_class     = ['func', 'type', 'var', 'const', 'package']
let g:deoplete#sources#go#use_cache      = 0

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

let g:deoplete#ignore_sources            = get(g:, 'deoplete#ignore_sources', {})
let g:deoplete#ignore_sources._          = ['around']
let g:deoplete#ignore_sources.go         = ['buffer', 'dictionary', 'member', 'omni', 'tag', 'syntax', 'around']
let g:deoplete#ignore_sources.javascript = ['omni']
let g:deoplete#ignore_sources.gitcommit  = ['neosnippet']

function! s:init() abort
  if get(g:, 'enable_debug', 0)
    let g:deoplete#enable_profile = 1
    call deoplete#custom#source('deoplete', 'debug_enabled', 1)
    call deoplete#custom#source('buffer', 'debug_enabled', 1)
    call deoplete#custom#source('core', 'debug_enabled', 1)
    call deoplete#custom#source('go', 'debug_enabled', 1)
    call deoplete#enable_logging('DEBUG', g:cache_dir . 'deoplete.log')
  endif

  call deoplete#custom#source('_', 'converters', [
        \ 'converter_auto_paren',
        \ 'converter_remove_overlap',
        \ 'converter_truncate_abbr',
        \ 'converter_truncate_menu',
        \ ])

  call deoplete#custom#source('_', 'min_pattern_length', 1)
  call deoplete#custom#source('_', 'matchers', ['matcher_fuzzy'])

  call deoplete#custom#source('go', 'sorters', [])

  call deoplete#custom#source('buffer', 'mark', 'buffer')
  call deoplete#custom#source('file',   'mark', 'file')
  call deoplete#custom#source('go',     'mark', '')
  call deoplete#custom#source('omni',   'mark', 'omni')
  call deoplete#custom#source('ternjs', 'mark', 'tern')

  call deoplete#custom#source('go',     'rank', 9999)
  call deoplete#custom#source('ternjs', 'rank', 9999)

  call deoplete#custom#source('neosnippet', 'disabled_syntaxes', ['goComment'])
  call deoplete#custom#source('vim',        'disabled_syntaxes', ['Comment'])

endfunction

augroup vimrc_deoplete
  autocmd!
  autocmd VimEnter * try | call s:init() | catch | endtry
augroup END

" Modeline {{{1
" -----------------------------------------------------------------------
" vim: foldmethod=marker

