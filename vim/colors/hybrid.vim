scriptencoding utf-8

" File:       hybrid.vim
" Maintainer: Andrew Wong (w0ng)
" URL:        https://github.com/w0ng/vim-hybrid
" Modified:   27 Jan 2013 07:33 AM AEST
" License:    MIT

" Description: {{{
" ----------------------------------------------------------------------------
" The default RGB colour palette is taken from Tomorrow-Night.vim:
" https://github.com/chriskempson/vim-tomorrow-theme
"
" The reduced RGB colour palette is taken from Codecademy's online editor:
" https://www.codecademy.com/learn
"
" The syntax highlighting scheme is taken from jellybeans.vim:
" https://github.com/nanotech/jellybeans.vim
"
" The is code taken from solarized.vim:
" https://github.com/altercation/vim-colors-solarized

" }}}
" Requirements And Recommendations: {{{
" ----------------------------------------------------------------------------
" Requirements
"   - gVim 7.3+ on Linux, Mac and Windows.
"   - Vim 7.3+ on Linux and Mac, using a terminal that supports 256 colours.
"
" Due to the limited 256 palette, colours in Vim and gVim will still be slightly
" different.
"
" In order to have Vim use the same colours as gVim (the way this colour scheme
" is intended), it is recommended that you define the basic 16 colours in your
" terminal.
"
" For Linux users (rxvt-unicode, xterm):
"
" 1.  Add the default palette to ~/.Xresources:
"
"         https://gist.github.com/3278077
"
"     or alternatively, add the reduced contrast palette to ~/.Xresources:
"
"         https://gist.github.com/w0ng/16e33902508b4a0350ae
"
" 2.  Add to ~/.vimrc:
"
"         let g:hybrid_custom_term_colors = 1
"         let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
"         colorscheme hybrid
"
" For OSX users (iTerm):
"
" 1.  Import the default colour preset into iTerm:
"
"         https://raw.githubusercontent.com/w0ng/dotfiles/master/iterm2/hybrid.itermcolors
"
"     or alternatively, import the reduced contrast color preset into iTerm:
"
"         https://raw.githubusercontent.com/w0ng/dotfiles/master/iterm2/hybrid-reduced-contrast.itermcolors
"
" 2.  Add to ~/.vimrc:
"
"         let g:hybrid_custom_term_colors = 1
"         let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
"         colorscheme hybrid

" }}}
" Initialisation: {{{
" ----------------------------------------------------------------------------

hi clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'hybrid'

" }}}
" GUI Palettes: {{{
" ----------------------------------------------------------------------------

let s:palette = {}

let s:background = '#1d1f21'
let s:selection  = '#373b41'
let s:line       = '#282a2e'
let s:comment    = '#707880'

let s:foreground = '#c5c8c6'
let s:red        = '#cc6666'
let s:orange     = '#de935f'
let s:yellow     = '#f0c674'
let s:green      = '#b5bd68'
let s:aqua       = '#8abeb7'
let s:blue       = '#81a2be'
let s:purple     = '#b294bb'
let s:window     = '#303030'
let s:darkcolumn = '#23252b'
let s:addbg      = '#5f875f'
let s:addfg      = '#d7ffaf'
let s:changebg   = '#5f5f87'
let s:changefg   = '#d7d7ff'
let s:delbg      = s:red
let s:darkblue   = '#00005f'
let s:darkcyan   = '#005f5f'
let s:darkred    = '#5f0000'
let s:darkgreen  = '#8c9440'
let s:darkpurple = '#5f005f'
let s:darkbar    = '#292d34'
let s:gray       = '#585858'

let s:palette.background = s:background
let s:palette.foreground = s:foreground
let s:palette.selection  = s:selection
let s:palette.line       = s:line
let s:palette.comment    = s:comment
let s:palette.red        = s:red
let s:palette.orange     = s:orange
let s:palette.yellow     = s:yellow
let s:palette.green      = s:green
let s:palette.aqua       = s:aqua
let s:palette.blue       = s:blue
let s:palette.purple     = s:purple
let s:palette.window     = s:window
let s:palette.darkcolumn = s:darkcolumn
let s:palette.addbg      = s:addfg
let s:palette.addfg      = s:addbg
let s:palette.changebg   = s:changefg
let s:palette.changefg   = s:changebg
let s:palette.delbg      = s:red
let s:palette.darkblue   = s:darkblue
let s:palette.darkcyan   = s:darkcyan
let s:palette.darkred    = s:darkred
let s:palette.darkgreen  = s:darkgreen
let s:palette.darkpurple = s:darkpurple
let s:palette.darkbar    = s:darkbar
let s:palette.gray       = s:gray

" }}}
" Formatting Options: {{{
" ----------------------------------------------------------------------------
let s:none    = 'NONE'
let s:c       = ',undercurl'
let s:r       = ',reverse'
let s:b       = ',bold'
let s:u       = ',underline'
let s:i       = ',italic'

" }}}
" Highlighting Primitives: {{{
" ----------------------------------------------------------------------------
function! s:build_prim(hi_elem, field)
  " Given a:hi_elem = bg, a:field = comment
  let l:vname = 's:' . a:hi_elem . '_' . a:field " s:bg_comment
  let l:gui_assign = 'gui'.a:hi_elem.'='.s:palette[a:field] " guibg=...
  execute 'let ' . l:vname . ' = '' ' . l:gui_assign . ''''

  " let l:vname  = 's:'  . a:hi_elem . '_' . a:field            " s:bg_comment
  " let l:assign = 'gui' . a:hi_elem . '=' . s:palette[a:field] " guibg=...
  " execute 'let ' . l:vname . ' = '' ' . l:assign . ''''
endfunction

let s:bg_foreground = ''
let s:bg_background = ''
let s:bg_selection = ''
let s:bg_line = ''
let s:bg_comment = ''
let s:bg_red = ''
let s:bg_orange = ''
let s:bg_yellow = ''
let s:bg_green = ''
let s:bg_aqua = ''
let s:bg_blue = ''
let s:bg_purple = ''
let s:bg_window = ''
let s:bg_darkcolumn = ''
let s:bg_addbg = ''
let s:bg_addfg = ''
let s:bg_changebg = ''
let s:bg_changefg = ''
let s:bg_delbg = ''
let s:bg_darkblue = ''
let s:bg_darkcyan = ''
let s:bg_darkred = ''
let s:bg_darkpurple = ''
let s:bg_darkbar = ''
let s:bg_gray = ''

let s:bg_none = ' guibg=NONE ctermbg=NONE'
call s:build_prim('bg', 'foreground')
call s:build_prim('bg', 'background')
call s:build_prim('bg', 'selection')
call s:build_prim('bg', 'line')
call s:build_prim('bg', 'comment')
call s:build_prim('bg', 'red')
call s:build_prim('bg', 'orange')
call s:build_prim('bg', 'yellow')
call s:build_prim('bg', 'green')
call s:build_prim('bg', 'aqua')
call s:build_prim('bg', 'blue')
call s:build_prim('bg', 'purple')
call s:build_prim('bg', 'window')
call s:build_prim('bg', 'darkcolumn')
call s:build_prim('bg', 'addbg')
call s:build_prim('bg', 'addfg')
call s:build_prim('bg', 'changebg')
call s:build_prim('bg', 'changefg')
call s:build_prim('bg', 'delbg')
call s:build_prim('bg', 'darkblue')
call s:build_prim('bg', 'darkcyan')
call s:build_prim('bg', 'darkred')
call s:build_prim('bg', 'darkgreen')
call s:build_prim('bg', 'darkpurple')
call s:build_prim('bg', 'darkbar')
call s:build_prim('bg', 'gray')

let s:fg_addbg = ''
let s:fg_addfg = ''
let s:fg_aqua = ''
let s:fg_background = ''
let s:fg_blue = ''
let s:fg_changebg = ''
let s:fg_changefg = ''
let s:fg_comment = ''
let s:fg_darkbar = ''
let s:fg_darkblue = ''
let s:fg_darkcolumn = ''
let s:fg_darkaqua = ''
let s:fg_darkgreen = ''
let s:fg_darkpurple = ''
let s:fg_darkred = ''
let s:fg_foreground = ''
let s:fg_gray = ''
let s:fg_green = ''
let s:fg_line = ''
let s:fg_orange = ''
let s:fg_purple = ''
let s:fg_red = ''
let s:fg_selection = ''
let s:fg_window = ''
let s:fg_yellow = ''

let s:fg_none = ' guifg=NONE ctermfg=NONE'
call s:build_prim('fg', 'foreground')
call s:build_prim('fg', 'background')
call s:build_prim('fg', 'selection')
call s:build_prim('fg', 'line')
call s:build_prim('fg', 'comment')
call s:build_prim('fg', 'red')
call s:build_prim('fg', 'orange')
call s:build_prim('fg', 'yellow')
call s:build_prim('fg', 'green')
call s:build_prim('fg', 'aqua')
call s:build_prim('fg', 'blue')
call s:build_prim('fg', 'purple')
call s:build_prim('fg', 'window')
call s:build_prim('fg', 'darkcolumn')
call s:build_prim('fg', 'addbg')
call s:build_prim('fg', 'addfg')
call s:build_prim('fg', 'changebg')
call s:build_prim('fg', 'changefg')
call s:build_prim('fg', 'darkblue')
call s:build_prim('fg', 'darkcyan')
call s:build_prim('fg', 'darkred')
call s:build_prim('fg', 'darkgreen')
call s:build_prim('fg', 'darkpurple')
call s:build_prim('fg', 'darkbar')
call s:build_prim('fg', 'gray')

let s:fmt_bold = ''
let s:fmt_none = ''
let s:fmt_revr = ''
let s:fmt_undb = ''
let s:fmt_undr = ''

execute 'let s:fmt_bold = '' gui=NONE'.s:b    .''''
execute 'let s:fmt_none = '' gui=NONE'        .''''
execute 'let s:fmt_revr = '' gui=NONE'.s:r    .''''
execute 'let s:fmt_undb = '' gui=NONE'.s:u.s:b.''''
execute 'let s:fmt_undr = '' gui=NONE'.s:u    .''''

let s:sp_none       = ''
let s:sp_foreground = ''
let s:sp_background = ''
let s:sp_selection  = ''
let s:sp_line       = ''
let s:sp_comment    = ''
let s:sp_red        = ''
let s:sp_orange     = ''
let s:sp_yellow     = ''
let s:sp_green      = ''
let s:sp_aqua       = ''
let s:sp_blue       = ''
let s:sp_purple     = ''
let s:sp_window     = ''
let s:sp_addbg      = ''
let s:sp_addfg      = ''
let s:sp_changebg   = ''
let s:sp_changefg   = ''
let s:sp_darkblue   = ''
let s:sp_darkcyan   = ''
let s:sp_darkred    = ''
let s:sp_darkpurple = ''

execute 'let s:sp_none       = '' guisp='. s:none                   .''''
execute 'let s:sp_foreground = '' guisp='. s:palette.foreground .''''
execute 'let s:sp_background = '' guisp='. s:palette.background .''''
execute 'let s:sp_selection  = '' guisp='. s:palette.selection  .''''
execute 'let s:sp_line       = '' guisp='. s:palette.line       .''''
execute 'let s:sp_comment    = '' guisp='. s:palette.comment    .''''
execute 'let s:sp_red        = '' guisp='. s:palette.red        .''''
execute 'let s:sp_orange     = '' guisp='. s:palette.orange     .''''
execute 'let s:sp_yellow     = '' guisp='. s:palette.yellow     .''''
execute 'let s:sp_green      = '' guisp='. s:palette.green      .''''
execute 'let s:sp_aqua       = '' guisp='. s:palette.aqua       .''''
execute 'let s:sp_blue       = '' guisp='. s:palette.blue       .''''
execute 'let s:sp_purple     = '' guisp='. s:palette.purple     .''''
execute 'let s:sp_window     = '' guisp='. s:palette.window     .''''
execute 'let s:sp_addbg      = '' guisp='. s:palette.addbg      .''''
execute 'let s:sp_addfg      = '' guisp='. s:palette.addfg      .''''
execute 'let s:sp_changebg   = '' guisp='. s:palette.changebg   .''''
execute 'let s:sp_changefg   = '' guisp='. s:palette.changefg   .''''
execute 'let s:sp_darkblue   = '' guisp='. s:palette.darkblue   .''''
execute 'let s:sp_darkcyan   = '' guisp='. s:palette.darkcyan   .''''
execute 'let s:sp_darkred    = '' guisp='. s:palette.darkred    .''''
execute 'let s:sp_darkgreen  = '' guisp='. s:palette.darkgreen  .''''
execute 'let s:sp_darkpurple = '' guisp='. s:palette.darkpurple .''''

" }}}
" Vim Highlighting: (see :help highlight-groups) {{{
" ----------------------------------------------------------------------------
execute 'hi! ColorColumn'     .s:fg_none       .s:bg_line       .s:fmt_none
execute 'hi! Conceal'         .s:fg_red        .s:bg_none       .s:fmt_none
"   Cursor"
"   CursorIM"
execute 'hi! CursorLine'      .s:fg_none       .s:bg_line       .s:fmt_none
execute 'hi! Directory'       .s:fg_blue       .s:bg_none       .s:fmt_none
execute 'hi! DiffAdd'         .s:fg_addfg      .s:bg_addbg      .s:fmt_none
execute 'hi! DiffChange'      .s:fg_changefg   .s:bg_changebg   .s:fmt_none
execute 'hi! DiffDelete'      .s:fg_background .s:bg_delbg      .s:fmt_none
execute 'hi! DiffText'        .s:fg_background .s:bg_blue       .s:fmt_none
execute 'hi! ErrorMsg'        .s:fg_red        .s:bg_none       .s:fmt_none
execute 'hi! VertSplit'       .s:fg_selection  .s:bg_none       .s:fmt_none
execute 'hi! Folded'          .s:fg_comment    .s:bg_line       .s:fmt_none
execute 'hi! FoldColumn'      .s:fg_none       .s:bg_none       .s:fmt_none
execute 'hi! SignColumn'      .s:fg_none       .s:bg_none       .s:fmt_none
execute 'hi! IncSearch'       .s:fg_background .s:bg_orange     .s:fmt_none
execute 'hi! LineNr'          .s:fg_selection  .s:bg_none       .s:fmt_bold
execute 'hi! CursorLineNr'    .s:fg_yellow     .s:bg_none       .s:fmt_bold
execute 'hi! MatchParen'      .s:fg_none       .s:bg_none       .s:fmt_undr
execute 'hi! ModeMsg'         .s:fg_green      .s:bg_none       .s:fmt_none
execute 'hi! MoreMsg'         .s:fg_green      .s:bg_none       .s:fmt_none
execute 'hi! NonText'         .s:fg_selection  .s:bg_none       .s:fmt_none

execute 'hi! Pmenu'           .s:fg_foreground .s:bg_darkbar    .s:fmt_none
execute 'hi! PmenuSel'        .s:fg_foreground .s:bg_background .s:fmt_revr
execute 'hi! PmenuSbar'       .s:fg_background .s:bg_gray       .s:fmt_none
execute 'hi! PmenuThumb'      .s:fg_background .s:bg_none       .s:fmt_none

" execute 'hi! Pmenu'           .s:fg_foreground .s:bg_selection  .s:fmt_none
" execute 'hi! PmenuSel'        .s:fg_foreground .s:bg_selection  .s:fmt_revr
"   PmenuSbar"
"   PmenuThumb"
execute 'hi! Question'        .s:fg_green      .s:bg_none       .s:fmt_none
execute 'hi! Search'          .s:fg_background .s:bg_yellow     .s:fmt_none
execute 'hi! SpecialKey'      .s:fg_selection  .s:bg_none       .s:fmt_none
execute 'hi! SpellCap'        .s:fg_blue       .s:bg_darkblue   .s:fmt_undr
execute 'hi! SpellLocal'      .s:fg_aqua       .s:bg_darkcyan   .s:fmt_undr
execute 'hi! SpellBad'        .s:fg_red        .s:bg_darkred    .s:fmt_undr
execute 'hi! SpellRare'       .s:fg_purple     .s:bg_darkpurple .s:fmt_undr
execute 'hi! StatusLine'      .s:fg_comment    .s:bg_background .s:fmt_none
execute 'hi! StatusLineNC'    .s:fg_window     .s:bg_comment    .s:fmt_revr
execute 'hi! TabLine'         .s:fg_foreground .s:bg_darkcolumn .s:fmt_revr
"   TabLineFill"
"   TabLineSel"
execute 'hi! Title'           .s:fg_yellow     .s:bg_none       .s:fmt_none
execute 'hi! Visual'          .s:fg_none       .s:bg_selection  .s:fmt_none
"   VisualNos"
execute 'hi! WarningMsg'      .s:fg_orange     .s:bg_none       .s:fmt_none
execute 'hi! LongLineWarning' .s:fg_red        .s:bg_none       .s:fmt_none
execute 'hi! WildMenu'        .s:fg_background .s:bg_yellow     .s:fmt_none
" execute 'hi! WildMenu'        .s:fg_blue .s:bg_selection     .s:fmt_none

" Use defined custom background colour for terminal Vim.
execute 'hi! Normal'        .s:fg_foreground  .s:bg_none .s:fmt_none

" }}}
" Neovim Terminal Colors {{{
" ----------------------------------------------------------------------------
let g:terminal_color_0  = s:background " background gray
let g:terminal_color_8  = s:comment " comment gray

let g:terminal_color_1  = s:red " red
let g:terminal_color_9  = s:red " dark red

let g:terminal_color_2  = s:green " green
let g:terminal_color_10 = g:terminal_color_2

let g:terminal_color_3  = s:yellow " yellow
let g:terminal_color_11 = s:orange " dark yellow (actually orange)

let g:terminal_color_4  = s:blue " blue
let g:terminal_color_12 = '#729fcf' " another shade of blue

let g:terminal_color_5  = s:purple " purple
let g:terminal_color_13 = g:terminal_color_5

let g:terminal_color_6  = s:aqua " aqua
let g:terminal_color_14 = s:darkcyan  " dark aqua

let g:terminal_color_7  = '#d3d7cf'
let g:terminal_color_15 = '#707880' " another shade of grade

" }}}
" Vanilla colorscheme ---------------------------------------------------------
" Gutter: {{{

" }}}
" Generic Syntax Highlighting: (see :help group-name) {{{

execute 'hi! Comment'         .s:fg_comment     .s:bg_none        .s:fmt_none

execute 'hi! Constant'        .s:fg_red         .s:bg_none        .s:fmt_none
execute 'hi! String'          .s:fg_green       .s:bg_none        .s:fmt_none
"   Character"
execute 'hi! Character'       .s:fg_green       .s:bg_none        .s:fmt_none
"   Number"
"   Boolean"
"   Float"

execute 'hi! Identifier'      .s:fg_purple      .s:bg_none        .s:fmt_none
execute 'hi! Function'        .s:fg_yellow      .s:bg_none        .s:fmt_none

execute 'hi! Statement'       .s:fg_blue        .s:bg_none        .s:fmt_none
"   Conditional"
"   Repeat"
"   Label"
execute 'hi! Operator'        .s:fg_aqua        .s:bg_none        .s:fmt_none
"   Keyword"
"   Exception"

execute 'hi! PreProc'         .s:fg_aqua        .s:bg_none        .s:fmt_none
"   Include"
"   Define"
"   Macro"
"   PreCondit"

execute 'hi! Type'            .s:fg_orange      .s:bg_none        .s:fmt_none
"   StorageClass"
execute 'hi! Structure'       .s:fg_aqua        .s:bg_none        .s:fmt_none
"   Typedef"

execute 'hi! Special'         .s:fg_green       .s:bg_none        .s:fmt_none
"   SpecialChar"
"   Tag"
"   Delimiter"
execute 'hi! SpecialComment'  .s:fg_comment     .s:bg_none        .s:fmt_none
"   Debug"
"
execute 'hi! Underlined'      .s:fg_blue        .s:bg_none        .s:fmt_none
execute 'hi! Ignore'          .s:fg_none        .s:bg_none        .s:fmt_none
execute 'hi! Error'           .s:fg_red         .s:bg_none        .s:fmt_undr
execute 'hi! Todo'            .s:fg_none        .s:bg_none        .s:fmt_undb

" Quickfix window highlighting
execute 'hi! qfLineNr'        .s:fg_yellow      .s:bg_none        .s:fmt_none
"   qfFileName"
"   qfLineNr"
"   qfError"

" }}}
" Plugin specific -------------------------------------------------------------
" Coc: {{{

execute 'hi! CocErrorSign'   .s:fg_red         .s:bg_none .s:fmt_none
execute 'hi! CocWarningSign' .s:fg_orange      .s:bg_none .s:fmt_none
execute 'hi! CocInfoSign'    .s:fg_yellow      .s:bg_none .s:fmt_none
execute 'hi! CocHintSign'    .s:fg_blue        .s:bg_none .s:fmt_none
execute 'hi! CocSelectedText' .s:fg_red        .s:bg_none .s:fmt_none

" }}}
" Neomake: {{{

execute 'hi! NeomakeErrorSign'   .s:fg_red         .s:bg_none .s:fmt_none

" }}}
" GitGutter: {{{

execute 'hi! GitGutterAdd'    .s:fg_green       .s:bg_none        .s:fmt_none
execute 'hi! GitGutterChange' .s:fg_yellow      .s:bg_none        .s:fmt_none
execute 'hi! GitGutterDelete' .s:fg_red         .s:bg_none        .s:fmt_none

" }}}
" Filetype specific -----------------------------------------------------------
" Diff: {{{

" Diff
"   diffOldFile
"   diffNewFile
"   diffFile
execute 'hi! diffFile'        .s:fg_orange      .s:bg_none        .s:fmt_none
"   diffOnly
"   diffIdentical
"   diffDiffer
"   diffBDiffer
"   diffIsA
"   diffNoEOL
"   diffCommon
" hi! link diffRemoved Constant
execute 'hi! diffRemoved'     .s:fg_red         .s:bg_none        .s:fmt_none
"   diffChanged
" hi! link diffAdded Special
execute 'hi! diffAdded'       .s:fg_green       .s:bg_none        .s:fmt_none
"   diffLine
execute 'hi! diffLine'        .s:fg_purple      .s:bg_none        .s:fmt_none
"   diffSubname
"   diffComment

" }}}
" Vim: {{{

execute 'hi! vimCommentTitle' .s:fg_none         .s:bg_none        .s:fmt_undb

" }}}
" Rust: {{{

" execute 'hi! rustAttribute'      .s:fg_comment   .s:bg_none        .s:fmt_none
" execute 'hi! rustDerive'         .s:fg_comment   .s:bg_none        .s:fmt_none
" execute 'hi! rustDeriveTrait'    .s:fg_comment   .s:bg_none        .s:fmt_none
" execute 'hi! rustFuncName'       .s:fg_none      .s:bg_none        .s:fmt_none
" execute 'hi! rustFuncCall'       .s:fg_none      .s:bg_none        .s:fmt_none
" execute 'hi! rustFunction'       .s:fg_none      .s:bg_none        .s:fmt_none
" execute 'hi! rustModPath'        .s:fg_none      .s:bg_none        .s:fmt_none
" execute 'hi! rustOperator'       .s:fg_none      .s:bg_none        .s:fmt_none
" execute 'hi! rustModPathSep'     .s:fg_none      .s:bg_none        .s:fmt_none
" execute 'hi! rustType'           .s:fg_none      .s:bg_none        .s:fmt_none
" execute 'hi! rustNumber'         .s:fg_orange    .s:bg_none        .s:fmt_none
" execute 'hi! rustStorage'        .s:fg_blue      .s:bg_none        .s:fmt_none

" execute 'hi! rustCommentLine'          .s:fg_comment .s:bg_none .s:fmt_none
" execute 'hi! rustCommentLineDoc'       .s:fg_comment .s:bg_none .s:fmt_none
" execute 'hi! rustCommentLineDocError'  .s:fg_comment .s:bg_none .s:fmt_none
" execute 'hi! rustCommentBlock'         .s:fg_comment .s:bg_none .s:fmt_none
" execute 'hi! rustCommentBlockDoc'      .s:fg_comment .s:bg_none .s:fmt_none
" execute 'hi! rustCommentBlockDocError' .s:fg_comment .s:bg_none .s:fmt_none


" }}}
" Legal: {{{
" ----------------------------------------------------------------------------
" Copyright (c) 2011 Ethan Schoonover
" Copyright (c) 2009-2012 NanoTech
" Copyright (c) 2012 w0ng
"
" Permission is hereby granted, free of charge, to any per‐
" son obtaining a copy of this software and associated doc‐
" umentation files (the “Software”), to deal in the Soft‐
" ware without restriction, including without limitation
" the rights to use, copy, modify, merge, publish, distrib‐
" ute, sublicense, and/or sell copies of the Software, and
" to permit persons to whom the Software is furnished to do
" so, subject to the following conditions:
"
" The above copyright notice and this permission notice
" shall be included in all copies or substantial portions
" of the Software.
"
" THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY
" KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO
" THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICU‐
" LAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
" AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
" DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CON‐
" TRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CON‐
" NECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
" THE SOFTWARE.

" }}}
