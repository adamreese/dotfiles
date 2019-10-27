" https://github.com/scrooloose/nerdtree/issues/807
" remove the slashes after each directory node
setlocal conceallevel=3
syntax match NERDTreeDirSlash #/$# containedin=NERDTreeDir conceal contained
