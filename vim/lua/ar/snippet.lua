local luasnip = require('luasnip')

require('luasnip.loaders.from_vscode').load ({
  paths = {
    './vendor/friendly-snippets/snippets',
    './snippet',
  },
})
