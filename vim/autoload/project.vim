" =======================================================================
" autoload/project.vim
" =======================================================================
if exists('g:loaded_project') | finish | endif
let g:loaded_project = v:true

" Detect project root directory
function! project#root() abort
  let l:dir = get(b:, 'git_dir', '')
  return l:dir ? fnamemodify(l:dir, ':h') : getcwd()
endfunction

" Find and source project-specific Vim configs
function! project#source_config() abort
  let l:projectfile = findfile('.vim/local.vim', expand('%:p').';')
  if filereadable(l:projectfile)
    execute 'source' l:projectfile
  endif
endfunction
