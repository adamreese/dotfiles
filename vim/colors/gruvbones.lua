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
    Normal { bg = p.bg, fg = p.fg },

    Underlined { gui = 'underline' },
    Bold { gui = 'bold' },
    Italic { gui = 'italic' },

    Blue({ fg = p.blue }),
    Cyan({ fg = p.cyan }),
    Green({ fg = p.green }),
    Orange({ fg = p.orange }),
    Purple({ fg = p.purple }),
    Red({ fg = p.red }),
    Yellow({ fg = p.yellow }),
    Grey({ fg = p.bg.lighten(46) }),

    BlueItalic({ Blue, gui = 'italic' }),
    CyanItalic({ Cyan, gui = 'italic' }),
    GreenItalic({ Green, gui = 'italic' }),
    OrangeItalic({ Orange, gui = 'italic' }),
    PurpleItalic({ Purple, gui = 'italic' }),
    RedItalic({ Red, gui = 'italic' }),
    YellowItalic({ Yellow, gui = 'italic' }),

    NormalBold({ Normal, gui = 'bold' }),
    BlueBold({ Blue, gui = 'bold' }),
    CyanBold({ Cyan, gui = 'bold' }),
    GreenBold({ Green, gui = 'bold' }),
    OrangeBold({ Orange, gui = 'bold' }),
    PurpleBold({ Purple, gui = 'bold' }),
    RedBold({ Red, gui = 'bold' }),
    YellowBold({ Yellow, gui = 'bold' }),

    -- lighten comments
    Comment { fg = p.bg.li(48).de(14), gui = 'italic' },
    CursorLineNr { YellowBold },
    Keyword { fg = p.red.de(12) },
    Number { zenbones.Number, fg = p.yellow.de(30) },
    PreProc { fg = p.cyan },
    Special { Yellow },
    Statement { GreenBold },
    String { zenbones.Constant, fg = p.blue.de(20).li(10) },
    Type { fg = p.blue },
    -- Type { fg = p.yellow },
    Function { fg = p.fg2 },

    sym '@operator' { Normal },
    sym '@text.link' { Blue },
    sym '@text.uri' { Blue },
    -- sym '@text.title' { gui = 'underline' },

    sym '@string.bash' { Cyan },

    sym '@namespace.rust' { zenbones.Identifier },
    sym '@variable.type.rust' { zenbones.Identifier },

    sym '@property.json' { Green },

    PanelBackground({ fg = p.fg.darken(10), bg = p.bg.darken(8) }),
    PanelBorder({ fg = PanelBackground.bg.darken(10), bg = PanelBackground.bg }),
    PanelHeading({ PanelBackground, gui = 'bold' }),
    PanelVertSplit({ zenbones.VertSplit, bg = p.bg.darken(8) }),
    PanelStNC({ PanelVertSplit }),

    rustModPath { fg = p.fg3, gui = 'italic' },
    -- rustAttribute { fg = p.fg3, gui = 'italic' },
    -- rustAttribute { fg = p.grey2 },
    rustDerive { fg = p.grey2 },
    rustAwait { fg = p.fg },

    StatusLineNC { bg = zenbones.StatusLine.bg },

    SpellBad { sp = zenbones.SpellBad.fg, gui = 'underdouble' },
    SpellCap({ sp = p.blue, gui = 'undercurl' }),
    SpellLocal({ sp = p.cyan, bg = 'NONE', gui = 'undercurl' }),
    SpellRare({ sp = p.purple, bg = 'NONE', gui = 'undercurl' }),

    NormalFloat { Normal },

    -- Special { Blue },
    -- Type { YellowItalic },
    -- Constant { Cyan },
    CursorLine { bg = p.bg.li(8) },

    QuickFixLine { underline = true },

    mkdLink { Yellow },
    mkdHeading { Blue },

    zshDeref { Blue },
    zshOptStart { PurpleItalic },
    zshOption { Blue },
    zshSubst { Yellow },
    zshTypes { Orange },
    zshVariableDef { Blue },
    zshTypes { Orange },

    -- Plugins {{{
    -- cmp {{{
    CmpItemAbbrMatch { Green, gui = 'bold' },
    CmpItemAbbrMatchFuzzy { Green, gui = 'bold' },
    CmpItemAbbr { fg = p.fg },
    CmpItemAbbrDeprecated { Grey },
    CmpItemMenu { fg = p.fg3 },
    CmpItemKind { Yellow },
    CmpItemKindText { fg = p.fg },
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
    CmpItemKindKeyword { Purple },
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
    -- }}}

    GitSignsAdd { Green },
    GitSignsAddLn { base.DiffAdd },
    GitSignsAddNr { Green },
    GitSignsChange { Blue },
    GitSignsChangeLn { base.DiffChange },
    GitSignsChangeNr { Blue },
    GitSignsDelete { Red },
    GitSignsDeleteLn { base.DiffDelete },
    GitSignsDeleteNr { Red },

    NeoTreeNormal({ PanelBackground }),
    NeoTreeNormalNC({ PanelBackground }),
    NeoTreeDirectoryIcon { Blue },
    NeoTreeDirectoryName { Blue },
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

    NotifyERRORBody { Red },
    NotifyERRORBorder { Red },
    NotifyERRORIcon { Red },
    NotifyERRORTitle { Red },

    CodeBlock({ bg = p.bg }),
    Headline1({ zenbones.DiagnosticVirtualTextOk }),
    Headline2({ zenbones.DiagnosticVirtualTextInfo }),
    Headline3({ zenbones.DiagnosticVirtualTextWarn }),
    BqfPreviewFloat({ PanelBackground }),
    BqfPreviewBorder({ PanelBackground, fg = p.blue }),
    qfPosition({ zenbones.Todo }),

    MatchWord({ bg = c.bg2, gui = 'underline' }),

    TelescopeResultsDiffChange { Blue },
    TelescopeResultsDiffUntracked { Orange },

    goCoverageCovered({ Green }),

    -- }}}
  }
end)

lush(specs)

require('zenbones.term').apply_colors(p)
