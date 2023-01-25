-- mini.nvim
local M = {}

vim.g.whitespace_enable = vim.g.whitespace_enable or true

local function enabled()
  return vim.bo.buftype == '' or vim.g.whitespace_enable
end

local function trim_trailing_space()
  local curpos = vim.api.nvim_win_get_cursor(0)
  vim.cmd([[keeppatterns %s/\s\+$//e]])
  vim.api.nvim_win_set_cursor(0, curpos)
end

local function trim_trailing_lines()
  local lines = vim.api.nvim_buf_line_count(0)
  local nonblank = vim.fn.prevnonblank(lines)
  if nonblank < lines then
    vim.api.nvim_buf_set_lines(0, nonblank, lines, true, {})
  end
end

function M.trim()
  if not enabled() then return end
  trim_trailing_space()
  trim_trailing_lines()
end

return M
