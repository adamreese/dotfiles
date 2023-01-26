local lush = require('lush')
local hsluv = lush.hsluv -- Human-friendly hsl
local util = require('zenbones.util')

local bg = hsluv('#282828')
local fg = hsluv('#ebdbb2')

local p = util.palette_extend({
  bg  = bg,
  bg1 = bg.lighten(5),
  bg2 = bg.lighten(10),
  bg3 = bg.lighten(15),
  bg4 = bg.lighten(20),
  bg5 = bg.lighten(25),
  fg  = fg,
  fg1 = fg.da(10),
  fg2 = fg.da(14),
  fg3 = fg.da(20),
  fg4 = fg.da(24),
  fg5 = fg.da(30),
  fg6 = fg.da(42),

  rose    = hsluv('#ea6962'),
  red     = hsluv('#ea6962'),
  leaf    = hsluv('#a9b665'),
  green   = hsluv('#a9b665'),
  wood    = hsluv('#d6b676'),
  yellow  = hsluv('#d6b676'),
  water   = hsluv('#7daea3'),
  blue    = hsluv('#7daea3'),
  blossom = hsluv('#d3869b'),
  purple  = hsluv('#d3869b'),
  sky     = hsluv('#89b482'),
  cyan    = hsluv('#89b482'),
  orange  = hsluv('#e08d5d'),
  grey0   = hsluv('#7c6f64'),
  grey1   = hsluv('#928374'),
  grey2   = hsluv('#a89984'),
}, 'dark')

return p

-- vim.tbl_map( function(x) return x.hex end, R('ar.colors.gruvbones'))
