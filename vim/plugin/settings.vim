" =======================================================================
" plugin/settings.vim
" =======================================================================
scriptencoding utf-8

" General: {{{1
" -----------------------------------------------------------------------

set autowrite                " Automatically save before :next, :make etc.
set dictionary+=/usr/share/dict/words
set history=1000
set spellsuggest=best,10 " Limit suggestions to 10
execute 'set spellfile=' . stdpath('config') . '/spell/en.utf-8.add'

" Search: {{{1
" -----------------------------------------------------------------------

set ignorecase               " Search case insensitive...
set smartcase                " ... but not it begins with upper case

" Performance: {{{1
" -----------------------------------------------------------------------

set ttimeoutlen=10
set timeoutlen=750
set updatetime=300

" Don't try to highlight long lines.
" This fixes some performance problems on huge files.
set synmaxcol=1000

set maxmempattern=2000000

" Indent: {{{1
" -----------------------------------------------------------------------

set breakindent
set smartindent
set shiftwidth=2             " 2 spaces per tab
set softtabstop=2
set tabstop=2
set expandtab                " Use spaces instead of tabs

" Wildmenu: {{{1
" -----------------------------------------------------------------------

set wildignore+=*.jpg,*.jpeg,*.bmp,*.gif,*.png   " images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.DS_Store                       " macOS
set wildignorecase

set wildmode=longest:full,full        " Complete files using a menu AND list

" Folding: {{{1
" -----------------------------------------------------------------------

" set foldtext=folding#Text()
set foldopen+=jump
set foldlevelstart=99

" Keep undo history across sessions, by storing in file.
" Only works all the time.
set undofile

" Don't create root-owned files
if exists('$SUDO_USER')
  set nobackup
  set noswapfile
  set noundofile
  set nowritebackup
  set shada=
endif

" Behavior: {{{1
" -----------------------------------------------------------------------

" default: .,w,b,u,t
set complete-=t                      " Avoid tag completion by default

" default: 'menu,preview'
set completeopt=
set completeopt+=menuone             " Show the popup if only one completion
set completeopt+=noinsert            " Don't insert text for a match unless selected
set completeopt+=noselect            " Don't auto-select the first match

set formatoptions+=n                 " Recognize numbered lists
set formatoptions+=1                 " Don't break lines after a one-letter word

set isfname-==                       " Don't consider = symbol as part filename
set pumheight=30                     " Pop-up menu's line height
set scrolloff=8                      " Start scrolling when we're 8 lines away from margins
set sidescroll=1
set sidescrolloff=15
set scrolljump=3
set splitbelow                       " Split horizontal windows below to the current windows
set splitright                       " Split vertical windows right to the current windows
set virtualedit=block                " Allow virtual editing in Visual block mode
set switchbuf=useopen,uselast

set mouse=                           " Disable mouse support

set tags^=./.git/tags;

" Diff: {{{1
" -----------------------------------------------------------------------

set diffopt=vertical              " Use in vertical diff mode
set diffopt+=filler               " blank lines to keep sides aligned
set diffopt+=iwhite               " Ignore whitespace changes
set diffopt+=foldcolumn:0         " Disable foldcolumn
set diffopt+=internal,algorithm:histogram,indent-heuristic

" UI: {{{1
" -----------------------------------------------------------------------

let &listchars='tab:⋮ ,extends:⟫,precedes:⟪,nbsp:␣,trail:·'
let &fillchars='diff:·,vert:│,fold: ,eob: ,msgsep:‾'
let &showbreak='↳ '

set concealcursor=niv
set conceallevel=2
set list                          " Display tabs and trailing spaces visually
set nocursorcolumn                " speed up syntax highlighting
set noshowcmd                     " No to showing command in bottom-right corner
set noshowmode                    " No to showing mode in bottom-left corner
set number                        " Show line numbers
set textwidth=78
set title                         " Sets the terminal title nicely.

" Disable blinking cursor
set guicursor&
set guicursor=n-v-c:block-blinkon0,i-ci-ve:ver25-blinkon0,r-cr:hor20,o:hor50

set shortmess+=A                  " ignore annoying swapfile messages
set shortmess+=I                  " no splash screen
set shortmess+=W                  " don't echo "[w]"/"[written]" when writing
set shortmess+=a                  " use abbreviations in messages eg. `[RO]` instead of `[readonly]`
set shortmess+=c                  " Disable 'Pattern not found' messages
set shortmess+=S                  " don't show search count message when searching

set signcolumn=yes

set linebreak

if has('nvim-0.10')
  set smoothscroll
else
  set termguicolors " enable true color
endif

" Enable bash syntax
" $VIMRUNTIME/syntax/sh.vim
let g:is_bash = v:true
let g:vimsyn_noopererror = v:true

" Disable menu
let g:did_install_default_menus = v:true

" Disable builtin plugins
let g:loaded_2html_plugin      = v:true
let g:loaded_getscriptPlugin   = v:true
let g:loaded_logiPat           = v:true
let g:loaded_netrwFileHandlers = v:true
let g:loaded_netrwPlugin       = v:true
let g:loaded_netrwSettings     = v:true
let g:loaded_tutor_mode_plugin = v:true
let g:loaded_vimball           = v:true
let g:loaded_vimballPlugin     = v:true
let g:vimsyn_embed             = 'l'
