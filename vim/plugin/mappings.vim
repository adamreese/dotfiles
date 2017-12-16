" =======================================================================
" plugin/mappings.vim
" =======================================================================

" Exit insert mode
inoremap jj <ESC>

" disable ex mode
nnoremap  Q <Nop>
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

" Better split switching
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" Split sizing
nnoremap <C-=> <C-W>=

" Window cycling
nnoremap <Tab>   <C-w>w
nnoremap <S-Tab> <C-w>W

" Same when moving up and down
noremap <C-d> <C-d>zz
noremap <C-u> <C-u>zz

" Command mode emacs style bindings
cnoremap <C-a> <Home>
cnoremap <C-d> <Del>

" -----------------------------------------------------------------------
" Mapping: Leader
" -----------------------------------------------------------------------

" Source vimrc
nnoremap <leader>sv :<C-u>source $MYVIMRC<CR>

" Fast saving
nnoremap <silent><leader>w :<C-u>write!<CR>
nnoremap <silent><leader>q :<C-u>quit!<CR>

" Remove search highlight
" nnoremap <silent><leader><CR> :<C-u>nohlsearch<CR>

" Close quickfix/location window
nnoremap <leader>c :<C-u>cclose<bar>lclose<CR>

" Source the current Vim file
nnoremap <leader>pr :<C-u>source %<CR>

" Format buffer
nnoremap <leader>= ggVG=<CR>

" Toggle spell checking
nnoremap <leader>ss :<C-u>setlocal spell!<CR>

" Sorting
vnoremap <leader>srt :<C-u>sort<CR>

if g:nvim
  " Leader q to exit terminal mode. Somehow it jumps to the end, so jump to
  " the top again
  tnoremap <leader>q <C-\><C-n>gg<CR>
endif

" Save changes to a readonly file with sudo
cmap w!! w !sudo tee %

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

" Modeline {{{1
" -----------------------------------------------------------------------
" vim:foldmethod=marker
