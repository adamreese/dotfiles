local M = {}

function _G.dump(...)
  vim.pretty_print(...)
end

if pcall(require, 'plenary') then
  local plenary_reload = require('plenary.reload').reload_module

  _G.R = function(name)
    plenary_reload(name)
    return require(name)
  end
end

function M.command(name, rhs, opts)
  opts = opts or {}
  vim.api.nvim_create_user_command(name, rhs, opts)
end

M.command('ReloadModule', function(opts) R(opts.args) end, { nargs = 1 })

return M
