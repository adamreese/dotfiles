local luasnip = require('luasnip')

require('luasnip.loaders.from_vscode').lazy_load({
  paths = {
    -- vim.g.plug_home .. '/friendly-snippets',
    './snippet',
  },
})
