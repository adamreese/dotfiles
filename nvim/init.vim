call plug#begin('~/.config/nvim/plugged')

" UltiSnips - The ultimate snippet solution for Vim.
Plug 'SirVer/ultisnips'
" Seamless navigation between tmux panes and vim splits
Plug 'christoomey/vim-tmux-navigator'
" Fuzzy file, buffer, mru, tag, etc
Plug 'ctrlpvim/ctrlp.vim'
" Go development plugin for Vim
Plug 'fatih/vim-go'
" A command-line fuzzy finder written in Go.
Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
" A Vim alignment plugin
Plug 'junegunn/vim-easy-align'
" Vim plugin that displays tags in a window, ordered by scope
Plug 'majutsushi/tagbar'
" Vim plugin for the_silver_searcher, 'ag', a replacement for the Perl module / CLI script 'ack'
Plug 'rking/ag.vim'
" Vim plugin for intensely orgasmic commenting.
Plug 'scrooloose/nerdcommenter'
" A tree explorer plugin for vim.
Plug 'scrooloose/nerdtree'
" Syntax checking hacks for vim.
Plug 'scrooloose/syntastic'
" A Vim alignment plugin
Plug 'slack/vim-align'
" Lint for vim script.
Plug 'syngan/vim-vimlint', { 'for': 'vim' }
" Easily search for, substitute, and abbreviate multiple variants of a word
Plug 'tpope/vim-abolish'
" A Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'
" Enable repeating supported plugin maps with '.'
Plug 'tpope/vim-repeat'
" A Vim plugin for Vim plugins
Plug 'tpope/vim-scriptease'
" Quoting/parenthesizing made simple
Plug 'tpope/vim-surround'
" Lean & mean status/tabline for vim that's light as air.
Plug 'itchyny/lightline.vim'

Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
" A dark color scheme for Vim & gVim.
Plug 'w0ng/vim-hybrid'
" VimL parser.
Plug 'ynkdir/vim-vimlparser', { 'for': 'vim' }
" Interactive command execution in Vim.
Plug 'Shougo/vimproc.vim', { 'build': 'make' }

if has('nvim')
  " A plugin for asynchronous :make using Neovim's job-control functionality.
  Plug 'benekastah/neomake'
  " Dark powered asynchronous completion framework for neovim.
  Plug 'Shougo/deoplete.nvim'
  " deoplete.nvim source for Go.
  Plug 'zchee/deoplete-go', { 'do': 'make'}
else
  " Next generation completion framework after neocomplcache.
  Plug 'Shougo/neocomplete'
endif

call plug#end()

set number                   " Show line numbers
set splitright               " Split vertical windows right to the current windows
set splitbelow               " Split horizontal windows below to the current windows
set autowrite                " Automatically save before :next, :make etc.
set hidden
set ignorecase               " Search case insensitive...
set smartcase                " ... but not it begins with upper case
set completeopt=menu,menuone
set nocursorcolumn           " speed up syntax highlighting
set nocursorline
set noswapfile               " Don't use swapfile
set noshowmode               " Don't need to show mode since we have airline
set magic                  " For regular expressions turn magic on
set linebreak              " Wrap lines at convenient points
set nobackup               " Don't create annoying backup files
set noerrorbells
set novisualbell
set laststatus=2

set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

set lazyredraw
set list listchars=tab:>-,trail:* " Display tabs and trailing spaces visually

set clipboard^=unnamed
set clipboard^=unnamedplus

" Indentation {{{
" -----------------------------------------------------------------------
set smartindent
set smarttab
set shiftwidth=2          " 2 spaces per tab
set softtabstop=2
set tabstop=2
set expandtab             " Use spaces instead of tabs
" }}}

" Completion {{{
" -----------------------------------------------------------------------
set wildmode=list:longest
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.log,.git
set completeopt=longest,menuone
" }}}

" Persistent Undo {{{
" -----------------------------------------------------------------------
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif
" }}}

" UI {{{
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

syntax enable
set background=dark

let g:hybrid_custom_term_colors = 1
"let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
colorscheme hybrid
" }}}

" Mappings {{{
" -----------------------------------------------------------------------
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

" Common typos
command! W w
command! Q q
command! WQ wq
command! Wq wq

" Leader Commands
" -----------------------------------------------------------------------
let g:mapleader = ","

nmap <leader>ev :tabedit $MYVIMRC<CR>

" Fast saving
nnoremap <leader>w :w!<cr>
nnoremap <silent> <leader>q :q!<CR>

" Remove search highlight
nnoremap <leader><CR> :nohlsearch<CR>

" Source the current Vim file
nnoremap <leader>pr :so %<CR>

" Format buffer
map <leader>= ggVG=<CR>

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Sorting
map <leader>srt :sort<cr>

" Some useful quickfix shortcuts for quickfix
if has('nvim')
  " I'm using location list in vim-go
  map <C-n> :lnext<CR>
  map <C-m> :lprevious<CR>
  nnoremap <leader>a :lclose<CR>
else
  map <C-n> :cn<CR>
  map <C-m> :cp<CR>
  nnoremap <leader>a :cclose<CR>
endif

" }}}

" Autocmds {{{
" -----------------------------------------------------------------------
if has("autocmd")
  " Save files when vim loses focus
  autocmd FocusLost * silent! wall

  " remove trailing whitespace automatically
  autocmd BufWritePre * :%s/\s\+$//e

  " make quickfix windows take all the lower section of the screen
    " when there are multiple windows open
    autocmd FileType qf wincmd J
endif
" }}}

" Neomake {{{
" -----------------------------------------------------------------------
if has('nvim')
  " open list automatically but preserve cursor position
  let g:neomake_open_list = 2
  let g:neomake_list_height = 5

  let g:neomake_error_sign = {
        \ 'text': '>',
        \ 'texthl': 'ErrorMsg',
        \ }
  let g:neomake_warning_sign = { 'texthl': 'WarningMsg' }

  autocmd! BufWritePost * Neomake
endif
" }}}

" deoplete {{{
" -----------------------------------------------------------------------
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['func', 'type', 'var', 'const']
let g:deoplete#sources#go#align_class = 1
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
let g:ctrlp_user_command = 'ag -Q %s -l --nocolor -g "" --ignore _output'

" ag is fast enough that CtrlP doesn't need to cache
let g:ctrlp_use_caching = 0

let g:ctrlp_buftag_types = {'go' : '--language-force=go --golang-types=ft'}
" }}}

" NERDTree {{{
" -----------------------------------------------------------------------
let g:NERDTreeMinimalUI=1
map <leader>e :NERDTreeFind<CR>
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

" ag {{{
" -----------------------------------------------------------------------
map <leader>a :Ag<space>
map <leader>a* :Ag<space><cword><CR>
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
      \            [ 'syntastic', 'lineinfo' ],
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

let g:lightline.component_expand = { 'syntastic': 'SyntasticStatuslineFlag' }
let g:lightline.component_type   = { 'syntastic': 'error' }
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
        \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
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
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightLineGo()
  return exists('*go#jobcontrol#Statusline') ? go#jobcontrol#Statusline() : ''
endfunction

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

augroup AutoSyntastic
  autocmd!
  autocmd BufWritePost *.c,*.cpp call s:syntastic()
augroup END
function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

" }}}

" vim: foldmethod=marker
