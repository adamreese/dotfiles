" =======================================================================
" plugin/mappings.vim
" =======================================================================

" disable ex mode
nnoremap  Q <Nop>
nnoremap gQ <Nop>

" disable ri check
noremap K <Nop>

" disable q window
noremap q: :q

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

" Split sizing
nnoremap <C-=>   <C-W>=

" Window cycling
nnoremap <Tab>   <C-w>w
nnoremap <S-Tab> <C-w>W

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when moving up and down
noremap <C-d> <C-d>zz
noremap <C-u> <C-u>zz

" QuickFix navigation
nnoremap ]q :cnext<CR>zz
nnoremap [q :cprevious<CR>zz

" Location list navigation
nnoremap ]l :lnext<CR>zz
nnoremap [l :lprevious<CR>zz

" Error mnemonic (Neomake uses location list)
nnoremap ]e :lnext<CR>zz
nnoremap [e :lprevious<CR>zz

" -----------------------------------------------------------------------
" Mapping: Leader
" -----------------------------------------------------------------------

" Edit vimrc
nnoremap <leader>ev :tabedit $MYVIMRC<CR>
nnoremap <leader>sv :source  $MYVIMRC<CR>

" Fast saving
nnoremap <silent> <leader>w :write!<CR>
nnoremap <silent> <leader>q :quit!<CR>

" Remove search highlight
nnoremap <silent> <leader><CR> :nohlsearch<CR>

" Close quickfix/location window
nnoremap <leader>c :cclose<bar>lclose<CR>

" Source the current Vim file
nnoremap <leader>pr :source %<CR>

" Format buffer
nnoremap <leader>= ggVG=<CR>

" Pressing ,ss will toggle and untoggle spell checking
nnoremap <leader>ss :setlocal spell!<CR>

" Sorting
vnoremap <leader>srt :sort<CR>

" Make horizontal line
nnoremap <leader>L mzO<esc>79i-<esc>`z

if has('nvim')
  " Leader q to exit terminal mode. Somehow it jumps to the end, so jump to
  " the top again
  tnoremap <leader>q <C-\><C-n>gg<CR>
endif

" -----------------------------------------------------------------------
" Mapping: Copy & Paste
" -----------------------------------------------------------------------

" Reselect last-pasted text
nnoremap gp `[v`]

" Copy to system clipboard
nnoremap <silent> <leader>y "*y
nnoremap <silent> <leader>Y "*Y
vnoremap <silent> <leader>y "*y
vnoremap <silent> <leader>Y "*Y

" Paste from system clipboard
nnoremap <silent> <leader>,p "*p

" -----------------------------------------------------------------------
" vim:foldmethod=marker
