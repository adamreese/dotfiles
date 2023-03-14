local utils = require('heirline.utils')

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
    return self.is_active and { bg = 'blue', fg = 'bg1' } or 'TabLineSel'
  end,
}

return {
  hl = 'Tabline',
  utils.make_tablist(Tabpage),
  { provider = '%=' },
  WorkDir,
}
