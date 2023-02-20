---@diagnostic disable: undefined-global
local lush = require('lush')
local generator = require('zenbones.specs')
local p = require('ar.colors.gruvbones')

local colors_name = 'gruvbones'
vim.g.colors_name = colors_name

local zenbones = generator.generate(p, 'dark', generator.get_global_config(colors_name, 'dark'))
local specs = lush.extends({ zenbones }).with(function(injected_functions)
  local sym = injected_functions.sym

  return {
    None { fg = 'NONE' },

    Fg({ fg = p.fg }),
    Blue({ fg = p.water }),
    Cyan({ fg = p.sky }),
    Green({ fg = p.leaf }),
    Orange({ fg = p.orange }),
    Purple({ fg = p.blossom }),
    Red({ fg = p.rose }),
    Yellow({ fg = p.wood }),
    Grey({ fg = p.bg.lighten(46) }),

    BlueItalic({ Blue, gui = 'italic' }),
    CyanItalic({ Cyan, gui = 'italic' }),
    GreenItalic({ Green, gui = 'italic' }),
    OrangeItalic({ Orange, gui = 'italic' }),
    PurpleItalic({ Purple, gui = 'italic' }),
    RedItalic({ Red, gui = 'italic' }),
    YellowItalic({ Yellow, gui = 'italic' }),

    BlueBold({ Blue, gui = 'bold' }),
    CyanBold({ Cyan, gui = 'bold' }),
    GreenBold({ Green, gui = 'bold' }),
    OrangeBold({ Orange, gui = 'bold' }),
    PurpleBold({ Purple, gui = 'bold' }),
    RedBold({ Red, gui = 'bold' }),
    YellowBold({ Yellow, gui = 'bold' }),

    -- Statement { Green },
    -- PreProc { fg = p.sky },
    -- Type { fg = p.water },

    Keyword { fg = p.rose.de(12), gui = 'bold' },
    Special { Yellow },
    Number { zenbones.Number, fg = p.wood.de(30) },
    String { zenbones.Constant, fg = p.water.de(20).li(10) },

    sym '@operator' { zenbones.Normal },

    StatusLineNC { bg = zenbones.StatusLine.bg },

    SpellBad { zenbones.SpellBad, gui = 'underdouble' },
    SpellCap({ fg = p.water, gui = 'undercurl', sp = p.water }),
    SpellLocal({ fg = p.sky, bg = 'NONE', gui = 'undercurl', sp = p.sky }),
    SpellRare({ fg = p.blossom, bg = 'NONE', gui = 'undercurl', sp = p.blossom }),

    -- Special { Blue },
    -- Type { YellowItalic },
    -- Constant { Cyan },
    -- CursorLine { bg = p.bg.li(6) },

    QuickFixLine { underline = true },

    zshCommands { Blue },
    zshConditional { Blue },
    zshDeref { Green },
    zshFunction { GreenBold },
    zshOptStart { PurpleItalic },
    zshOption { Blue },
    zshString { Yellow },
    zshSubst { None },
    zshSubstQuoted { zshString },
    zshSubstDelim { None },
    -- zshTypes { Yellow },
    zshVariableDef { None },

    -- zshSubst { Yellow },
    -- zshDeref { Blue },
    zshTypes { Orange },

    -- Plugins {{{
    CmpItemAbbrMatch { Green, gui = 'bold' },
    CmpItemAbbrMatchFuzzy { Green, gui = 'bold' },
    CmpItemAbbr { Fg },
    CmpItemAbbrDeprecated { Grey },
    CmpItemMenu { Fg },
    CmpItemKind { Yellow },
    CmpItemKindText { Fg },
    CmpItemKindMethod { Green },
    CmpItemKindFunction { Green },
    CmpItemKindConstructor { Green },
    CmpItemKindField { Green },
    CmpItemKindVariable { Blue },
    CmpItemKindClass { Yellow },
    CmpItemKindInterface { Yellow },
    CmpItemKindModule { Yellow },
    CmpItemKindProperty { Blue },
    CmpItemKindUnit { Purple },
    CmpItemKindValue { Purple },
    CmpItemKindEnum { Yellow },
    CmpItemKindKeyword { Red },
    CmpItemKindSnippet { Cyan },
    CmpItemKindColor { Cyan },
    CmpItemKindFile { Cyan },
    CmpItemKindReference { Cyan },
    CmpItemKindFolder { Cyan },
    CmpItemKindEnumMember { Purple },
    CmpItemKindConstant { Blue },
    CmpItemKindStruct { Yellow },
    CmpItemKindEvent { Orange },
    CmpItemKindOperator { Orange },
    CmpItemKindTypeParameter { Yellow },


    -- CmpItemKindFunction { Purple },
    -- CmpItemKindInterface { Blue },
    -- CmpItemKindKeyword { Purple },
    -- CmpItemKindMethod { Purple },
    -- CmpItemKindText { Blue },
    -- CmpItemKindVariable { Blue },

    GitSignsAddNr { Green },
    GitSignsChangeNr { Blue },
    GitSignsDeleteNr { Red },
    GitSignsAddLn { base.DiffAdd },
    GitSignsChangeLn { base.DiffChange },
    GitSignsDeleteLn { base.DiffDelete },

    NeoTreeNormal { zenbones.Normal },
    NeoTreeDirectoryIcon { Blue },
    NeoTreeDirectoryName { Blue },
    NeoTreeRootName { zenbones.Comment },

    NeoTreeGitAdded { Orange },
    NeoTreeGitConflict { Orange },
    NeoTreeGitIgnored { fg = p.fg1 },
    NeoTreeGitModified { Orange },
    NeoTreeGitRenamed { Blue },
    NeoTreeGitUnstaged { Yellow },
    NeoTreeGitUntracked { Cyan },

    NotifyINFOBody { Green },
    NotifyINFOBorder { Green },
    NotifyINFOIcon { Green },
    NotifyINFOTitle { Green },

    NotifyWARNBody { Orange },
    NotifyWARNBorder { Orange },
    NotifyWARNIcon { Orange },
    NotifyWARNTitle { Orange },

    CodeBlock({ bg = p.bg }),
    Headline({ bg = p.bg1, gui = 'bold,italic' }),
    Headline1({ bg = p.bg3, gui = 'bold,italic' }),
    Headline2({ bg = p.bg2, gui = 'bold,italic' }),
    Headline3({ bg = p.bg1, gui = 'bold,italic' }),
    -- }}}

  }
end)

lush(specs)

require('zenbones.term').apply_colors(p)
