let s:base00 = ['#181818',  0] " ---- black
let s:base01 = ['#282A2E', 18] " ---
let s:base02 = ['#303030', 19] " --
let s:base03 = ['#373B41',  8] " -
let s:base04 = ['#B8B8B8', 20] " +
let s:base05 = ['#C5C8C6',  7] " ++
let s:base06 = ['#E8E8E8', 21] " +++
let s:base07 = ['#F8F8F8', 15] " ++++ white

let s:base08 = ['#CC6666',  1] " red
let s:base09 = ['#DC9656', 16] " orange
let s:base0A = ['#F0C674',  3] " yellow
let s:base0B = ['#B5BD68',  2] " green
let s:base0C = ['#8ABEB7',  6] " teal
let s:base0D = ['#81A2BE',  4] " blue
let s:base0E = ['#B294BB',  5] " pink
let s:base0F = ['#A16946', 17] " brown

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

" let s:p.{mode}.{where} = [[{guifg}, {guibg}, {ctermfg}, {ctermbg}], ...]

let s:p.normal.left     = [[s:base04, s:base03], [s:base04, s:base02], [s:base05, s:base01]]
let s:p.insert.left     = [[s:base00, s:base0D]]
let s:p.visual.left     = [[s:base00, s:base09]]
let s:p.replace.left    = [[s:base00, s:base08]]
let s:p.inactive.left   = [[s:base04, s:base02], [s:base04, s:base01]]

let s:p.normal.middle   = [[s:base04, s:base02]]
let s:p.inactive.middle = [[s:base04, s:base02]]
let s:p.insert.middle   = [[s:base04, s:base02]]
let s:p.visual.middle   = [[s:base04, s:base02]]

let s:p.normal.right    = [[s:base05, s:base03]]
let s:p.inactive.right  = [[s:base04, s:base01]]

let s:p.normal.error    = [[s:base0A, s:base08]]
let s:p.normal.warning  = [[s:base08, s:base0A]]
let s:p.normal.info     = [[s:base01, s:base0D]]

let s:p.tabline.left    = [[s:base05, s:base02]]
let s:p.tabline.middle  = [[s:base05, s:base01]]
let s:p.tabline.right   = [[s:base05, s:base02]]
let s:p.tabline.tabsel  = [[s:base02, s:base0D]]

let g:lightline#colorscheme#ar#palette = lightline#colorscheme#flatten(s:p)
