local function get_current_gomod()
  local file = io.open('go.mod', 'r')
  if file == nil then return nil end

  local mod_name = file:read():gsub('module ', '')
  file:close()
  return mod_name
end

return {
  bashls = {
    filetypes = { 'bash', 'sh', 'zsh' },
  },
  -- csharp_ls = {},
  omnisharp = {
    cmd = { 'dotnet', vim.fn.stdpath('data') .. '/mason/packages/omnisharp/libexec/Omnisharp.dll' },
    enable_editorconfig_support = true,
  },
  dockerls = {},
  gopls = {
    cmd = { 'gopls', '-remote.debug=:0' },
    settings = {
      gopls = {
        analyses = {
          fieldalignment = false,
          shadow = true,
          unusedvariable = true,
          useany = true,
        },
        ['local'] = get_current_gomod(),
        buildFlags = { '-tags', 'integration' },
        completeUnimported = true,
        diagnosticsDelay = '500ms',
        matcher = 'Fuzzy',
        semanticTokens = true,
        staticcheck = true,
        symbolMatcher = 'fuzzy',
        usePlaceholders = true,
      },
    },
  },
  jsonls = {
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
        validate = { enable = true },
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
          globals = { 'hs', 'spoon', 'vim' },
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
        semantic = {
          enable = false,
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
  bufls = {},
}
