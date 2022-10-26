" =======================================================================
" autoload/status.vim
" =======================================================================
scriptencoding utf-8

" -----------------------------------------------------------------------
" Symbol {{{1

" A list of prefix characters used for a variety of components
let s:symbol = {
      \ 'cwd':        'ᴄᴡᴅ',
      \ 'list':       '☰ ',
      \ 'modified':   '+',
      \ 'no ft':      'ɴᴏᴏᴘ',
      \ 'paste':      'ᴘ',
      \ 'spell':      's',
      \ 'readonly':   'ʀᴏ',
      \ 'spinner':    '…',
      \ 'unnamed':    'ᴜɴɴᴀᴍᴇᴅ',
      \ 'whitespace': 'ᴡ',
      \ }

" Get the symbol for a given component
function! s:symbol.for(name, ...) dict abort
  let l:sym = get(l:self, a:name, a:name)
  return s:Concat(extend([l:sym], a:000))
endfunction

" -----------------------------------------------------------------------

let s:filetype_modes = {
      \ 'fugitiveblame': 'Blame',
      \ 'fzf':           'FZF',
      \ 'gitcommit':     'Commit Message',
      \ 'godoc':         'GoDoc',
      \ 'help':          'Help',
      \ 'nerdtree':      'NERDTree',
      \ 'qf':            s:symbol.for('list', 'Quickfix'),
      \ 'tagbar':        'Tagbar',
      \ 'vim-plug':      'Plugin',
      \ 'list':          'List',
      \ }

" -----------------------------------------------------------------------
" Filename {{{1

function! status#Filename() abort
  let l:bufname = bufname('%')
  let l:ft = s:BufferType()

  if &previewwindow
    return '[Preview]'
  elseif l:ft ==# 'fzf'
    return ''
  elseif l:ft ==# 'qf'
    return s:QuickfixText()
  elseif l:ft ==# 'tagbar'
    return ''
  elseif l:ft ==# 'list'
    return l:bufname
  elseif l:ft ==# 'help'
    return  fnamemodify(l:bufname, ':t')
  elseif l:ft ==# 'terminal'
    return get(b:, 'term_title', l:bufname)
  elseif l:ft ==# 'nofile'
    return ''
  endif

  if s:IsCustomMode() | return '' | endif

  let l:path = expand('%:~:.')
  if strlen(l:path) == 0
    return s:symbol.for('unnamed')
  endif
  return s:FormatPath(l:path)
endfunction

function! s:FormatPath(path) abort
  let l:max = winwidth(0) * 0.75
  if strlen(a:path) < l:max
    return a:path
  endif

  return pathshorten(a:path)
endfunction

function! s:QuickfixText() abort
  let l:title = get(w:, 'quickfix_title', '')
  return trim(substitute(l:title, &grepprg, 'grep', ''))
endfunction

" -----------------------------------------------------------------------
" Filetype {{{1

function! status#Filetype() abort
  if s:IsCustomMode() | return '' | endif
  return strlen(&filetype) ? &filetype : s:symbol.for('no ft')
endfunction

" -----------------------------------------------------------------------
" Mode {{{1

function! status#Mode() abort
  let l:mode = s:CustomMode()
  return strlen(l:mode) ? l:mode : lightline#mode()
endfunction

" -----------------------------------------------------------------------
" Git {{{1

function! status#GitBranch() abort
  if winwidth(0) < 100 || s:IsCustomMode() | return '' | endif
  return FugitiveHead(7)
endfunction

" -----------------------------------------------------------------------
" Go {{{1

function! status#Go() abort
  return exists('g:go_loaded_install') ? go#statusline#Show() : ''
endfunction

" -----------------------------------------------------------------------
" Search {{{1

function! status#Search() abort
  if winwidth(0) < 80 | return '' | endif
  return v:lua.require('ar.status.search').count()
endfunction

" -----------------------------------------------------------------------
" Linter {{{1

function! status#Neomake() abort
  if !exists('*neomake#statusline#get') | return '' | endif
  let l:winnr = winnr()
  let l:bufnr = winbufnr(l:winnr)

  return neomake#statusline#get(l:bufnr, {
        \   'format_running': s:symbol.for('spinner'),
        \   'format_loclist_ok': '',
        \   'format_loclist_unknown': '',
        \   'format_loclist_issues': '%s',
        \   'format_loclist_type_E': ' ⨉ {{count}}',
        \   'format_loclist_type_W': '  {{count}}',
        \   'format_loclist_type_I': ' ℹ︎ {{count}}',
        \ })
endfunction

function! status#LSPStatus() abort
  if winwidth(0) < 100 || s:IsCustomMode() | return '' | endif
  if luaeval('#vim.lsp.get_active_clients() > 0')
    return v:lua.require('lsp-status').status()
  endif
  return ''
endfunction

" -----------------------------------------------------------------------
" Tagbar {{{1

function! status#TagbarStatus(current, ...) abort
  return lightline#statusline(!a:current)
endfunction

" -----------------------------------------------------------------------
" Directory {{{1

function! status#Directory() abort
  let l:cwd = fnamemodify(getcwd(), ':~')
  if empty(l:cwd) | return '' | endif
  return s:symbol.for('cwd', l:cwd)
endfunction

" -----------------------------------------------------------------------
" Flags {{{1

function! status#Readonly() abort
  return &filetype !~? 'help\|nerdtree' && &readonly ? s:symbol.for('readonly') : ''
endfunction

function! status#Modified() abort
  return &filetype !=# 'help' && &modified ? s:symbol.for('modified') : ''
endfunction

" -----------------------------------------------------------------------

function! s:Concat(list) abort
  return join(s:Compact(a:list), ' ')
endfunction

function! s:Compact(list) abort
  return filter(copy(a:list), {_, v -> !empty(v)})
endfunction

function! s:IsCustomMode() abort
  return has_key(s:filetype_modes, &filetype)
endfunction

function! s:CustomMode() abort
  if &filetype ==# 'qf'
    return s:symbol.for('list', get(b:, 'qf_isLoc') ? 'LocationList' : 'Quickfix')
  endif

  return get(s:filetype_modes, &filetype, '')
endfunction

function! s:BufferType() abort
  return strlen(&filetype) ? &filetype : &buftype
endfunction

let g:status#_s = s:

" -----------------------------------------------------------------------
