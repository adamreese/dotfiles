" =======================================================================
" autoload/project.vim
" =======================================================================
if exists('g:loaded_project') | finish | endif
let g:loaded_project = v:true

" Detect project root directory
function! project#Root() abort
  let l:dir = get(b:, 'git_dir', '')
  return l:dir ? fnamemodify(l:dir, ':h') : getcwd()
endfunction

" Find and source project-specific Vim configs
function! project#SourceConfig() abort
  let l:projectfile = findfile('.vim/local.vim', expand('%:p').';')
  if filereadable(l:projectfile)
    echom 'loading '. l:projectfile
    execute 'source ' . l:projectfile
  endif
endfunction
