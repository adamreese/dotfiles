" =======================================================================
" plugin/plug/coc.vim
" =======================================================================
scriptencoding utf-8

if !ar#IsLoaded('coc.nvim') | finish | endif

let s:cpo_save = &cpoptions
set cpoptions&vim

let g:coc_node_path           = exepath('node')
let g:coc_status_warning_sign = '  '
let g:coc_status_error_sign   = '  '

let g:coc_global_extensions   = [
      \ 'coc-diagnostic',
      \ 'coc-dictionary',
      \ 'coc-json',
      \ 'coc-lists',
      \ 'coc-rls',
      \ 'coc-snippets',
      \ 'coc-tslint',
      \ 'coc-tsserver',
      \ 'coc-vimlsp',
      \ 'coc-yaml',
      \ ]

function! s:ShowDocumentation() abort
  if (index(['vim','help'], &filetype) >= 0)
    execute 'help ' . expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" monastery mappings
silent! nunmap gd
silent! nunmap gs
silent! nunmap K

nmap <silent>gd  :<C-u>call CocActionAsync('jumpDefinition', 'edit')<CR>
nmap <silent>gdt <Plug>(coc-type-definition)
nmap <silent>gs  :<C-u>call CocActionAsync('jumpDefinition', 'split')<CR>
nmap <silent>K   :<C-u>call <SID>ShowDocumentation()<CR>

nmap <silent><Leader>gi     <Plug>(coc-implementation)
nmap <silent><Leader>gr     <Plug>(coc-references)
nmap <silent><Leader>r      <Plug>(coc-refactor)
nmap <silent><Leader>=      <Plug>(coc-format-selected)
vmap <silent><Leader>=      <Plug>(coc-format-selected)
nmap <silent><Leader>ca     <Plug>(coc-codeaction)

" Diagnostics
nmap <silent><Leader>d      <Plug>(coc-diagnostic-info)
nmap <silent> ]d            <Plug>(coc-diagnostic-next)
nmap <silent> [d            <Plug>(coc-diagnostic-prev)

" Use `:CocFormat` for format current buffer
command! -nargs=0 CocFormat call CocAction('format')

" Use `:CocFold` for fold current buffer
command! -nargs=? CocFold call CocAction('fold', <f-args>)

" use `:CocOR` for organize import of current buffer
command! -nargs=0 CocOR call CocAction('runCommand', 'editor.action.organizeImport')

" -----------------------------------------------------------------------

"
" ---- coc-snippets
"
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
" vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
" let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
" let g:coc_snippet_prev = '<c-k>'

" Use <C-k> for both expand and jump (make expand higher priority.)
imap <C-k> <Plug>(coc-snippets-expand-jump)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>CheckBackSpace() ? "\<TAB>" :
      \ coc#refresh()

function! s:CheckBackSpace() abort
  let l:col = col('.') - 1
  return !l:col || getline('.')[l:col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'

" -----------------------------------------------------------------------

augroup ar_coc
  autocmd!
  autocmd User CocDiagnosticChange,CocStatusChange call lightline#update()
  autocmd BufWritePost coc-settings.json CocRestart
augroup END

" -----------------------------------------------------------------------
let &cpoptions = s:cpo_save
unlet s:cpo_save
