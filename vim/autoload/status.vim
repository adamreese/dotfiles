" =======================================================================
" autoload/status.vim
" =======================================================================
scriptencoding utf-8

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
      \ 'vista':         'Vista',
      \ }

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
    return get(s:, 'tagbar_fname', '')
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
  if strlen(a:path) < 50
    return a:path
  endif

  let l:parts = split(a:path, '/')

  let l:max = 3
  if len(l:parts) < l:max
    return a:path
  endif

  return join([l:parts[0], '⋯'] + l:parts[ -l:max : ], '/')
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
  if winwidth(0) < 100 || s:IsCustomMode()
    return ''
  endif

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
  return exists('g:loaded_anzu') ? anzu#search_status() : ''
endfunction

" -----------------------------------------------------------------------
" Linter {{{1
"
function! status#Whitespace() abort
  if empty(&buftype) && ! &readonly && &modifiable && line('$') < 9000
    return search('\s$', 'nw') == 0 ? '' : s:symbol.for('whitespace', '')
  endif
  return ''
endfunction

function! status#LintError() abort
  return s:Concat([
        \ s:CocCount('error'),
        \ s:NeomakeCount('E'),
        \ ])
endfunction

function! status#LintWarning() abort
  return s:Concat([
        \ s:CocCount('warning'),
        \ s:NeomakeCount('W'),
        \ ])
endfunction

function! status#LintInfo() abort
  return s:Concat([
        \ s:CocCount('information'),
        \ s:NeomakeCount('I'),
        \ ])
endfunction

function! status#LintRunning() abort
  if exists('g:loaded_neomake') && !empty(neomake#GetJobs())
    return s:symbol.for('spinner')
  endif
  return ''
endfunction

function! s:NeomakeCount(group) abort
  if !exists('g:loaded_neomake') | return '' | endif

  let l:counts = neomake#statusline#LoclistCounts()
  if empty(l:counts)
    let l:counts = neomake#statusline#QflistCounts()
  endif

  return get(l:counts, a:group, '')
endfunction

function! status#CocStatus() abort
  return get(g:, 'coc_status', '')
endfunction

" kind: error, warning, information, hints
function! s:CocCount(kind) abort
  if !get(g:, 'coc_enabled') | return '' | endif

  let l:count = get(get(b:, 'coc_diagnostic_info', {}), a:kind)
  return l:count ? printf('ʟs(%d)', l:count) : ''
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

function! status#Paste() abort
  return &paste ? s:symbol.for('paste') : ''
endfunction

function! status#Readonly() abort
  return &filetype !~? 'help\|nerdtree' && &readonly ? s:symbol.for('readonly') : ''
endfunction

function! status#Modified() abort
  return &filetype !=# 'help' && &modified ? s:symbol.for('modified') : ''
endfunction

function! status#Spell() abort
  return &spell ? s:symbol.for('spell') : ''
endfunction

" -----------------------------------------------------------------------
" Percent {{{1

" Percent was inspired by vim-line-no-indicator plugin.
function! status#Percent() abort
    let l:chars = ['꜒', '꜓', '꜔', '꜕', '꜖']
    " let l:chars = ['˥', '˦', '˧', '˨', '˩']
    " let l:chars = [' ', '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█']
    " let l:chars = ['⎺', '⎻', '─', '⎼', '⎽']
    let l:lines = line('$')
    let l:idx = float2nr(ceil((line('.') * len(l:chars) * 1.0) / l:lines)) - 1
    return l:chars[l:idx]
endfun

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
