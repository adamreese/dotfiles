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
      return self.sign.name
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
  { provider = '%=' },
  line_numbers,
  gitsigns,
}
