" .gvimrc

" Display the tab bar if there is more than one tab
set showtabline=1

" Turn off the blinking cursor in normal mode
set gcr=n:blinkon0

" Automatically read changed files
set autoread

set guifont=Inconsolata-dz:h12

if has("gui_macvim")
  " Hide the MacVim toolbar
  set go-=T

  " Disable scrollbars
  set guioptions-=r
  set guioptions-=R
  set guioptions-=l
  set guioptions-=L


  " Fullscreen takes up entire screen
  set fuoptions=maxhorz,maxvert

  " Command-Shift-F for Ack
  macmenu Window.Toggle\ Full\ Screen\ Mode key=<nop>
  map <D-F> :Ack<space>

  " Command-/ to toggle comments
  map <D-/> <plug>NERDCommenterToggle<CR>

  " tab navigation
  map <M-D-Right> :tabnext<CR>
  map <M-D-Left> :tabprev<CR>
endif
