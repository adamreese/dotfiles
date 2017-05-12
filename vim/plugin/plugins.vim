" =======================================================================
" plugin/plugins.vim
" =======================================================================
scriptencoding utf-8

" Plugin: neomake {{{
" -----------------------------------------------------------------------

let g:neomake_enable = 1
let g:neomake_warning_sign = { 'text': '❯', 'texthl': 'WarningMsg' }
let g:neomake_error_sign   = { 'text': '❯', 'texthl': 'ErrorMsg'   }

function! s:neomake_run() "{{{
  if &buftype ==# 'nofile' | return | endif

  let l:filetypes = [
        \ 'css', 'go', 'html', 'json', 'markdown',
        \ 'ruby', 'sh', 'vim', 'yaml' ]
  if g:neomake_enable && index(l:filetypes, &filetype) > -1
    Neomake
  endif
endfunction "}}}

augroup vimrc_neomake
  autocmd!
  autocmd  BufWritePost * call <SID>neomake_run()
augroup END

" }}}
" Plugin: deoplete {{{
" -----------------------------------------------------------------------

if has_key(g:plugs, 'deoplete.nvim')
  let s:enable_debug = 0

  let g:echodoc_enable_at_startup=1

  let g:deoplete#enable_at_startup          = 1
  let g:deoplete#auto_complete_delay        = 50
  let g:deoplete#auto_complete_start_length = 1
  let g:deoplete#file#enable_buffer_path    = 1
  let g:deoplete#max_abbr_width             = 0
  let g:deoplete#max_menu_width             = 0

  let g:deoplete#sources#go#align_class    = 1
  let g:deoplete#sources#go#gocode_binary  = $GOPATH.'/bin/gocode'
  let g:deoplete#sources#go#json_directory = $CACHEDIR.'/deoplete/go/darwin_amd64'
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
    call deoplete#enable_logging('DEBUG', $CACHEDIR.'/deoplete.log')
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

  imap <expr><C-k> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : ""
  smap <expr><C-k> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : ""
  set isfname-==

  if has('conceal')
    set conceallevel=2 concealcursor=niv
  endif
endif

" }}}
" Plugin: vim-easy-align {{{
" -----------------------------------------------------------------------

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" }}}
" Plugin: vim-align {{{
" -----------------------------------------------------------------------

noremap  <leader>ah :<C-u>Align =><CR>
nnoremap <leader>a= :<C-u>Align =<CR>
noremap  <leader>a# :<C-u>Align #<CR>
noremap  <leader>a{ :<C-u>Align {<CR>

" }}}
" Plugin: ctrlp {{{
" -----------------------------------------------------------------------

noremap <leader>gb :<C-u>CtrlPBuffer<CR>
noremap <leader>gt :<C-u>CtrlPBufTag<CR>
noremap <leader>gv :<C-u>CtrlP $VIMDIR<CR>

" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
let g:ctrlp_user_command = 'ag %s -i --nogroup -l --nocolor --hidden --ignore ''BUILD'' --ignore ''_output'' -g ""'

" ag is fast enough that CtrlP doesn't need to cache
let g:ctrlp_use_caching = 0

" Set no file limit, we are building a big project
let g:ctrlp_max_files = 0

" Use python fuzzy matcher for better performance
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }

let g:ctrlp_buftag_types = {'go' : '--language-force=go --golang-types=ft'}

" }}}
" Plugin: nerdtree {{{
" -----------------------------------------------------------------------

let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeIgnore=['\.git$', '\.gitignore', '\.zwc', '^BUILD$']
let g:NERDTreeShowHidden=1
let g:NERDTreeMapJumpNextSibling='<Nop>'
let g:NERDTreeMapJumpPrevSibling='<Nop>'
let g:NERDTreeMinimalUI=1

noremap <leader>e :<C-u>NERDTreeFind<CR>
noremap <Leader>n :<C-u>NERDTreeToggle<CR>

" }}}
" Plugin: tagbar {{{
" -----------------------------------------------------------------------

noremap <leader>tt :<C-u>TagbarToggle<CR>

" }}}
" Plugin: ag {{{
" -----------------------------------------------------------------------

if executable('ag')
  let &grepprg='ag --nocolor --nogroup --hidden --vimgrep'
  let g:ag_prg='ag --nocolor --nogroup --hidden --column'

  noremap <leader>a  :<C-u>Ag<space>
  noremap <leader>a* :<C-u>call SearchWordWithAg()<CR>

  function! SearchWordWithAg()
    execute 'Ag' expand('<cword>')
  endfunction
endif

" }}}
" Plugin: fzf {{{
" -----------------------------------------------------------------------

if has('nvim')
  let $FZF_DEFAULT_OPTS .= ' --inline-info'
endif

if !has('nvim') && $TERM_PROGRAM ==# 'iTerm.app'
  let g:fzf_launcher = 'vim-fzf'
endif

let g:fzf_nvim_statusline = 0

nnoremap <silent> <leader>t :<C-u>FZF<CR>
nnoremap <silent> <c-b>     :<C-u>Buffers<CR>

" }}}
" Plugin: delimitmate {{{
" -----------------------------------------------------------------------

let g:delimitMate_expand_cr    = 1
let g:delimitMate_expand_space = 1
let g:delimitMate_smart_quotes = 1

" }}}
" Plugin: incsearch {{{
" -----------------------------------------------------------------------

map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" }}}
" Plugin: quick-scope {{{
" -----------------------------------------------------------------------

let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" }}}
" Plugin: committia.vim {{{
" -----------------------------------------------------------------------

let g:committia_open_only_vim_starting  = 0
let g:committia_use_singlecolumn        = 'always'

" }}}
" Plugin: gitgutter {{{
" -----------------------------------------------------------------------

let g:gitgutter_enabled = get(g:, 'gitgutter_enabled', 0)

let g:gitgutter_sign_added            = '▏'
let g:gitgutter_sign_modified         = '▏'
let g:gitgutter_sign_removed          = '▏'
let g:gitgutter_sign_modified_removed = '║'

nnoremap <leader>tgg :<C-u>GitGutterToggle<CR>

" }}}
" Plugin: lightline {{{
" -----------------------------------------------------------------------

let g:lightline = {
      \ 'colorscheme': 'default',
      \ 'active': {
      \   'left':  [
      \     [ 'mode', 'paste' ], [ 'fugitive' ], [ 'filename' ],
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
      \   'fugitive':     'statusline#fugitive',
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

" }}}
" -----------------------------------------------------------------------
" vim: foldmethod=marker
