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
    Outline = 'Outline',
    packer = 'Packer',
    ['neo-tree'] = 'Neotree'
  },
  buftype = { 'nofile' },
}

function exceptions.buffer_matches()
  return conditions.buffer_matches({
    filetype = vim.tbl_keys(exceptions.filetype),
    buftype = exceptions.buftype,
  })
end

-- Colors {{{
local colors = require('ar.colors.beatbox')

vim.api.nvim_set_hl(0, 'Statusline', { bg = colors.base02 })
vim.api.nvim_set_hl(0, 'WinBar', { bg = colors.base02 })
vim.api.nvim_set_hl(0, 'WinBarNC', {})

heirline.load_colors(colors)
-- }}}

local Space = { provider = ' ' }
local Align = { provider = '%=' }

local Sep = { provider = '|', hl = { fg = 'base04', bold = false } }

-- Statusline

-- Components {{{

-- ViMode {{{
local ViMode = {
  init = function(self)
    self.mode = vim.fn.mode(1)
    if not self.once then
      vim.api.nvim_create_autocmd('ModeChanged', { pattern = '*:*o', command = 'redrawstatus' })
      self.once = true
    end
  end,
  static = {
    mode_colors = {
      -- n = '#626262',
      n = 'blue',
      i = 'green',
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
  provider = '▌', -- '█'
  hl = function(self)
    if conditions.is_active() then
      local mode = self.mode:sub(1, 1) -- get only the first mode character
      return { fg = self.mode_colors[mode] }
    else
      return { fg = 'base05' }
    end
  end,
  update = 'ModeChanged',
}
-- }}}

-- FileName {{{
local FileName = {
  init = function(self)
    self.path = vim.fn.fnamemodify(self.filename, ':~:.:h')
    if not conditions.width_percent_below(#self.path, 0.4) then
      self.path = vim.fn.pathshorten(self.path)
    end
    self.fname = vim.fn.fnamemodify(self.filename, ':t')
  end,
  hl = function()
    if vim.bo.modified then
      -- use `force` because we need to override the child's hl foreground
      return { fg = 'orange', bold = true, force = true }
    end
  end,
  {
    condition = function(self)
      return self.path ~= '.' and self.path ~= '~'
    end,
    provider = function(self)
      return self.path .. '/'
    end,
    hl = { fg = 'base04' },
  },
  {
    provider = function(self)
      if self.filename == '' then
        return '[No Name]'
      end
      return self.fname
    end,
    hl = { bold = true },
  },
}
-- }}}

-- FileFlags {{{
local FileFlags = {
  {
    provider = function()
      return vim.bo.modified and ' '
    end,
    hl = { fg = 'green' },
  },
  {
    provider = function()
      if not vim.bo.modifiable or vim.bo.readonly then
        return ' '
      end
    end,
    hl = { fg = 'orange' },
  },
}
-- }}}

-- HelpFileName {{{
local HelpFileName = {
  condition = function()
    return vim.bo.filetype == 'help'
  end,
  Sep, Space,
  {
    provider = function()
      local fname = vim.api.nvim_buf_get_name(0)
      return vim.fn.fnamemodify(fname, ':t')
    end,
  },
}
-- }}}

-- FileNameBlock {{{
local FileNameBlock = {
  init = function(self)
    self.filename = vim.api.nvim_buf_get_name(0)
  end,
  FileName,
  FileFlags,
  { provider = '%<' },
}
-- }}}

-- Git {{{
local Git = {
  condition = conditions.is_git_repo,
  hl = { fg = 'white', bold = true },
  provider = function()
    return ' ' .. vim.b.gitsigns_status_dict.head .. ' '
  end,
  Sep, Space,
}
-- }}}

-- LSPActive {{{
local LSPActive = {
  condition = conditions.lsp_attached,
  update = { 'LspAttach', 'LspDetach' },
  hl = { fg = 'green', bold = true },
  provider = '⦾ ',
  Sep,
}
-- }}}

-- Navic {{{
local Navic = {
  condition = function(self)
    if not require('nvim-navic').is_available() then
      return false
    end

    self.data = require('nvim-navic').get_data() or {}
    return not vim.tbl_isempty(self.data)
  end,
  static = {
    -- create a type highlight map
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
    max_depth = 3,
  },
  flexible = 3,
  {
    init = function(self)
      local children = {}
      for i, d in ipairs(self.data) do
        local child = {
          {
            provider = d.icon,
            hl = self.type_hl[d.type],
          },
          {
            provider = d.name,
            hl = { fg = 'base07' },
          },
        }

        -- add a separator only if needed
        if #self.data > 1 and i < #self.data then
          table.insert(child, {
            provider = ' > ',
            hl = { fg = 'base05' },
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
    hl = { fg = 'gray' },
    update = 'CursorMoved'
  },
  { provider = '' }
}
-- }}}

-- Spell {{{
local Spell = {
  condition = function()
    return vim.wo.spell
  end,
  provider = ' s ',
  hl = { bold = true, fg = 'orange' },
  Space,
}
-- }}}

-- FileType {{{
local FileType = {
  condition = function()
    return not exceptions.buffer_matches()
  end,
  {
    provider = function()
      return ' ' .. vim.bo.filetype .. ' '
    end,
    hl = { bold = true },
  },
  Sep,
}
-- }}}

-- Ruler {{{
local Ruler = {
  -- %l = current line number
  -- %L = number of lines in the buffer
  -- %c = column number
  provider = ' %4l',
  { provider = '/%L ', hl = { fg = 'light_grey2' } }
}
-- }}}

-- ScrollBar  {{{
local ScrollBar = {
  static = {
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
    error_icon = ' ',
    warn_icon = '⚠ ',
    info_icon = ' ',
    hint_icon = ' ',
  },

  init = function(self)
    self.errors   = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints    = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info     = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,
  update = { 'DiagnosticChanged', 'BufEnter' },
  Space,
  {
    provider = function(self)
      return self.errors > 0 and (self.error_icon .. self.errors .. ' ')
    end,
    hl = { fg = 'red' },
  },
  {
    provider = function(self)
      return self.warnings > 0 and (self.warn_icon .. self.warnings .. ' ')
    end,
    hl = { fg = 'orange' },
  },
  {
    provider = function(self)
      return self.info > 0 and (self.info_icon .. self.info .. ' ')
    end,
    hl = { fg = 'light_grey2' },
  },
  {
    provider = function(self)
      return self.hints > 0 and (self.hint_icon .. self.hints .. ' ')
    end,
    hl = { fg = 'light_grey2' },
  },
  Sep,
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
      return (' [%d/%d] '):format(self.count.current, self.count.total)
    end,
    -- hl = { bg = '#626262' },
    hl = { bold = true },
  },
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
  {
    provider = function(self)
      local title = vim.w.quickfix_title
      return title:gsub(self.grepprg, 'grep')
    end,
  },
}
-- }}}

-- Neomake {{{
local Neomake = {
  condition = function()
    if vim.fn.exists('*neomake#Make') == 0 then
      return false
    end
    return vim.fn['neomake#statusline#LoclistStatus']()
  end,
  provider = function()
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

-- }}}

-- DefaultStatusline {{{
local DefaultStatusline = {
  ViMode,
  Space,
  Git,
  FileNameBlock,
  Spell,
  Align,
  Navic,
  Align,
  SearchResults,
  LSPActive,
  Diagnostics,
  Neomake,
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
  FileNameBlock,
  Align,
  FileType,
  Ruler,
  ScrollBar,
}
-- }}}

-- SpecialStatusline {{{
local SpecialStatusline = {
  condition = exceptions.buffer_matches,
  Space,
  {
    provider = function()
      return exceptions.filetype[vim.bo.filetype]
    end,
  },
  Space,
  HelpFileName,
  QuickfixTitle,
  Space,
  FileType,
  Align,
  SearchResults,
  Ruler,
  ScrollBar,
}
-- }}}

local Statusline = {
  fallthrough = false,
  -- hl = { bg = 'bg2' },
  hl = { bg = 'base02' },
  SpecialStatusline,
  InactiveStatusline,
  DefaultStatusline,
}

-- Tabline {{{
local WorkDir = {
  provider = function()
    local cwd = vim.loop.cwd()
    return cwd and vim.fn.fnamemodify(cwd, ':~')
  end,
  hl = { bold = true },
}

local Tabpage = {
  provider = function(self)
    return '%' .. self.tabnr .. 'T ' .. self.tabnr .. ' %T'
  end,
  hl = function(self)
    return self.is_active and { bg = 'blue', fg = 'one_bg' } or 'TabLineSel'
  end,
}

local Tabline = {
  hl = { bg = 'base02' },
  utils.make_tablist(Tabpage),
  Align,
  WorkDir,
}
-- }}}

heirline.setup(Statusline, nil, Tabline)

-- vim: foldmethod=marker
