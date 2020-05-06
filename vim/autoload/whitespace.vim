" =======================================================================
" autoload/whitespace.vim
" =======================================================================
if exists('g:loaded_whitespace') | finish | endif
let g:loaded_whitespace = v:true

function! whitespace#Clean() abort
  if !empty(&buftype) | return | end

  if get(g:, 'whitespace_enable', v:true)
    let l:pos = winsaveview()
    let l:search=@/

    execute '%s/\s\+$//e'

    let @/=l:search
    call winrestview(l:pos)
  end
endfunction
