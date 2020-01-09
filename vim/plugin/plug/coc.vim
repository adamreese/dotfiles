" =======================================================================
" plugin/plug/coc.vim
" =======================================================================
scriptencoding utf-8

if !ar#is_loaded('coc.nvim') | finish | endif

let s:cpo_save = &cpoptions
set cpoptions&vim

" let g:coc_node_args = ['--nolazy', '--inspect-brk=6045']

let g:coc_node_path           = exepath('node')
let g:coc_status_warning_sign = '  '
let g:coc_status_error_sign   = '  '

let g:coc_global_extensions   = [
      \ 'coc-json',
      \ 'coc-lists',
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

silent! nunmap gd
silent! nunmap K

nnoremap gd        <Plug>(coc-definition)
nnoremap <silent>K :<C-U>call <SID>ShowDocumentation()<CR>

nmap <silent><leader>gi <Plug>(coc-implementation)
nmap <silent><leader>gr <Plug>(coc-references)

" nmap     <leader>ac <Plug>(coc-codeaction)
" nmap     <leader>gi <Plug>(coc-implementation)
nmap     <Leader>=  <Plug>(coc-format-selected)
vmap     <Leader>=  <Plug>(coc-format-selected)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

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
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let l:col = col('.') - 1
  return !l:col || getline('.')[l:col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'

"
" ---- coc-git
"
" navigate chunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
" show chunk diff at current position
" nmap gs <Plug>(coc-git-chunkinfo)
" show commit ad current position
" nmap gc <Plug>(coc-git-commit)
" nnoremap <Leader>tgg :<C-u>CocCommand git.toggleGutters<CR>

"
" ---- coc-yank
"
" nnoremap <space>y  :<C-u>CocList -A --normal yank<cr>


" -----------------------------------------------------------------------

" highlight! link CocErrorSign   ErrorMsg
" highlight! link CocWarningSign WarningMsg
" highlight! link CocInfoSign    Type

" -----------------------------------------------------------------------

augroup ar_coc
  autocmd!
  autocmd User CocJumpPlaceholder  call CocActionAsync('showSignatureHelp')
  autocmd User CocStatusChange     call lightline#update()
  autocmd User CocDiagnosticChange call lightline#update()

  " Restart Coc when settings are updated
  autocmd BufWritePost coc-settings.json CocRestart

  " Auto-close preview window when completion is done.
  autocmd CompleteDone * pclose


  " autocmd CursorHoldI * call CocActionAsync('showSignatureHelp')
augroup END

" -----------------------------------------------------------------------
let &cpoptions = s:cpo_save
unlet s:cpo_save
