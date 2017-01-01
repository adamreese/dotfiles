command! SynStack call vimrc#synstack()

command! -bang Profile call vimrc#profile(<bang>0)

command! ReloadSyntax :syntax sync fromstart
