" ~/.vimrc
set nocompatible

" ================ General Config ====================
set autoread                    "Reload files changed outside vim
set backspace=indent,eol,start  "Allow backspace in insert mode
set encoding=utf-8
set fileformats+=mac
set gcr=a:blinkon0              "Disable cursor blink
set hidden                      "Better buffer management
set history=1000                "Store lots of :cmdline history
set number                      "Line numbers are good
set shell=/bin/bash
set showcmd                     "Show incomplete cmds down the bottom
set showmode                    "Show current mode down the bottom
set so=7                        "Set 7 lines to the cursor - when moving vertically using j/k
set ttimeout
set ttimeoutlen=100
set visualbell                  "No sounds

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

let mapleader=","

" Edit the vimrc file
nmap <leader>ev :tabedit $MYVIMRC<CR>
nmap <leader>evb :tabedit ~/.vimrc.bundles<CR>

" Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
  autocmd bufwritepost .vimrc.bundles source $MYVIMRC
endif


" =============== Vundle Initialization ===============
" This loads all the plugins specified in ~/.vimrc.bundles
" Use Vundle plugin to manage all other plugins

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

"Filetype plugin indent on is required by vundle
filetype plugin indent on

" ================ UI ==============
set t_Co=256
syntax enable
set background=dark

colorscheme hybrid

highlight clear LineNr     " Current line number row will have same background color in relative mode
highlight clear SignColumn " SignColumn should match background
set cursorline             " Highlight current line
set hlsearch               " Highlight search results
set ignorecase             " Ignore case when searching
set incsearch              " Makes search act like search in modern browsers
set lazyredraw             " Don't redraw while executing macros (good performance config)
set magic                  " For regular expressions turn magic on
set mat=2                  " How many tenths of a second to blink when matching brackets
set showmatch              " Show matching brackets when text indicator is over them
set showmode               " Display the current mode
set smartcase              " When searching try to be smart about cases
set tabpagemax=15          " Only show 15 tabs

" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" ================ Turn Off Swap Files ==============
set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.
if has('persistent_undo')
  silent !mkdir ~/.vim/backups > /dev/null 2>&1
  set undodir=~/.vim/backups
  set undofile
endif

" ================ Indentation ======================
set autoindent
set smartindent
set smarttab
set shiftwidth=2          " 2 spaces per tab
set softtabstop=2
set tabstop=2
set expandtab             " Use spaces instead of tabs

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=tab:>-,trail:*

set nowrap       "Don't wrap lines
set linebreak    "Wrap lines at convenient points

autocmd FileType *         set nolist|set tabstop=4|set shiftwidth=4|set noexpandtab
autocmd FileType ruby,haml set            tabstop=2|set shiftwidth=2|set expandtab   |set autoindent
autocmd FileType go        set nolist|set tabstop=8|set shiftwidth=8|set noexpandtab
autocmd FileType perl      set nolist|set tabstop=8|set shiftwidth=8|set noexpandtab


" ================ Windows ======================
set splitbelow
set splitright

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Easy buffer navigation
noremap <leader>bp :bprevious<cr>
noremap <leader>bn :bnext<cr>

" Splits ,v and ,h to open new splits (vertical and horizontal)
nnoremap <leader>v <C-w>v<C-w>l
nnoremap <leader>h <C-w>s<C-w>j

" Save and quit
nmap <leader>wq :w!<cr>:bdelete<cr>

" Tabs
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>

" ================ Folds ============================
set foldlevelstart=1
set foldmethod=syntax   "fold based on syntax
set foldnestmax=9       "deepest fold is 3 levels
set nofoldenable        "dont fold by default
let xml_syntax_folding=1

" ================ Completion =======================
set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif


" grep
map <leader>a :Ack<space>
map <leader>a* :Ack<space><cword><CR>
set grepprg=ack
set grepformat=%f:%l:%m


" ================ Scrolling ========================
set scrolloff=8         "Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1

" ================ Status Line ======================
if has('cmdline_info')
  set ruler                   " Show the ruler
  set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
  set showcmd                 " Show partial commands in status line and
                              " Selected characters/lines in visual mode
endif

if has('statusline')
  set laststatus=2
  set statusline=%<%f\                     " Filename
  set statusline+=%w%h%m%r                 " Options
  set statusline+=%{fugitive#statusline()} " Git Hotness
  set statusline+=\ [%{&ff}/%Y]            " Filetype
  set statusline+=\ [%{getcwd()}]          " Current dir
  set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

" ================ Plugin Settings ======================

" CtrlP is fun
let g:ctrlp_match_window_reversed = 0
map <leader>cf :ClearCtrlPCache<CR>
map <leader>gb :CtrlPBuffer<CR>
map <leader>gc :CtrlP app/controllers<CR>
map <leader>gg :topleft 100 :split Gemfile<CR>
map <leader>gl :CtrlP lib<CR>
map <leader>gm :CtrlP app/models<CR>
map <leader>gs :CtrlP spec<CR>
map <leader>gv :CtrlP app/views<CR>

" NerdTree
map <leader>e :NERDTreeFind<CR>
map <leader>n :NERDTreeToggle<CR>
map <leader>ntm :NERDTreeMirror<CR>
map <leader>ntc :NERDTreeClose<CR>
map <silent> <leader>d :execute 'NERDTreeToggle ' . getcwd()<CR>

let g:NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr', '^\.bundle']
let g:NERDSpaceDelims = 1
let g:NERDTreeShowHidden=1
let g:NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=1
let g:NERDTreeBookmarksFile='$HOME/.vim/NERDTreeBookmarks'
let g:NERDTreeMinimalUI=1
let g:NERDTreeDirArrows=1

"mark syntax errors with :signs
let g:syntastic_enable_signs=1
"automatically jump to the error when saving the file
let g:syntastic_auto_jump=0
"show the error list automatically
let g:syntastic_auto_loc_list=1
"don't care about warnings
let g:syntastic_quiet_messages = {'level': 'warnings'}

let g:airline_powerline_fonts=1
let g:airline_left_sep=''
let g:airline_left_alt_sep=''
let g:airline_right_sep=''
let g:airline_right_alt_sep=''

let g:signify_disable_by_default=1


" Align bindings
map <leader>ah :Align =><CR>
nnoremap <leader>a= :Align =<CR>
map <leader>a# :Align #<CR>
map <leader>a{ :Align {<CR>
map <leader>A :Align [A-Z].*<CR>:'<,'>s/\s*$//<CR><C-l>
map <leader>= ggVG=<CR>
map <leader>ct :set et <bar> retab<CR>


" =============== autocomplete ====================
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
" autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
" autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

" ================ shortcuts ======================

map <leader>p :sp ~/p/

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Faster saving
map <silent> <leader>w :w<cr>
map <silent> <leader>wa :wa<cr>

map <silent> <leader>bn :bnext<cr>
map <silent> <leader>bd :bdelete<cr>

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

" Delete empty lines
nmap <leader>del :g/^$/d<cr>

" Trim trailing white space
nmap <leader>tws :call StripTrailingWhitespace()<cr>

" Sorting
map <leader>srt :sort<cr>

" Tagbar
map <leader>tt :TagbarToggle<cr>

" remove trailing whitespace automatically
autocmd BufWritePre * :%s/\s\+$//e

" ================ functions ======================
function! StripTrailingWhitespace()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " do the business:
  %s/\s\+$//e
  " clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }
