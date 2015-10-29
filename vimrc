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
set scrolloff=7                 "Set 7 lines to the cursor - when moving vertically using j/k
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

" Save files when vim loses focus
au FocusLost * silent! wa

" disable ex mode
:map Q <Nop>

" disable ri check
:map K <Nop>

" =============== vim-plug Initialization ===============
" This loads all the plugins specified in ~/.vimrc.bundles

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

"Filetype plugin indent
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
set linebreak              "Wrap lines at convenient points

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

" ============== File Type settings ==================

if has("autocmd")
augroup filetype_ruby
  autocmd!
  autocmd FileType ruby set tabstop=2|set shiftwidth=2|set expandtab|set autoindent
augroup END

augroup filetype_haml
  autocmd!
  autocmd FileType haml set tabstop=2|set shiftwidth=2|set expandtab|set autoindent
augroup END

augroup filetype_yaml
  autocmd!
  autocmd FileType yaml set tabstop=2|set shiftwidth=2|set expandtab|set autoindent
augroup END

augroup filetype_perl
  autocmd!
  autocmd FileType perl set tabstop=8|set shiftwidth=8|set noexpandtab|set nolist
augroup END

augroup filetype_go
  autocmd!

  autocmd FileType go set tabstop=4|set shiftwidth=4|set expandtab|set autoindent|set nolist

  autocmd FileType go nmap <Leader>dc  <Plug>(go-doc)
  autocmd FileType go nmap <Leader>ce  <Plug>(go-callees)
  autocmd FileType go nmap <Leader>cl  <Plug>(go-callers)
  autocmd FileType go nmap <Leader>cs  <Plug>(go-callstack)
  autocmd FileType go nmap <Leader>d   <Plug>(go-describe)
  autocmd FileType go nmap <Leader>in  <Plug>(go-info)
  autocmd FileType go nmap <Leader>ii  <Plug>(go-implements)
  autocmd FileType go nmap <Leader>r   <Plug>(go-referrers)
  autocmd FileType go nmap <Leader>f   :GoImports<CR>

augroup END
endif

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
set foldmethod=manual   "fold based on syntax
set foldnestmax=9       "deepest fold is 3 levels
set nofoldenable        "dont fold by default
let xml_syntax_folding=1

" ================ Completion =======================
set wildmode=list:longest
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set complete-=i             "do not scan included files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.log,.git

" grep
map <leader>a :Ag<space>
map <leader>a* :Ag<space><cword><CR>
let g:ag_prg="ag --vimgrep --smart-case --nogroup --nocolor --skip-vcs-ignores"

set grepprg=ag\ --nogroup\ --nocolor
if &grepformat !~# '%c'
  set grepformat^=%f:%l:%c:%m
endif

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
  set statusline=%<%f\                       " Filename
  set statusline+=%w%h%m%r                   " Options
  set statusline+=\ %=[%{&ff}/%Y]            " Filetype
  set statusline+=\ %{fugitive#statusline()} " Git Hotness
endif

" ================ shortcuts ======================

" Format buffer
map <leader>= ggVG=<CR>

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

" Sorting
map <leader>srt :sort<cr>

" remove trailing whitespace automatically
autocmd BufWritePre * :%s/\s\+$//e

map <leader>r19 :s/\v:([0-9a-z_]+)\s+\=\>\s+/\1: /g<CR>
map <leader>r18 :s/\v([0-9a-z_"']+):\s+(.*)/:\1 => \2/g<CR>

" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

" ================ functions ======================

if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" ================ Plugin Settings ======================

" vim-align
map <leader>ah :Align =><CR>
nnoremap <leader>a= :Align =<CR>
map <leader>a# :Align #<CR>
map <leader>a{ :Align {<CR>

" CtrlP
map <leader>cf :ClearCtrlPCache<CR>
map <leader>gb :CtrlPBuffer<CR>
map <leader>gc :CtrlP app/controllers<CR>
map <leader>gm :CtrlP app/models<CR>
map <leader>gv :CtrlP app/views<CR>
map <leader>gl :CtrlP lib<CR>
map <leader>gs :CtrlP spec<CR>

" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
let g:ctrlp_user_command = 'ag %s -l --nocolor -g "" --skip-vcs-ignores'
"let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'

" ag is fast enough that CtrlP doesn't need to cache
let g:ctrlp_use_caching = 0

" nerdtree
let g:NERDTreeMinimalUI=1
map <leader>e :NERDTreeFind<CR>

" EasyAlign
vmap <Enter> <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" vim-go
let g:go_fmt_fail_silently = 0
let g:go_fmt_command = 'goimports'
let g:go_autodetect_gopath = 1

" tagbar
map <leader>tt :TagbarToggle<cr>

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

" vim-rspec
let g:rspec_runner = "os_x_iterm2"
let g:rspec_command = "br {spec}"
map <Bslash>t :call RunCurrentSpecFile()<CR>
map <Bslash>s :call RunNearestSpec()<CR>
map <Bslash>l :call RunLastSpec()<CR>
map <Bslash>a :call RunAllSpecs()<CR>

" airline
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline_left_sep=''
let g:airline_left_alt_sep=''
let g:airline_right_sep=''
let g:airline_right_alt_sep=''

" neocomplete
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_auto_delimiter = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#max_list = 10
set completeopt-=preview
