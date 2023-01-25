local augid = vim.api.nvim_create_augroup('ar_vim', { clear = true })

vim.api.nvim_create_autocmd('VimResized', {
  desc = 'Automatically resize panes on resize',
  command = 'wincmd =',
  group = augid,
})

vim.api.nvim_create_autocmd('VimEnter', {
  desc = 'Find and source project-specific config',
  callback = function() vim.fn['project#SourceConfig']() end,
  group = augid,
})

vim.api.nvim_create_autocmd('BufWritePre', {
  desc = 'Remove trailing whitespace automatically',
  callback = require('ar.whitespace').trim,
  group = augid,
})

vim.api.nvim_create_autocmd('InsertEnter', {
  desc = 'Disable hlsearch for insert mode',
  callback = function() vim.opt_local.hlsearch = false end,
  group = augid,
})

vim.api.nvim_create_autocmd('InsertLeave', {
  desc = 'Enable lhsearch leaving insert mode',
  callback = function() vim.opt_local.hlsearch = true end,
  group = augid,
})

vim.api.nvim_create_autocmd('InsertLeave', {
  desc = 'update diff',
  pattern = '*',
  command = 'if &l:diff | diffupdate | endif',
  group = augid,
})

local autoread = vim.api.nvim_create_augroup('ar_autoread', { clear = true })
vim.api.nvim_create_autocmd('FileChangedShellPost', {
  pattern = '*',
  group = autoread,
  callback = function()
    vim.notify('File changed on disk. Buffer reloaded.')
  end,
})

vim.api.nvim_create_autocmd({ 'FocusGained', 'CursorHold' }, {
  pattern = '*',
  group = autoread,
  callback = function()
    if vim.fn.getcmdwintype() == '' then
      vim.cmd('checktime')
    end
  end,
})

vim.api.nvim_create_augroup('Highlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    -- vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 100 })
    vim.highlight.on_yank()
  end,
})
