-- Based on https://github.com/yamatsum/nvim-cursorline

local delay = vim.o.updatetime
local timer = vim.loop.new_timer()

local function timer_start()
  timer:start(
    delay,
    0,
    vim.schedule_wrap(function()
      vim.wo.cursorlineopt = 'both'
    end)
  )
end

vim.wo.cursorline = true
vim.api.nvim_create_autocmd('WinEnter', {
  callback = function()
    vim.wo.cursorline = true
  end,
})
vim.api.nvim_create_autocmd('WinLeave', {
  callback = function()
    vim.wo.cursorline = false
  end,
})
vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
  callback = function()
    vim.wo.cursorlineopt = 'number'
    timer_start()
  end,
})
