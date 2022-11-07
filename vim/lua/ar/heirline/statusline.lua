local heirline = require('heirline')
local conditions = require('heirline.conditions')
local utils = require('heirline.utils')

local exceptions = {
  filetype = {
    fugitiveblame = 'Blame',
    fzf = 'FZF',
    gitcommit = 'Commit Message',
    godoc = 'GoDoc',
    help = 'Help',
    nerdtree = 'NERDTree',
    qf = '☰ Quickfix',
    tagbar = 'Tagbar',
    list = 'List',
  },
}

-- Colors {{{
local colors = {
  diag_warn = utils.get_highlight('DiagnosticWarn').fg,
  diag_error = utils.get_highlight('DiagnosticError').fg,
  diag_hint = utils.get_highlight('DiagnosticHint').fg,
  diag_info = utils.get_highlight('DiagnosticInfo').fg,

  white = '#abb2bf',
  black = '#282c34',
  gray = '#5c6370',
  highlight = '#e2be7d',
  none = 'NONE',

  bg = '#1E2022',
  selection = '#383C3F',
  line = '#26282B',
  comment = '#858785',
  fg = '#C4C7C5',

  red = '#CC6465',
  orange = '#DC925E',
  yellow = '#F1C673',
  green = '#B4BC68',
  cyan = '#8ABDB6',

  blue = '#81A2BD',
  purple = '#B293BB',
}

heirline.load_colors(colors)
-- }}}

local Space = { provider = ' ' }
local Align = { provider = '%=' }

-- Statusline

-- ViMode {{{
local ViMode = {
  init = function(self)
    self.mode = vim.fn.mode(1)
    if not self.once then
      vim.api.nvim_create_autocmd('ModeChanged', { command = 'redrawstatus' })
      self.once = true
    end
  end,
  static = {
    mode_colors = {
      n = '#626262',
      i = 'blue',
      v = 'orange',
      V = 'orange',
      ['\22'] = 'orange',
      c = 'orange',
      s = 'purple',
      S = 'purple',
      ['\19'] = 'purple',
      R = 'red',
      r = 'red',
      ['!'] = 'red',
      t = 'red',
    },
  },
  -- provider = '█'
  provider = '▌',
  hl = function(self)
    if conditions.is_active() then
      local mode = self.mode:sub(1, 1) -- get only the first mode character
      return { fg = self.mode_colors[mode] }
    end
  end,
  update = 'ModeChanged',
}
-- }}}

-- FileName {{{
local FileName = {
  init = function(self)
    if self.filename == '' then
      self.filename = 'ɴᴏᴏᴘ'
    end

    self.path = vim.fn.fnamemodify(self.filename, ':~:.:h')
    if not conditions.width_percent_below(#self.path, 0.25) then
      self.path = vim.fn.pathshorten(self.path)
    end
    self.fname = vim.fn.fnamemodify(self.filename, ':t')
  end,
  Space,
  {
    condition = function(self)
      return self.path ~= '.' and self.path ~= '~'
    end,
    provider = function(self)
      return self.path .. '/'
    end,
    hl = { fg = colors.blue },
  },
  {
    provider = function(self)
      return self.fname
    end,
  },
}
-- }}}

-- FileFlags {{{
local FileFlags = {
  {
    provider = function()
      return vim.bo.modified and ' [+]'
    end,
    hl = { fg = 'green' },
  },
  {
    provider = function()
      if not vim.bo.modifiable or vim.bo.readonly then
        return ''
      end
    end,
    hl = { fg = 'orange' },
  },
}
-- }}}

-- FileNameModifer {{{
local FileNameModifer = {
  hl = function()
    if vim.bo.modified then
      -- use `force` because we need to override the child's hl foreground
      return { fg = colors.cyan, bold = true, force = true }
    end
  end,
}
-- }}}

-- HelpFileName {{{
local HelpFileName = {
  condition = function()
    return vim.bo.filetype == 'help'
  end,
  provider = function()
    local fname = vim.api.nvim_buf_get_name(0)
    return vim.fn.fnamemodify(fname, ':t')
  end,
  hl = { fg = 'blue', force = true },
}
-- }}}

-- FileNameBlock {{{
local FileNameBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
  utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
  unpack(FileFlags), -- A small optimisation, since their parent does nothing
  { provider = '%<' }, -- this means that the statusline is cut here when there's not enough space
}
-- }}}

-- Git {{{
local Git = {
  condition = conditions.is_git_repo,
  hl = { fg = colors.white, bg = colors.grey, bold = true },
  provider = function()
    return ' ' .. vim.b.gitsigns_status_dict.head
  end,
}
-- }}}

-- Navic {{{
local Navic = {
  condition = require('nvim-navic').is_available,
  static = {
    type_hl = {
      File = 'Directory',
      Module = '@include',
      Namespace = '@namespace',
      Package = '@include',
      Class = '@structure',
      Method = '@method',
      Property = '@property',
      Field = '@field',
      Constructor = '@constructor',
      Enum = '@field',
      Interface = '@type',
      Function = '@function',
      Variable = '@variable',
      Constant = '@constant',
      String = '@string',
      Number = '@number',
      Boolean = '@boolean',
      Array = '@field',
      Object = '@type',
      Key = '@keyword',
      Null = '@comment',
      EnumMember = '@field',
      Struct = '@structure',
      Event = '@keyword',
      Operator = '@operator',
      TypeParameter = '@type',
    },
    -- bit operation dark magic, see below...
    enc = function(line, col, winnr)
      return bit.bor(bit.lshift(line, 16), bit.lshift(col, 6), winnr)
    end,
    -- line: 16 bit (65535); col: 10 bit (1023); winnr: 6 bit (63)
    dec = function(c)
      local line = bit.rshift(c, 16)
      local col = bit.band(bit.rshift(c, 6), 1023)
      local winnr = bit.band(c, 63)
      return line, col, winnr
    end,
  },
  init = function(self)
    local data = require('nvim-navic').get_data() or {}
    local children = {}
    -- create a child for each level
    for i, d in ipairs(data) do
      -- encode line and column numbers into a single integer
      local pos = self.enc(d.scope.start.line, d.scope.start.character, self.winnr)
      local child = {
        {
          provider = d.icon,
          hl = self.type_hl[d.type],
        },
        {
          -- escape `%`s (elixir) and buggy default separators
          provider = d.name:gsub('%%', '%%%%'):gsub('%s*->%s*', ''),
          -- highlight icon only or location name as well
          -- hl = self.type_hl[d.type],
        },
      }
      -- add a separator only if needed
      if #data > 1 and i < #data then
        table.insert(child, {
          provider = ' > ',
          hl = { fg = 'fg' },
        })
      end
      table.insert(children, child)
    end
    -- instantiate the new child, overwriting the previous one
    self.child = self:new(children, 1)
  end,
  -- evaluate the children containing navic components
  provider = function(self)
    return self.child:eval()
  end,
  -- hl = { fg = "gray" },
  update = 'CursorMoved',
}

local Navic = { flexible = 3, Navic, { provider = '' } }
-- }}}

-- LSPActive {{{
local LSPActive = {
  condition = conditions.lsp_attached,
  update = { 'LspAttach', 'LspDetach' },
  provider = '',
  hl = { fg = 'green', bold = true },
}
-- }}}

-- Spell {{{
local Spell = {
  condition = function()
    return vim.wo.spell
  end,
  provider = 'SPELL ',
  hl = { bold = true, fg = colors.orange },
  Space,
}
-- }}}

-- FileType {{{
local FileType = {
  condition = function()
    return not conditions.buffer_matches({
      filetype = vim.tbl_keys(exceptions.filetype),
    })
  end,
  provider = function()
    return ' ' .. vim.bo.filetype .. ' '
  end,
  hl = { bold = true },
}
-- }}}

-- Ruler {{{
local Ruler = {
  -- %l = current line number
  -- %L = number of lines in the buffer
  -- %c = column number
  -- %P = percentage through file of displayed window
  -- provider = "%7(%l/%3L%):%2c %P",

  -- provider = '%3l:%-2c',
  provider = ' %8(%l:%L%)  %-3(%c%V%) ',
}
-- }}}

-- ScrollBar  {{{
local ScrollBar = {
  static = {
    -- sbar = { '▁', '▂', '▃', '▄', '▅', '▆', '▇', '█' },
    sbar = { '🭶', '🭷', '🭸', '🭹', '🭺', '🭻' },
  },
  provider = function(self)
    local curr_line = vim.api.nvim_win_get_cursor(0)[1]
    local lines = vim.api.nvim_buf_line_count(0)
    local i = math.floor((curr_line - 1) / lines * #self.sbar) + 1
    return string.rep(self.sbar[i], 2)
  end,
  hl = { fg = 'blue' },
}
-- }}}

-- Diagnostic {{{
local Diagnostics = {
  condition = conditions.has_diagnostics,
  static = {
    error_icon = ' ⨉ ',
    warn_icon = '  ',
    info_icon = ' ℹ︎ ',
    hint_icon = ' ○ ',
  },
  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,
  update = { 'DiagnosticChanged', 'BufEnter' },
  {
    provider = function(self)
      return self.errors > 0 and (self.error_icon .. self.errors .. ' ')
    end,
    hl = { fg = 'diag_error' },
  },
  {
    provider = function(self)
      return self.warnings > 0 and (self.warn_icon .. self.warnings .. ' ')
    end,
    hl = { fg = 'diag_warn' },
  },
  {
    provider = function(self)
      return self.info > 0 and (self.info_icon .. self.info .. ' ')
    end,
    hl = { fg = 'diag_info' },
  },
  {
    provider = function(self)
      return self.hints > 0 and (self.hint_icon .. self.hints)
    end,
    hl = { fg = 'diag_hint' },
  },
}
-- }}}

-- Search {{{
local SearchResults = {
  condition = function(self)
    if vim.v.hlsearch == 0 then
      return false
    end
    if vim.api.nvim_buf_line_count(0) > 50000 then
      return false
    end

    local search_count = vim.fn.searchcount({ recompute = 1, maxcount = -1 })
    if search_count.total < 1 then
      return false
    end

    self.count = search_count
    return true
  end,
  {
    provider = function(self)
      return ' [' .. self.count.current .. '/' .. self.count.total .. '] '
    end,
    -- hl = { bg = '#626262' },
    hl = { bold = true },
  },
  Space,
}
-- }}}

-- Quickfix {{{
local QuickfixTitle = {
  static = {
    grepprg = vim.opt.grepprg:get():gsub('([^%w])', '%%%1'),
  },
  condition = function(self)
    self.title = vim.w.quickfix_title
    return self.title ~= nil
  end,
  Space,
  provider = function(self)
    local title = vim.w.quickfix_title
    return title:gsub(self.grepprg, 'grep')
  end,
}
-- }}}

-- Neomake {{{
local Neomake = {
  condition = function()
    if vim.fn.exists('*neomake#Make') == 0 then
      return false
    end
    return vim.fn['neomake#statusline#LoclistStatus']()
    -- if vim.tbl_isempty(vim.fn['neomake#statusline#LoclistCounts'](0)) then
    --   return false
    -- end
    -- return true
  end,
  -- provider = function()
  --   return vim.fn['neomake#statusline#LoclistStatus']()
  -- end,
  provider = function(self)
    return vim.fn['neomake#statusline#get'](vim.api.nvim_get_current_buf(), {
      format_running = '…',
      format_loclist_ok = '',
      format_loclist_unknown = '',
      format_quickfix_unknown = '',
      format_loclist_type_E = ' ⨉ {{count}}',
      format_loclist_type_W = '  {{count}}',
      format_loclist_type_I = ' ℹ︎ {{count}}',
    })
  end,
  update = { 'User', pattern = 'NeomakeJobFinished' },
  hl = { fg = 'red' },
}
-- }}}

-- DefaultStatusline {{{
local DefaultStatusline = {
  ViMode,
  Space,
  Git,
  Space,
  FileNameBlock,
  Align,
  Navic,
  Align,
  Diagnostics,
  Space,
  Neomake,
  SearchResults,
  Space,
  LSPActive,
  Space,
  Spell,
  FileType,
  Ruler,
  ScrollBar,
}
-- }}}

-- InactiveStatusline {{{
local InactiveStatusline = {
  condition = function()
    return not conditions.is_active()
  end,

  ViMode,
  Space,
  Git,
  Space,
  FileNameBlock,
  Align,
  FileType,
  Ruler,
  ScrollBar,
}
-- }}}

-- SpecialStatusline {{{
local SpecialStatusline = {
  condition = function()
    return conditions.buffer_matches({
      filetype = vim.tbl_keys(exceptions.filetype),
    })
  end,
  Space,
  {
    provider = function()
      return exceptions.filetype[vim.bo.filetype]
    end,
  },
  QuickfixTitle,
  Space,
  FileType,
  HelpFileName,
  Align,
  Ruler,
}
-- }}}

local statusline = {
  fallthrough = false,
  hl = { bg = '#303336' },
  SpecialStatusline,
  InactiveStatusline,
  DefaultStatusline,
}

-- Tabline {{{
local Tabpage = {
  provider = function(self)
    return '%' .. self.tabnr .. 'T ' .. self.tabnr .. ' %T'
  end,
  hl = function(self)
    return self.is_active and 'DiffText' or 'TabLineSel'
  end,
}

local Workdir = {
  provider = function()
    local cwd = vim.loop.cwd()
    return cwd and vim.fn.fnamemodify(cwd, ':~')
  end,
  hl = 'TabLineSel',
}

local tabline = {
  hl = { bg = '#303336' },
  utils.make_tablist(Tabpage),
  Align,
  Workdir,
}
-- }}}

heirline.setup(statusline, nil, tabline)

-- vim: foldmethod=marker
