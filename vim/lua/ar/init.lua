local M = {}

if pcall(require, 'plenary') then
  local plenary_reload = require('plenary.reload').reload_module

  _G.R = function(name)
    plenary_reload(name)
    return require(name)
  end
end

vim.api.nvim_create_user_command('ReloadModule', function(opts)
  R(opts.args)
end, { nargs = 1 })

vim.o.titlestring = '%{luaeval("require[[ar.title]]()")}'

return M
