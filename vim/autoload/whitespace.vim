" =======================================================================
" autoload/whitespace.vim
" =======================================================================
if exists('g:loaded_whitespace') | finish | endif
let g:loaded_whitespace = v:true

let g:whitespace_enable = get(g:, 'whitespace_enable', v:true)

function! whitespace#Toggle() abort
  let g:whitespace_enable = !g:whitespace_enable
endfunction

" trim trailing whitespace from lines
function! whitespace#TrimTrailingSpace() abort
  if !empty(&buftype)     | return | end
  if !g:whitespace_enable | return | end

  let l:pos = winsaveview()
  let l:search=@/

  execute '%s/\s\+$//e'

  let @/=l:search
  call winrestview(l:pos)
endfunction

" remove trailing blank lines
function! whitespace#RemoveTrailingLines() abort
  if !empty(&buftype)     | return | end
  if !g:whitespace_enable | return | end

  let l:line = line('$')
  while l:line > 0 && empty(getline(l:line))
    let l:line -= 1
  endwhile

  if line('$') - l:line
    call deletebufline(bufnr(), l:line + 1, line('$'))
  endif
endfunction
