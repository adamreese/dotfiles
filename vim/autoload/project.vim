" =======================================================================
" autoload/project.vim
" =======================================================================
if exists('g:loaded_project') | finish | endif
let g:loaded_project = 1

" Detect project root directory
function! project#root() abort
  if exists('b:git_dir') && !empty(b:git_dir)
    return fnamemodify(b:git_dir, ':h')
  endif
  return getcwd()
endfunction

" Find and source project-specific Vim configs
function! project#source_config() abort
  let l:projectfile = findfile('.vimrc.local', expand('%:p').';')
  if filereadable(l:projectfile)
    execute 'source' l:projectfile
  endif
endfunction

" -----------------------------------------------------------------------
" vim:foldmethod=marker
