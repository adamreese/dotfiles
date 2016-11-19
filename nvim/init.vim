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
" Settings {{{
" =======================================================================
" General {{{
" -----------------------------------------------------------------------
set encoding=utf-8
scriptencoding utf-8

set autowrite                " Automatically save before :next, :make etc.
set autoread                 " Set to auto read when a file is changed from the outside
set hidden
set noswapfile               " Don't use swapfile
set magic                    " For regular expressions turn magic on
set nobackup                 " Don't create annoying backup files
set noerrorbells
set novisualbell
set shell=$SHELL
set ttyfast
if &compatible
  set nocompatible
endif
" }}}
" -----------------------------------------------------------------------
" Search {{{
" -----------------------------------------------------------------------
set ignorecase               " Search case insensitive...
set smartcase                " ... but not it begins with upper case
" }}}
" -----------------------------------------------------------------------
" Performance " {{{
" -----------------------------------------------------------------------
set lazyredraw " only redraw when needed
if exists('&ttyfast') | set ttyfast | endif " if we have a fast terminal
set updatetime=750 " reduce vim delay clock
" set timeout timeoutlen=400
set ttimeout ttimeoutlen=100
" }}}
" -----------------------------------------------------------------------
" Formatting {{{
" -----------------------------------------------------------------------
set autoindent
set smartindent
set smarttab
set shiftwidth=2          " 2 spaces per tab
set softtabstop=2
set tabstop=2
set expandtab             " Use spaces instead of tabs
" }}}
" -----------------------------------------------------------------------
" Wildmenu {{{
" -----------------------------------------------------------------------
if has('wildmenu')
  set wildmode=list:longest,full
  set wildoptions=tagfile
  set wildignorecase
  set wildignore+=.git,*.pyc,*.spl,*.o,*.out,*~,#*#,%*
  set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store
endif
" }}}
" -----------------------------------------------------------------------
" Folding {{{
" -----------------------------------------------------------------------
if has('folding')
  set foldmethod=marker
  set foldtext=FoldText()

  " See: http://dhruvasagar.com/2013/03/28/vim-better-foldtext
  function! FoldText() "{{{
    let l:line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
    let l:lines_count = v:foldend - v:foldstart + 1
    let l:lines_count_text = '| ' . printf('%10s', l:lines_count . ' lines') . ' |'
    let l:foldchar = matchstr(&fillchars, 'fold:\zs.')
    let l:foldtextstart = strpart('+' . repeat(l:foldchar, v:foldlevel*2) . l:line, 0, (winwidth(0)*2)/3)
    let l:foldtextend = l:lines_count_text . repeat(l:foldchar, 8)
    let l:foldtextlength = strlen(substitute(l:foldtextstart . l:foldtextend, '.', 'x', 'g')) + &foldcolumn
    return l:foldtextstart . repeat(l:foldchar, winwidth(0)-l:foldtextlength) . l:foldtextend
  endfunction "}}}
endif
" }}}
" -----------------------------------------------------------------------
" Persistent Undo {{{
" -----------------------------------------------------------------------
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  set undofile                         " actually use undo files
  set undodir=~/.local/share/nvim/undo " keep undo files out of the way
endif
" }}}
" -----------------------------------------------------------------------
" Behavior {{{
" -----------------------------------------------------------------------
set backspace=indent,eol,start
set completeopt+=menuone
set completeopt-=preview
set linebreak                " Wrap lines at convenient points
set scrolloff=8              " Start scrolling when we're 8 lines away from margins
set sidescroll=1
set sidescrolloff=15
set pumheight=20             " Pop-up menu's line height
set splitbelow               " Split horizontal windows below to the current windows
set splitright               " Split vertical windows right to the current windows
" }}}
" -----------------------------------------------------------------------
" UI {{{
" -----------------------------------------------------------------------
set nocursorcolumn           " speed up syntax highlighting
set nocursorline
set noshowmode               " Don't need to show mode since we have lightline
set number                   " Show line numbers
set list listchars=tab:>-,trail:* " Display tabs and trailing spaces visually
set display=lastline
set laststatus=2
set laststatus=2

if has('nvim')
  let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
endif

" Sets the terminal title nicely.
set title titlestring+=%{fnamemodify(getcwd(),':t')}\ -\ NVIM

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
highlight clear FoldColumn

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
let g:mapleader = ','

" Edit vimrc
nnoremap <leader>ev :tabedit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

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
vnoremap <leader>srt :sort<cr>

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
if has('autocmd')
  augroup vimrc
    autocmd!
  augroup END

  " Save files when vim loses focus
  autocmd vimrc FocusLost * silent! wall

  " remove trailing whitespace automatically
  autocmd vimrc BufWritePre * :%s/\s\+$//e

  " check timestamp more for 'autoread'
  autocmd vimrc WinEnter * checktime

  autocmd vimrc InsertEnter * :setlocal nohlsearch
  autocmd vimrc InsertLeave * :setlocal hlsearch

  autocmd vimrc BufEnter term://* startinsert
endif
" }}}
" =======================================================================
" Plugin Settings {{{
" =======================================================================
" Neomake {{{
" -----------------------------------------------------------------------
let g:neomake_warning_sign = { 'text': '❯', 'texthl': 'WarningMsg' }
let g:neomake_error_sign   = { 'text': '❯', 'texthl': 'ErrorMsg'   }

let s:neomake_active = 1
function! NeomakeToggle() "{{{
  let s:neomake_active = !s:neomake_active
  echom s:neomake_active ? 'Enabled Neomake' : 'Disabled Neomake'
endfunction "}}}
command! NeomakeToggle call NeomakeToggle()

function! s:run_neomake() "{{{
  let l:filetypes = [
        \ 'css', 'go', 'html', 'json', 'markdown', 'ruby',
        \ 'sh', 'vim', 'yaml'
        \ ]
  if s:neomake_active && empty(&buftype) && index(l:filetypes, &filetype) > -1
    Neomake
  endif
endfunction "}}}
autocmd vimrc BufWritePost * call <SID>run_neomake()
" }}}
" -----------------------------------------------------------------------
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
" -----------------------------------------------------------------------
" vim-align {{{
" -----------------------------------------------------------------------
map <leader>ah :Align =><CR>
nnoremap <leader>a= :Align =<CR>
map <leader>a# :Align #<CR>
map <leader>a{ :Align {<CR>
" }}}
" -----------------------------------------------------------------------
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
" -----------------------------------------------------------------------
" NERDTree {{{
" -----------------------------------------------------------------------
let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeIgnore=['\.git$', '\.gitignore']
let g:NERDTreeShowHidden=1
let g:NERDTreeMapJumpNextSibling='<Nop>'
let g:NERDTreeMapJumpPrevSibling='<Nop>'
let g:NERDTreeMinimalUI=1

map <leader>e :NERDTreeFind<CR>
" }}}
" -----------------------------------------------------------------------
" EasyAlign {{{
" -----------------------------------------------------------------------
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" }}}
" -----------------------------------------------------------------------
" Tagbar {{{
" -----------------------------------------------------------------------
map <leader>tt :TagbarToggle<cr>
" }}}
" -----------------------------------------------------------------------
" AG {{{
" -----------------------------------------------------------------------
if executable('ag')
  let &grepprg='ag --nogroup --nocolor --vimgrep'
  let g:ackprg = 'ag --smart-case --vimgrep'

  map <leader>a :Ag<space>
  map <leader>a* :call SearchWordWithAg()<CR>

  function! SearchWordWithAg()
    execute 'Ag' expand('<cword>')
  endfunction
endif
" }}}
" -----------------------------------------------------------------------
" FZF {{{
" -----------------------------------------------------------------------
if has('nvim')
  let $FZF_DEFAULT_OPTS .= ' --inline-info'
endif

nmap <silent> <leader>t :FZF<cr>
nnoremap <silent> <c-b>  :Buffers<cr>

" }}}
" -----------------------------------------------------------------------
" DelimitMate {{{
" -----------------------------------------------------------------------
let g:delimitMate_expand_cr = 1
" }}}
" -----------------------------------------------------------------------
" Lightline {{{
" -----------------------------------------------------------------------
let g:lightline = {
      \ 'colorscheme': 'default',
      \ 'active': {
      \   'left':  [
      \     [ 'mode' ], [ 'fugitive' ], [ 'filename' ], [ 'go', 'ctrlpmark' ],
      \   ],
      \   'right': [
      \     [ 'neomake', 'lineinfo' ], [ 'fileformat', 'fileencoding' ], [ 'filetype' ],
      \   ]
      \ },
      \ 'inactive': {
      \   'left': [
      \     [ ], [ 'filename' ], [ ]
      \   ],
      \   'right': [
      \     [ 'lineinfo' ], [ 'fileformat', 'fileencoding' ], [ 'filetype' ],
      \   ]
      \ },
      \ 'component_function': {
      \   'fugitive':     'statusline#lightlineFugitive',
      \   'filename':     'statusline#lightlineFilename',
      \   'fileformat':   'statusline#lightlineFileformat',
      \   'filetype':     'statusline#lightlineFiletype',
      \   'fileencoding': 'statusline#lightlineFileencoding',
      \   'mode':         'statusline#lightlineMode',
      \   'go':           'statusline#lightlineGo',
      \   'ctrlpmark':    'statusline#CtrlPMark',
      \ },
      \ 'component_expand': {
      \   'neomake':   'statusline#lightlineNeomake',
      \   'lineinfo':  'statusline#lightlineLineInfo',
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
" }}}

" vim: foldmethod=marker
