" =======================================================================
" plugin/settings.vim
" =======================================================================

" General: {{{1
" -----------------------------------------------------------------------

set autowrite                " Automatically save before :next, :make etc.
set autoread                 " Set to auto read when a file is changed from the outside
set hidden
set noswapfile               " Don't use swapfile
set magic                    " For regular expressions turn magic on
set nobackup                 " Don't create annoying backup files
set noerrorbells
set novisualbell
set shell=$SHELL
set dictionary+=/usr/share/dict/words
set history=1000
set spellsuggest=best,10 " Limit suggestions to 10

if !g:nvim
  set ttyfast
  if has('mouse_sgr')
    set ttymouse=sgr
  else
    set ttymouse=xterm2
  endif
endif

" Search: {{{1
" -----------------------------------------------------------------------

set ignorecase               " Search case insensitive...
set smartcase                " ... but not it begins with upper case

if exists('+inccommand')
  set inccommand=nosplit
endif

" Performance: {{{1
" -----------------------------------------------------------------------

set lazyredraw               " only redraw when needed
set ttimeout
set ttimeoutlen=10
set timeout
set timeoutlen=1000
set updatetime=500

" Don't try to highlight long lines.
" This fixes some performance problems on huge files.
set synmaxcol=1000

set maxmempattern=2000000

" Indent: {{{1
" -----------------------------------------------------------------------

set autoindent
set smartindent
set smarttab
set shiftwidth=2             " 2 spaces per tab
set softtabstop=2
set tabstop=2
set expandtab                " Use spaces instead of tabs

" Wildmenu: {{{1
" -----------------------------------------------------------------------

if has('wildmenu')
  set wildmode=list:longest,full
  set wildignorecase
  set wildignore+=*.pyc,*.spl,*.o,*.out,*~,#*#,%*
  set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store
endif

" Folding: {{{1
" -----------------------------------------------------------------------

if has('folding')
  set foldmethod=marker
  set foldtext=folding#text()
  set foldopen+=jump
endif

" Directories: {{{1
" -----------------------------------------------------------------------

execute 'set directory=' . g:data_dir . '/swap//'
execute 'set backupdir=' . g:data_dir . '/backup/'
execute 'set spellfile=' . g:vim_dir  . '/spell/en.utf-8.add'

if has('mksession')
  execute 'set viewdir=' . g:data_dir . '/view/'
  set viewoptions=cursor,folds " save/restore just these (with `:{mk,load}view`)
endif

" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  set undofile
  execute 'set undodir=' . g:data_dir . '/undo/'
endif

if g:nvim
  exec 'set shada+=n' . g:data_dir . '/main.shada'
else
  exec 'set viminfo+=n' . g:data_dir . '/viminfo'
endif

" Don't create root-owned files
if exists('$SUDO_USER')
  set noundofile

  if g:nvim
    set shada=
  else
    set viminfo=
  endif
endif

for s:dir in [&backupdir, &directory, &undodir, &viewdir]
  if !isdirectory(s:dir)
    call mkdir(s:dir, 'p')
  endif
endfor

" Behavior: {{{1
" -----------------------------------------------------------------------

set backspace=indent,eol,start
set complete=.                       " Default: .,w,b,u,t
set completeopt=menu,menuone,longest " show PUM, even for one thing
set isfname-==                       " Don't consider = symbol as part filename. Helps for deoplete file source.
set pumheight=20                     " Pop-up menu's line height
set scrolloff=8                      " Start scrolling when we're 8 lines away from margins
set sidescroll=1
set sidescrolloff=15
set splitbelow                       " Split horizontal windows below to the current windows
set splitright                       " Split vertical windows right to the current windows

" Diff: {{{1
" -----------------------------------------------------------------------

set diffopt=vertical              " Use in vertical diff mode
set diffopt+=filler               " blank lines to keep sides aligned
set diffopt+=iwhite               " Ignore whitespace changes
set diffopt+=foldcolumn:0         " Disable foldcolumn

" UI: {{{1
" -----------------------------------------------------------------------

set display=lastline
set laststatus=2
set list                          " Display tabs and trailing spaces visually
set nocursorcolumn                " speed up syntax highlighting
set nocursorline
set noshowmode                    " Don't need to show mode since we have lightline
set number                        " Show line numbers
set textwidth=78
set title                         " Sets the terminal title nicely.

" Disable blinking cursor
set guicursor&
set guicursor=n-v-c:block-blinkon0,i-ci-ve:ver25-blinkon0,r-cr:hor20,o:hor50

set shortmess+=A                  " ignore annoying swapfile messages
set shortmess+=I                  " no splash screen
set shortmess+=O                  " file-read message overwrites previous
set shortmess+=T                  " truncate non-file messages in middle
set shortmess+=W                  " don't echo "[w]"/"[written]" when writing
set shortmess+=a                  " use abbreviations in messages eg. `[RO]` instead of `[readonly]`
set shortmess+=o                  " overwrite file-written messages
set shortmess+=t                  " truncate file messages at start

if has('linebreak')
  set linebreak
endif

if exists('+termguicolors')
  set t_ut=         " disable background color erase
  set termguicolors " enable true color
endif

syntax enable
set background=dark

let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
colorscheme hybrid

" Enable bash syntax
" $VIMRUNTIME/syntax/sh.vim
let g:is_bash = 1
let g:vimsyn_noopererror = 1

" Disable menu
let g:did_install_default_menus = 1

" Modeline {{{1
" -----------------------------------------------------------------------
" vim:foldmethod=marker
