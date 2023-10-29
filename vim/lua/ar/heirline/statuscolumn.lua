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

local gitsigns = {
  init = function(self)
    local ns_id = vim.api.nvim_get_namespaces()['gitsigns_extmark_signs_']

    if ns_id then
      local mark = vim.api.nvim_buf_get_extmarks(
        0,
        ns_id,
        { vim.v.lnum - 1, 0 },
        { vim.v.lnum, 0 },
        { limit = 1, details = true }
      )[1]

      self.sign = mark and mark[4]['sign_hl_group']
    end
  end,
  provider = ' ▏',
  hl = function(self)
    return self.sign or { fg = 'bg3' }
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
