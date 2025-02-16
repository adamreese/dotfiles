local heirline = require('heirline')
local conditions = require('heirline.conditions')

local exception = setmetatable({
  filetype = {
    fugitiveblame = 'Blame',
    fzf           = 'FZF',
    gitcommit     = 'Commit Message',
    godoc         = 'GoDoc',
    help          = 'Help',
    nerdtree      = 'NERDTree',
    qf            = '☰ Quickfix',
    tagbar        = 'Tagbar',
    list          = 'List',
    Outline       = 'Outline',
    packer        = 'Packer',
    ['neo-tree']  = 'Neotree',
    Trouble       = 'Trouble',
  },
  buftype = { 'nofile' },
}, {
  __call = function(self)
    return conditions.buffer_matches({
      filetype = vim.tbl_keys(self.filetype),
      buftype = self.buftype,
    })
  end,
})

-- Colors {{{
local colors = vim.tbl_map(function(x) return x.hex end, require('ar.colors.gruvbones'))
heirline.load_colors(colors)
-- }}}

local Space = { provider = ' ' }
local Align = { provider = '%=' }
local Sep = { provider = '|', hl = { fg = 'fg5', bold = false } }

-- ViMode {{{
local ViMode = {
  init = function(self)
    self.mode = vim.fn.mode(1)
  end,
  static = {
    mode_colors = {
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
      return { fg = 'bg4' }
    end
  end,
  update = {
    'ModeChanged',
    pattern = '*:*',
    callback = vim.schedule_wrap(function()
      vim.cmd.redrawstatus()
    end),
  },
}
-- }}}

-- FileName {{{
local FileName = {
  init = function(self)
    self.path = vim.fn.fnamemodify(self.filename, ':~:.:h')
    if not conditions.width_percent_below(#self.path, 0.4) then
      self.path = vim.fn.pathshorten(self.path)
    end
    self.fname = vim.fs.basename(self.filename)
  end,
  hl = function()
    if vim.bo.modified then
      -- use `force` because we need to override the child's hl foreground
      return { fg = 'orange', bold = true, force = true }
    end
  end,
  {
    condition = function(self)
      return self.path ~= '.' and self.path ~= '~' and self.filename ~= ''
    end,
    provider = function(self)
      return self.path .. '/'
    end,
    hl = { fg = 'fg5' },
  },
  {
    provider = function(self)
      return self.filename == '' and '[No Name]' or self.fname
    end,
    hl = { fg = 'fg', bold = true },
  },
}
-- }}}

-- FileFlags {{{
local FileFlags = {
  {
    provider = function()
      return vim.bo.modified and ' '
    end,
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
  Sep,
  Space,
  {
    provider = function()
      local fname = vim.api.nvim_buf_get_name(0)
      return vim.fs.basename(fname)
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
  hl = { fg = 'fg', bold = true },
  provider = function()
    return ' ' .. vim.b.gitsigns_status_dict.head
  end,
  Space,
  Sep,
  Space,
}
-- }}}

-- LSPActive {{{
local LSPActive = {
  condition = conditions.lsp_attached,
  update    = { 'LspAttach', 'LspDetach' },
  hl        = { fg = 'green', bold = true },
  provider  = '  ',
  Sep,
}
-- }}}

-- TSActive {{{
local TSActive = {
  condition = function()
    return package.loaded['nvim-treesitter']
        and require('nvim-treesitter.parsers').has_parser()
  end,
  hl        = { fg = 'yellow' },
  provider  = ' TS ',
  Sep,
}
-- }}}

-- Spell {{{
local Spell = {
  condition = function()
    return vim.wo.spell
  end,
  provider = ' SPELL ',
  hl = { bold = true, fg = 'orange' },
}
-- }}}

-- FileType {{{
local FileType = {
  condition = function()
    return not exception()
  end,
  Space,
  {
    provider = function()
      local ft = vim.bo.filetype
      return ft == '' and 'ɴᴏᴏᴘ' or ft
    end,
    hl = { bold = true },
  },
  Space,
  Sep,
}
-- }}}

-- Ruler {{{
local Ruler = {
  -- %l = current line number
  -- %L = number of lines in the buffer
  -- %c = column number
  { provider = ' %4l' },
  { provider = '/%L ', hl = { fg = 'fg5' } },
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
    warn_icon  = '⚠ ',
    info_icon  = ' ',
    hint_icon  = ' ',
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
    hl = { fg = 'blue' },
  },
  {
    provider = function(self)
      return self.hints > 0 and (self.hint_icon .. self.hints .. ' ')
    end,
    hl = { fg = 'purple' },
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

    self.count = vim.fn.searchcount({ recompute = 1, maxcount = -1 })
    return self.count.total > 0
  end,
  {
    provider = function(self)
      return (' [%d/%d] '):format(self.count.current, self.count.total)
    end,
    hl = { bold = true },
  },
}
-- }}}

-- Quickfix {{{
local QuickfixTitle = {
  condition = function(self)
    self.title = vim.w.quickfix_title
    return self.title ~= nil
  end,
  Space,
  {
    provider = function(self)
      local grepprg = vim.opt.grepprg:get():gsub('([^%w])', '%%%1')
      return self.title:gsub(grepprg, 'grep ')
    end,
  },
}
-- }}}

-- DefaultStatusline {{{
local DefaultStatusline = {
  ViMode,
  Space,
  Git,
  FileNameBlock,
  Align,
  require('ar.heirline.navic'),
  Align,
  Spell,
  SearchResults,
  LSPActive,
  TSActive,
  Diagnostics,
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
  hl = { fg = 'grey2', force = true },
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
  condition = exception,
  hl = { fg = 'grey2', force = true },
  ViMode,
  Space,
  {
    provider = function()
      return exception.filetype[vim.bo.filetype]
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
  hl = 'Statusline',
  SpecialStatusline,
  InactiveStatusline,
  DefaultStatusline,
}

local Statuscolumn = {
  condition = function()
    return not exception()
  end,
  require('ar.heirline.statuscolumn'),
}

heirline.setup({
  statusline   = Statusline,
  tabline      = require('ar.heirline.tabline'),
  statuscolumn = Statuscolumn,
})

vim.api.nvim_create_user_command('ReloadStatusline', function() R('ar.heirline') end, {})

-- vim: foldmethod=marker
