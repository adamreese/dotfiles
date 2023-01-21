-- Based on
--   https://github.com/yamatsum/nvim-cursorline
--   https://github.com/megalithic/dotfiles/blob/main/config/nvim/plugin/cursorline.lua

local filetype_exclusions = {
  'Telescope',
  'TelescopePrompt',
  'Trouble',
  'fugitive',
  'fzf',
  'gitcommit',
  'prompt',
  'qf',
  'nerdtree',
  'neo-tree',
}
local buftype_exclusions = {
  'acwrite',
  'quickfix',
  'terminal',
  'help',
  '.git/COMMIT_EDITMSG',
  'prompt',
}

local delay = vim.o.updatetime
local timer = vim.loop.new_timer()

local function is_floating_win()
  return vim.fn.win_gettype() == 'popup'
end

---Determines whether or not a buffer/window should be ignored by this plugin
---@return boolean
local function is_ignored()
  local should_ignore = vim.bo.filetype == ''
      or vim.tbl_contains(buftype_exclusions, vim.bo.buftype)
      or vim.tbl_contains(filetype_exclusions, vim.bo.filetype)
      or is_floating_win()

  return should_ignore
end

local function timer_start()
  if not is_ignored() then
    timer:start(
      delay,
      0,
      vim.schedule_wrap(function()
        vim.wo.cursorlineopt = 'both'
      end)
    )
  end
end

vim.wo.cursorline = true
vim.api.nvim_create_autocmd('WinEnter', {
  desc = 'cursorline',
  callback = function()
    if not is_ignored() then
      vim.wo.cursorline = true
    end
  end,
})
vim.api.nvim_create_autocmd('WinLeave', {
  desc = 'cursorline',
  callback = function()
    if not is_ignored() then
      vim.wo.cursorline = false
    end
  end,
})
vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
  desc = 'cursorline',
  callback = function()
    if not is_ignored() then
      vim.wo.cursorlineopt = 'number'
      timer_start()
    end
  end,
})
