-- =======================================================================
-- Neovim specific config
-- =======================================================================

if not pcall(require, 'impatient') then
  print('failed to load impatient.nvim')
end

-- -----------------------------------------------------------------------
-- Python Setup
-- -----------------------------------------------------------------------
if vim.fn.executable('python3') then
  vim.g.python3_host_skip_check = true
  vim.g.python3_host_prog = vim.fn.exepath('python3')
end

if vim.fn.executable('neovim-ruby-host') then
  vim.g.ruby_host_prog = vim.fn.exepath('neovim-ruby-host')
end

--------------------------------------------------------------------------
-- Vim Configuration
--------------------------------------------------------------------------

require('ar.packer')

_G['ar'] = require('ar')
