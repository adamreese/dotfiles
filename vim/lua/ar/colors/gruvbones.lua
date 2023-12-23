local lush = require('lush')
local hsluv = lush.hsluv
local util = require('zenbones.util')

local bg = hsluv('#282828').lighten(2)
local bg = hsluv('#32302f').darken(10)
local fg = hsluv('#ebdbb2')

local p = util.palette_extend({
  bg               = bg,
  bg0              = bg,
  bg1              = bg.lighten(5),  -- #363433
  bg2              = bg.lighten(10), -- #3F3D3C
  bg3              = bg.lighten(15), -- #494645
  bg4              = bg.lighten(20), -- #524F4E
  bg5              = bg.lighten(25), -- #5E5B5A
  fg               = fg,
  fg1              = fg.darken(10),  -- #D2C39A
  fg2              = fg.darken(14),  -- #C9BA94
  fg3              = fg.darken(20),  -- #B8AA87
  fg4              = fg.darken(24),  -- #AFA280
  fg5              = fg.darken(30),  -- #A19576
  fg6              = fg.darken(42),  -- #83795F
  rose             = hsluv('#ea6962'),
  red              = hsluv('#ea6962'),
  leaf             = hsluv('#a9b665'),
  green            = hsluv('#a9b665'),
  wood             = hsluv('#d6b676'),
  yellow           = hsluv('#d6b676'),
  water            = hsluv('#7daea3'),
  blue             = hsluv('#7daea3'),
  blossom          = hsluv('#d3869b'),
  purple           = hsluv('#d3869b'),
  sky              = hsluv('#89b482'),
  cyan             = hsluv('#89b482'),
  orange           = hsluv('#e08d5d'),
  grey0            = hsluv('#7c6f64'),
  grey1            = hsluv('#928374'),
  grey2            = hsluv('#a89984'),
  bg_statusline1   = hsluv('#3c3836'),
  bg_statusline2   = hsluv('#46413e'),
  bg_statusline3   = hsluv('#5b534d'),
  bg_diff_green    = hsluv('#3d4220'),
  bg_visual_green  = hsluv('#424a3e'),
  bg_diff_red      = hsluv('#472322'),
  bg_visual_red    = hsluv('#543937'),
  bg_diff_blue     = hsluv('#0f3a42'),
  bg_visual_blue   = hsluv('#404946'),
  bg_visual_yellow = hsluv('#574833'),
  bg_current_word  = hsluv('#45403d'),
  bg_red           = hsluv('#ea6962'),
  bg_green         = hsluv('#a9b665'),
  bg_yellow        = hsluv('#d8a657'),
}, 'dark')

return p

-- vim.tbl_map( function(x) return x.hex end, R('ar.colors.gruvbones'))
