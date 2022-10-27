local lspconfig = require('lspconfig')
local handlers = require('ar.lsp.handlers')

local M = {
  format_on_save = true
}

-- [ commands ] ----------------------------------------------------------------

vim.api.nvim_create_user_command('MyLspInfo', require('ar.lsp.info').show_info, {})

-- [ style ] -------------------------------------------------------------------

vim.lsp.protocol.CompletionItemKind = {
  ' [text]',
  ' [method]',
  ' [function]',
  ' [constructor]',
  'ﰠ [field]',
  ' [variable]',
  ' [class]',
  ' [interface]',
  ' [module]',
  ' [property]',
  ' [unit]',
  ' [value]',
  ' [enum]',
  ' [key]',
  '﬌ [snippet]',
  ' [color]',
  ' [file]',
  ' [reference]',
  ' [folder]',
  ' [enum member]',
  ' [constant]',
  ' [struct]',
  '⌘ [event]',
  ' [operator]',
  '♛ [type]',
}

vim.fn.sign_define('DiagnosticSignError', { text = '❯', texthl = 'DiagnosticSignError', numhl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignHint', { text = '❯', texthl = 'DiagnosticSignHint', numhl = 'DiagnosticSignHint' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '❯', texthl = 'DiagnosticSignInfo', numhl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '❯', texthl = 'DiagnosticSignWarn', numhl = 'DiagnosticSignWarn' })

vim.diagnostic.config({
  underline = true,
  virtual_text = false,
  signs = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

vim.lsp.handlers["textDocument/hover"] = handlers.hover()
vim.lsp.handlers["textDocument/signatureHelp"] = handlers.signature_help()

-- [ format on save ] ----------------------------------------------------------

function M.format_toggle()
  M.format_on_save = not M.format_on_save
end

function M.format()
  if M.format_on_save then
    vim.lsp.buf.formatting_sync({}, 10000)
  end
end

local opts = { silent = true }
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- [ onattach ] ----------------------------------------------------------------

local function setup_mappings(client, bufnr)
  vim.api.nvim_buf_create_user_command(bufnr, 'LspDefinition', vim.lsp.buf.definition, {})
  vim.api.nvim_buf_create_user_command(bufnr, 'LspDeclaration', vim.lsp.buf.definition, {})
  vim.api.nvim_buf_create_user_command(bufnr, 'LspCodeAction', vim.lsp.buf.code_action, {})
  vim.api.nvim_buf_create_user_command(bufnr, 'LspHover', vim.lsp.buf.hover, {})
  vim.api.nvim_buf_create_user_command(bufnr, 'LspRename', vim.lsp.buf.rename, {})
  vim.api.nvim_buf_create_user_command(bufnr, 'LspReferences', vim.lsp.buf.references, {})
  vim.api.nvim_buf_create_user_command(bufnr, 'LspTypeDefinition', vim.lsp.buf.type_definition, {})
  vim.api.nvim_buf_create_user_command(bufnr, 'LspImplementation', vim.lsp.buf.implementation, {})
  vim.api.nvim_buf_create_user_command(bufnr, 'LspSignatureHelp', vim.lsp.buf.signature_help, {})
  vim.api.nvim_buf_create_user_command(bufnr, 'LspDocumentSymbol', vim.lsp.buf.document_symbol, {})
  vim.api.nvim_buf_create_user_command(bufnr, 'LspWorkspaceSymbol', vim.lsp.buf.workspace_symbol, {})

  -- Mappings.
  local bufopts = { silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gs', function() require('ar.lsp.handlers').definition('split') end, bufopts)
  vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>gd', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)

  vim.keymap.set('n', '<leader>ls', vim.lsp.buf.document_symbol, bufopts)
  vim.keymap.set('n', '<leader>lS', vim.lsp.buf.workspace_symbol, bufopts)

  vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('v', '<leader>la', vim.lsp.buf.code_action, bufopts)


  if vim.o.filetype ~= 'vim' then
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  end

  -- Set some keybinds conditional on server capabilities
  if client.server_capabilities.document_formatting then
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)

    vim.api.nvim_create_user_command('FormatC', function()
      vim.lsp.buf.formatting_sync({}, 1000)
    end, {})

    vim.keymap.set('n', '<leader>tf', function() require('ar.lsp').format_toggle() end, bufopts)

    local augid = vim.api.nvim_create_augroup('ar_lsp_format', { clear = true })
    vim.api.nvim_create_autocmd('BufWritePre', {
      desc = 'Auto format before save',
      buffer = bufnr,
      callback = function() M.format() end,
      group = augid,
    })
  elseif client.server_capabilities.document_range_formatting then
    vim.keymap.set('x', '<leader>f', vim.lsp.buf.range_formatting, bufopts)
  end
end

local function on_attach(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  vim.schedule(function()
    setup_mappings(client, bufnr)
  end)

  require('lsp-status').on_attach(client)
end

local luadev = require('lua-dev').setup({
  lspconfig = {
    cmd = {
      vim.fn.stdpath('data') .. '/lsp/sumneko_lua/bin/lua-language-server',
      '-E',
      vim.fn.stdpath('data') .. '/lsp/sumneko_lua/main.lua',
    },
    settings = {
      Lua = {
        completion = {
          keywordSnippet = 'Disable',
        },
        diagnostics = {
          globals = { 'hs', 'packer_plugins', 'spoon', 'vim' },
          disable = { 'missing-parameter' },
        },
        workspace = {
          maxPreload = 2000,
          preloadFileSize = 1000,
          checkThirdParty = false,
        },
      },
    },
  },
})

local servers = {
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
  sumneko_lua = luadev,
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
}

local function setup_servers()
  local status = require('lsp-status')
  status.config({
    status_symbol = '',
    indicator_errors = '⨉',
    indicator_warnings = '',
    indicator_info = 'ℹ︎',
    indicator_hint = '○',
  })
  status.register_progress()

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
  capabilities = vim.tbl_extend('keep', capabilities, status.capabilities)

  local function with_defaults(opts)
    opts = opts or {}
    return vim.tbl_deep_extend('keep', opts, {
      flags = { debounce_text_changes = 500 },
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end

  for server, config in pairs(servers) do
    lspconfig[server].setup(with_defaults(config))
  end

  require('zk').setup({
    picker = 'fzf',
    lsp = {
      config = {
        on_attach = on_attach,
        capabilities = capabilities,
      },
    },
  })

  require('rust-tools').setup({
    tools = {
      inlay_hints = {
        highlight = "RustInlay",
      },
    },
    server = with_defaults({
      cmd = { vim.env.XDG_DATA_HOME .. '/rustup/toolchains/nightly-aarch64-apple-darwin/bin/rust-analyzer' },
      settings = {
        ['rust-analyzer.cargo.allFeatures'] = true,
      },
    }),
  })
end

setup_servers()

return M
