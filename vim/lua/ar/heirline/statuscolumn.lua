local diagnostics = {
  static = {
    texts = {
      DiagnosticSignError = ' ',
      DiagnosticSignWarn  = '⚠ ',
      DiagnosticSignInfo  = ' ',
      DiagnosticSignHint  = ' ',
    },
  },
  init = function(self)
    local signs = vim.fn.sign_getplaced(vim.api.nvim_get_current_buf(), {
      group = '*',
      lnum = vim.v.lnum,
    })

    if #signs == 0 or signs[1].signs == nil then
      self.sign = nil
      self.has_sign = false
      return
    end

    signs = vim.tbl_filter(function(sign)
      return vim.startswith(sign.group, 'vim.diagnostic')
    end, signs[1].signs)

    if #signs == 0 then
      self.sign = nil
    else
      self.sign = signs[1]
    end

    self.has_sign = self.sign ~= nil
  end,
  provider = function(self)
    if self.has_sign then
      return self.texts[self.sign.name]
    end

    return '  '
  end,
  hl = function(self)
    if self.has_sign then
      return self.sign.name
    end
  end,
}

local function fix_gitsign_name(name)
  local names = {
    GitSignsAddAdd = 'GitSignsAdd',
    GitSignsChangeChange = 'GitSignsChange',
    GitSignsDeleteDelete = 'GitSignsDelete',
    GitSignsTopDeleteTopDelete = 'GitSignsTopDelete',
    GitSignsChangeDeleteChangeDelete = 'GitSignsChangeDelete',
    GitSignsUntrackedUntracked = 'GitSignsUntracked',
  }
  return names[name] or name
end

local gitsigns = {
  init = function(self)
    local signs = vim.fn.sign_getplaced(vim.api.nvim_get_current_buf(), {
      group = 'gitsigns_vimfn_signs_',
      id = vim.v.lnum,
      lnum = vim.v.lnum,
    })

    if #signs == 0 or signs[1].signs == nil or #signs[1].signs == 0 or signs[1].signs[1].name == nil then
      self.sign = nil
    else
      self.sign = signs[1].signs[1]
    end
  end,
  provider = ' ▏',
  hl = function(self)
    if self.sign ~= nil then
      return fix_gitsign_name(self.sign.name)
    end

    return { fg = 'bg3' }
  end,
}

local line_numbers = {
  provider = function()
    if vim.v.virtnum > 0 then
      return ''
    end

    return ('%02d'):format(vim.v.lnum)
  end,
}

return {
  diagnostics,
  { provider = '%=' },
  line_numbers,
  gitsigns,
}
