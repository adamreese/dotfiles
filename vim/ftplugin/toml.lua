-- Don't wrap lines
vim.opt_local.formatoptions:remove('t')

require('crates').setup()
require('cmp').setup.buffer { sources = { { name = 'crates' } } }

vim.api.nvim_create_user_command('CrateMenu', require('crates').show_popup, {})
vim.api.nvim_create_user_command('CrateToggle', require('crates').toggle, {})
vim.api.nvim_create_user_command('CrateReload', require('crates').reload, {})
vim.api.nvim_create_user_command('CrateUpdate', require('crates').update_crate, {})
vim.api.nvim_create_user_command('CrateUpdateAll', require('crates').update_crates, {})
