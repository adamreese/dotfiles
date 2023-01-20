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
  for l:file in ['.vim/local.vim', '.vim/local.lua']
    let l:projectfile = findfile(l:file, expand('%:p').';')
    if filereadable(l:projectfile)

      execute 'source ' . l:projectfile
    endif
  endfor
endfunction
