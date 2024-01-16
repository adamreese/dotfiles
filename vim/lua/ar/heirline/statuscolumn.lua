local align = { provider = '%=' }

local function get_extmarks_signs(bufnr, lnum, filter)
  local signs = {}
  local extmarks = vim.api.nvim_buf_get_extmarks(
    0,
    bufnr,
    { lnum - 1, 0 },
    { lnum - 1, -1 },
    { details = true, type = 'sign' }
  )
  for _, extmark in pairs(extmarks) do
    if filter(extmark[4]) then
      signs[#signs + 1] = {
        name = extmark[4].sign_hl_group or '',
        text = extmark[4].sign_text,
        sign_hl_group = extmark[4].sign_hl_group,
        priority = extmark[4].priority,
      }
    end
  end
  table.sort(signs, function(a, b)
    return (a.priority or 0) < (b.priority or 0)
  end)
  return signs
end

local signs = {
  init = function(self)
    self.signs = get_extmarks_signs(-1, vim.v.lnum, function(extmark)
      return not extmark.sign_hl_group:match('^GitSigns')
    end)[1]
  end,
  provider = function(self)
    return self.sign and self.sign.text or '  '
  end,
  hl = function(self)
    return self.sign and self.sign.sign_hl_group
  end,
}

local line_numbers = {
  provider = function()
    if vim.bo.filetype == 'qf' or vim.v.virtnum ~= 0 then
      return ''
    end
    return ('%02d'):format(vim.v.lnum)
  end,
}

local gits = {
  condition = function()
    return vim.v.virtnum == 0
  end,
  init = function(self)
    self.sign = get_extmarks_signs(-1, vim.v.lnum, function(extmark)
      return extmark.sign_hl_group:match('^GitSigns')
    end)[1]
  end,
  provider = function(self)
    return self.sign and self.sign.text or ' ▏'
  end,
  hl = function(self)
    return self.sign and self.sign.sign_hl_group or { fg = 'bg3' }
  end,
}

return {
  init = function(self)
    self.signs = {}
  end,
  signs,
  align,
  line_numbers,
  gits,
}
