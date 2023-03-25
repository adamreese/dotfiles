-- =======================================================================
-- Neovim config
-- =======================================================================

vim.g.mapleader = ','
vim.g.maplocalleader = ','

vim.opt.termguicolors = true

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--single-branch',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

---------------------------------------------------------------------------

require('lazy').setup('ar.plugins', {
  change_detection = { notify = false },
  checker = { enabled = true, notify = false },
  performance = {
    rtp = {
      disabled_plugins = { 'netrw', 'netrwPlugin', 'tarPlugin', 'tutor', 'tohtml', 'logipat' },
    },
  },
  ui = { border = 'single' },
  lockfile = vim.fn.stdpath('data') .. '/lazy-lock.json',
})

_G['ar'] = require('ar')
