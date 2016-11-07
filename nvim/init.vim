" =======================================================================
" Plugins {{{
" =======================================================================
call plug#begin('~/.config/nvim/plugged')

Plug 'Raimondi/delimitMate'
Plug 'Shougo/vimproc.vim',      { 'build': 'make' }
Plug 'benekastah/neomake',      { 'on': ['Neomake'] }
Plug 'christoomey/vim-tmux-navigator'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'fatih/vim-go',            { 'for': 'go' }
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf',            { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'majutsushi/tagbar',       { 'on': 'TagbarToggle' }
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdtree'
Plug 'slack/vim-align'
Plug 'syngan/vim-vimlint',      { 'for': 'vim' }
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-surround'
Plug 'vim-ruby/vim-ruby',       { 'for': 'ruby' }
Plug 'w0ng/vim-hybrid'
Plug 'ynkdir/vim-vimlparser',   { 'for': 'vim' }

" Plug 'SirVer/ultisnips'

if has('nvim')
  function! DoRemote(arg)
    UpdateRemotePlugins
  endfunction
  Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
  Plug 'zchee/deoplete-go',    { 'for': 'go', 'do': 'make'}
else
  Plug 'Shougo/neocomplete'
endif

call plug#end()
" }}}
" =======================================================================
" General Config {{{
" =======================================================================
set number                   " Show line numbers
set autowrite                " Automatically save before :next, :make etc.
set autoread                 " Set to auto read when a file is changed from the outside
set hidden
set completeopt=menu,menuone
set nocursorcolumn           " speed up syntax highlighting
set nocursorline
set noswapfile               " Don't use swapfile
set noshowmode               " Don't need to show mode since we have lightline
set magic                    " For regular expressions turn magic on
set linebreak                " Wrap lines at convenient points
set nobackup                 " Don't create annoying backup files
set noerrorbells
set novisualbell
set title                    " Sets the terminal title nicely.
set shell=$SHELL

set scrolloff=8              " Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" Split settings
set splitright               " Split vertical windows right to the current windows
set splitbelow               " Split horizontal windows below to the current windows

" -----------------------------------------------------------------------
" Search
" -----------------------------------------------------------------------
set ignorecase               " Search case insensitive...
set smartcase                " ... but not it begins with upper case

" Use ag over grep
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor\ --vimgrep
endif

" -----------------------------------------------------------------------
" Performance
" -----------------------------------------------------------------------
set lazyredraw " only redraw when needed
if exists('&ttyfast') | set ttyfast | endif " if we have a fast terminal
set updatetime=750 " reduce vim delay clock

" -----------------------------------------------------------------------
" Formatting
" -----------------------------------------------------------------------
set smartindent
set smarttab
set shiftwidth=2          " 2 spaces per tab
set softtabstop=2
set tabstop=2
set expandtab             " Use spaces instead of tabs
set list listchars=tab:>-,trail:* " Display tabs and trailing spaces visually
set foldmethod=marker

" -----------------------------------------------------------------------
" Completion
" -----------------------------------------------------------------------
set wildmode=list:longest
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.log,.git
set completeopt=longest,menuone

" -----------------------------------------------------------------------
" Persistent Undo
" -----------------------------------------------------------------------
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo') | set undofile | endif

" -----------------------------------------------------------------------
" UI
" -----------------------------------------------------------------------

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

" disable background color erase
if &term =~ '256color' | set t_ut= | endif

" Enable true color
if exists('+termguicolors') | set termguicolors | endif

syntax enable
set background=dark

let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
colorscheme hybrid

highlight clear SignColumn

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Don't try to highlight long lines.
" This fixes some performance problems on huge files.
set synmaxcol=800

" Set terminal colors
let s:num = 0
for s:color in [
      \ '#2d3c46', '#a54242', '#8c9440', '#de935f',
      \ '#5f819d', '#85678f', '#5e8d87', '#6c7a80',
      \ '#425059', '#cc6666', '#b5bd67', '#f0c674',
      \ '#81a2be', '#b294ba', '#8abeb7', '#c5c8c6',
      \ ]
  let g:terminal_color_{s:num} = s:color
  let s:num += 1
endfor

" }}}
" =======================================================================
" Mappings {{{
" =======================================================================
" disable ex mode
map Q <Nop>

" disable ri check
map K <Nop>

" disable q window
map q: :q

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk

" Better split switching
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when moving up and down
noremap <C-d> <C-d>zz
noremap <C-u> <C-u>zz

" QuickFix navigation
nnoremap ]q :cnext<CR>
nnoremap [q :cprevious<CR>

" Location list navigation
nnoremap ]l :lnext<CR>
nnoremap [l :lprevious<CR>

" Error mnemonic (Neomake uses location list)
nnoremap ]e :lnext<CR>
nnoremap [e :lprevious<CR>

" Common typos
command! W w
command! Q q
command! WQ wq
command! Wq wq

" Leader Commands
" -----------------------------------------------------------------------
let g:mapleader = ","

" Edit vimrc
nnoremap <leader>ev :tabedit $MYVIMRC<CR>
" Edit ftplugin for current filetype
nnoremap <leader>eft :execute 'tabedit' . $HOME . '/.config/nvim/ftplugin/' . &filetype . '.vim'<CR>

" Fast saving
nnoremap <leader>w :w!<cr>
nnoremap <silent> <leader>q :q!<CR>

" Remove search highlight
nnoremap <leader><CR> :nohlsearch<CR>

" Source the current Vim file
nnoremap <leader>pr :so %<CR>

" Format buffer
nmap <leader>= ggVG=<CR>

" Pressing ,ss will toggle and untoggle spell checking
nmap <leader>ss :setlocal spell!<cr>

" Sorting
nnoremap <leader>srt :sort<cr>

" Make horizontal line
nnoremap <leader>L mzO<esc>79i-<esc>`z

" Copy to system clipboard
nnoremap <silent> <leader>y "*y
nnoremap <silent> <leader>Y "*Y
vnoremap <silent> <leader>y "*y
vnoremap <silent> <leader>Y "*Y

if has('nvim')
  " Leader q to exit terminal mode. Somehow it jumps to the end, so jump to
  " the top again
  tnoremap <leader>q <C-\><C-n>gg<cr>
endif

" }}}
" =======================================================================
" Autocmds {{{
" =======================================================================
if has("autocmd")
  augroup vimrc
    autocmd!

    " Save files when vim loses focus
    autocmd FocusLost * silent! wall

    " remove trailing whitespace automatically
    autocmd BufWritePre * :%s/\s\+$//e

    autocmd FileType zsh set foldmethod=marker

    autocmd BufEnter term://* startinsert
  augroup END
endif
" }}}
" =======================================================================
" Plugin Settings {{{
" =======================================================================

" Neomake {{{
" -----------------------------------------------------------------------
if has('nvim')
  let g:neomake_warning_sign = { 'text': '❯', 'texthl': 'WarningMsg' }
  let g:neomake_error_sign   = { 'text': '❯', 'texthl': 'ErrorMsg'   }

  let s:neomake_active = 1
  function! NeomakeToggle()
    let s:neomake_active = !s:neomake_active
    echom s:neomake_active ? "Enabled Neomake" : "Disabled Neomake"
  endfunction
  command! NeomakeToggle call NeomakeToggle()

  function! s:Neomake()
    if s:neomake_active && index(['sh', 'go', 'vim'], &ft) != -1
      Neomake
    endif
  endfunction
  autocmd! BufWritePost * call s:Neomake()
endif
" }}}

" deoplete {{{
" -----------------------------------------------------------------------
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#auto_complete_start_length = 1
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#align_class = 1
let g:deoplete#sources#go#use_cache = 1
let g:deoplete#sources#go#json_directory = $HOME.'/.cache/nvim/deoplete-go'
" }}}

" UltiSnips {{{
" -----------------------------------------------------------------------
function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction

function! g:UltiSnips_Reverse()
  call UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res == 0
    return "\<C-P>"
  endif
  return ""
endfunction


if !exists("g:UltiSnipsJumpForwardTrigger")
  let g:UltiSnipsJumpForwardTrigger = "<tab>"
endif

if !exists("g:UltiSnipsJumpBackwardTrigger")
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif

" autocmd InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
" autocmd InsertEnter * exec "inoremap <silent> " . g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"
" }}}

" vim-align {{{
" -----------------------------------------------------------------------
map <leader>ah :Align =><CR>
nnoremap <leader>a= :Align =<CR>
map <leader>a# :Align #<CR>
map <leader>a{ :Align {<CR>
" }}}

" CtrlP {{{
" -----------------------------------------------------------------------
map <leader>gb :CtrlPBuffer<CR>
map <leader>gt :CtrlPBufTag<CR>
map <leader>gc :CtrlP app/controllers<CR>
map <leader>gm :CtrlP app/models<CR>
map <leader>gv :CtrlP app/views<CR>
map <leader>gl :CtrlP lib<CR>
map <leader>gs :CtrlP spec<CR>

" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
let g:ctrlp_user_command = 'ag -Q %s -l --nocolor --hidden -g "" --ignore _output'

" ag is fast enough that CtrlP doesn't need to cache
let g:ctrlp_use_caching = 0

let g:ctrlp_buftag_types = {'go' : '--language-force=go --golang-types=ft'}
" }}}

" NERDTree {{{
" -----------------------------------------------------------------------
let NERDTreeAutoDeleteBuffer=1
let g:NERDTreeMinimalUI=1

map <leader>e :NERDTreeFind<CR>

" Leave my bindings alone
let g:NERDTreeMapJumpPrevSibling='<Nop>'
let g:NERDTreeMapJumpNextSibling='<Nop>'
" }}}

" EasyAlign {{{
" -----------------------------------------------------------------------
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" }}}

" Tagbar {{{
" -----------------------------------------------------------------------
map <leader>tt :TagbarToggle<cr>
" }}}

" AG {{{
" -----------------------------------------------------------------------
map <leader>a :Ag<space>
map <leader>a* :call SearchWordWithAg()<CR>

function! SearchWordWithAg()
  execute 'Ag' expand('<cword>')
endfunction
" }}}

" FZF {{{
" -----------------------------------------------------------------------
if has('nvim')
  let $FZF_DEFAULT_OPTS .= ' --inline-info'
endif

nmap <silent> <leader>t :FZF<cr>
" }}}

" DelimitMate {{{
" -----------------------------------------------------------------------
let g:delimitMate_expand_cr = 1
" }}}

" Lightline {{{
" -----------------------------------------------------------------------
let g:lightline = { 'colorscheme': 'powerline' }

let g:lightline.active = {
      \   'left':  [
      \            [ 'mode', 'paste' ],
      \            [ 'fugitive', 'filename' ],
      \            [ 'go', 'ctrlpmark' ]
      \   ],
      \   'right': [
      \            [ 'neomake', 'lineinfo' ],
      \            [ 'percent' ],
      \            [ 'fileformat', 'fileencoding', 'filetype' ]
      \   ]
      \ }

let g:lightline.component_function = {
      \   'fugitive':     'LightLineFugitive',
      \   'filename':     'LightLineFilename',
      \   'fileformat':   'LightLineFileformat',
      \   'filetype':     'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode':         'LightLineMode',
      \   'go':           'LightLineGo',
      \   'ctrlpmark':    'CtrlPMark',
      \ }
let g:lightline.component_expand = { 'neomake': 'LightlineNeomake' }
let g:lightline.component_type   = { 'neomake': 'error' }
let g:lightline.subseparator     = { 'left': '|', 'right': '|' }

" The layout of lightline for the tab line when tabs exist.
let g:lightline.tabline = { 'left': [ [ 'tabs' ] ] }

let g:lightline.tab = {
      \ 'active': [ 'filename', 'modified' ],
      \ 'inactive': [ 'filename', 'modified' ] }

function! LightLineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightLineFilename()
  let fname = expand('%')
  return fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ 'NERD_tree' ? '' :
        \ &ft =~ 'fzf' ? '' :
        \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|NERD' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let _ = fugitive#head()
      return _ !=# '' ? mark._ : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft =~ 'fzf' ? 'FZF' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightLineGo()
  return exists('*go#jobcontrol#Statusline') ? go#jobcontrol#Statusline() : ''
endfunction

function! LightlineNeomake()
  return exists('*neomake#statusline#LoclistStatus') ? neomake#statusline#LoclistStatus() : ''
endfunction

function! OnNeomakeCountsChanged()
  call lightline#update()
endfunction

autocmd vimrc User NeomakeCountsChanged call OnNeomakeCountsChanged()

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP' && has_key(g:lightline, 'ctrlp_item')
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
      \ 'main': 'CtrlPStatusFunc_1',
      \ 'prog': 'CtrlPStatusFunc_2',
      \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
  let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction
" }}}
" }}}

" vim: foldmethod=marker
