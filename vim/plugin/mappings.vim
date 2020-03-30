" =======================================================================
" plugin/mappings.vim
" =======================================================================

" Exit insert mode
inoremap jj <ESC>

" map Q for formatting rather than Ex mode
nnoremap Q m`gqap``
vnoremap Q gq

" disable ex mode
nnoremap gQ <Nop>

" disable q window
noremap q: :q

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Make dot work in visual mode
vnoremap . :norm.<CR>

" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk

" Remap H and L (top, bottom of screen to left and right end of line).
nnoremap H g^
nnoremap L g$
vnoremap H g^
vnoremap L g_

" Better split switching
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" Split sizing
nnoremap <C-=> <C-W>=

" Previous buffer
nnoremap  <BS>  <C-^>

" Center screen
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

nnoremap <expr> <CR> empty(&buftype) ? '}' : '<CR>'
onoremap <expr> <CR> empty(&buftype) ? '}' : '<CR>'

" Spelling fix
nnoremap <C-S> [s1z=<C-O>
inoremap <C-S> <C-G>u<Esc>[s1z=`]A<C-G>u

" Command mode emacs style bindings
cnoremap <C-A> <Home>
cnoremap <C-B> <Left>
cnoremap <C-D> <Del>
cnoremap <C-F> <Right>
cnoremap <C-N> <Down>
cnoremap <C-P> <Up>

" -----------------------------------------------------------------------
" Mapping: Leader
" -----------------------------------------------------------------------

" Source vimrc
nnoremap <leader>sv :<C-u>source $MYVIMRC<CR>

" Fast saving
nnoremap <silent><leader>w :<C-u>write!<CR>
nnoremap <silent><leader>q :<C-u>quit!<CR>
nnoremap <silent><leader>Q :<C-u>qall!<CR>

" Close quickfix/location window
nnoremap <leader>c :<C-u>cclose<bar>lclose<CR>

" Source the current Vim file
nnoremap <leader>pr :<C-u>source %<CR>

" Format buffer
nnoremap <leader>= ggVG=<CR>

" Toggle spell checking
nnoremap <silent><leader>ss :<C-u>setlocal spell!<CR>

" Toggle wrapping
nnoremap <leader>tw :<C-u>setlocal wrap! breakindent! wrap?<CR>

" Sorting
vnoremap <leader>srt :<C-u>sort<CR>

if g:nvim
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
