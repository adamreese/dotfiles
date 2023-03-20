return {
  bashls = {
    filetypes = { 'bash', 'sh', 'zsh' },
  },
  csharp_ls = {},
  dockerls = {},
  gopls = {
    settings = {
      gopls = {
        analyses = {
          unusedvariable = true,
          unusedparams = true,
          shadow = true,
        },
        staticcheck = true,
      },
    },
  },
  jsonls = {
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
        format = { enable = true },
      },
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          keywordSnippet = 'Disable',
        },
        diagnostics = {
          globals = { 'hs', 'packer_plugins', 'spoon', 'vim' },
          disable = { 'missing-parameter' },
        },
        format = {
          enable = true,
          defaultConfig = {
            quote_style = 'single',
            continuation_indent_size = '2',
            continuous_assign_statement_align_to_equal_sign = true,
            continuous_assign_table_field_align_to_equal_sign = true,
          },
        },
        workspace = {
          maxPreload = 2000,
          preloadFileSize = 1000,
          checkThirdParty = false,
        },
      },
    },
  },
  tsserver = {},
  vimls = {},
  yamlls = {
    settings = {
      yaml = {
        schemas = require('schemastore').json.schemas(),
        format = { enable = true },
        validate = true,
        hover = true,
        completion = true,
      },
    },
  },
  sourcekit = {},
  solargraph = {},
  pylsp = {},
  taplo = {},
  marksman = {},
  prosemd_lsp = {},
  -- omnisharp = {},
}
