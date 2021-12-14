local lspconfig = require('lspconfig')

-- [ commands ] ----------------------------------------------------------------

vim.cmd([[command! LspLog :lua vim.cmd('tabe ' .. vim.lsp.get_log_path())]])

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

vim.fn.sign_define({
  { name = 'DiagnosticSignError', text = '❯', texthl = 'DiagnosticSignError' },
  { name = 'DiagnosticSignHint', text = '❯', texthl = 'DiagnosticSignHint' },
  { name = 'DiagnosticSignWarn', text = '❯', texthl = 'DiagnosticSignWarn' },
  { name = 'DiagnosticSignInfo', text = '❯', texthl = 'DiagnosticSignInfo' },
})

vim.diagnostic.config {
  underline = true,
  virtual_text = false,
  signs = true,
  update_in_insert = false,
  severity_sort = true,
}

-- [ onattach ] ----------------------------------------------------------------

local on_attach = function(client, bufnr)
  local function map(mode, key, result)
    vim.api.nvim_buf_set_keymap(bufnr, mode, key, result, { noremap = true, silent = true })
  end

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  vim.cmd([[command! LspDefinition lua vim.lsp.buf.definition()]])
  vim.cmd([[command! LspDeclaration lua vim.lsp.buf.definition()]])
  vim.cmd([[command! LspCodeAction lua vim.lsp.buf.code_action()]])
  vim.cmd([[command! LspHover lua vim.lsp.buf.hover()]])
  vim.cmd([[command! LspRename lua vim.lsp.buf.rename()]])
  vim.cmd([[command! LspReferences lua vim.lsp.buf.references()]])
  vim.cmd([[command! LspTypeDefinition lua vim.lsp.buf.type_definition()]])
  vim.cmd([[command! LspImplementation lua vim.lsp.buf.implementation()]])
  vim.cmd([[command! LspDiagPrev lua vim.diagnostic.goto_prev()]])
  vim.cmd([[command! LspDiagNext lua vim.diagnostic.goto_next()]])
  vim.cmd([[command! LspDiagLine lua vim.diagnostic.show_line_diagnostics()]])
  vim.cmd([[command! LspSignatureHelp lua vim.lsp.buf.signature_help()]])
  vim.cmd([[command! LspDocumentSymbol lua vim.lsp.buf.document_symbol()]])
  vim.cmd([[command! LspWorkspaceSymbol lua vim.lsp.buf.workspace_symbol()]])

  -- Mappings.
  map('n', 'gD',         '<Cmd>lua vim.lsp.buf.declaration()<CR>')
  map('n', 'gd',         '<Cmd>lua vim.lsp.buf.definition()<CR>')
  map('n', 'gs',         [[<Cmd>lua require('ar.lsp.handlers').definition('split')<CR>]])
  map('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  map('n', '<leader>k',  '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  map('n', '<leader>gd', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  map('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>')
  map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')

  map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
  map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')

  map('n', '<leader>ls', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
  map('n', '<leader>lS', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')

  map('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  map('v', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>')

  if vim.api.nvim_buf_get_option(0, 'filetype') ~= 'vim' then
    map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
  end

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    map('n', '<leader>l=', '<cmd>lua vim.lsp.buf.formatting()<CR>')
    vim.b.lsp_formatting = true
    vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting_sync(nil, 1000)' ]])
    vim.api.nvim_command('autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()')
  elseif client.resolved_capabilities.document_range_formatting then
    map('n', '<leader>l=', '<cmd>lua vim.lsp.buf.range_formatting()<CR>')
  end

  require('lsp-status').on_attach(client)
end

local system_name = jit.os:lower() == 'osx' and 'macOS' or jit.os
local luadev = require('lua-dev').setup({
  lspconfig = {
    cmd = {
      vim.fn.expand('$XDG_DATA_HOME/lsp/sumneko_lua/bin/' .. system_name .. '/lua-language-server'),
      '-E',
      vim.fn.expand('$XDG_DATA_HOME/lsp/sumneko_lua/main.lua'),
    },
    settings = {
      Lua = {
        completion = {
          keywordSnippet = 'Disable',
        },
        diagnostics = {
          globals = { 'hs', 'vim' },
        },
        workspace = {
          maxPreload = 2000,
          preloadFileSize = 1000,
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
  gopls = {},
  jsonls = {
    settings = {
      json = {
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
        schemas = {
          ['http://json.schemastore.org/github-workflow'] = '.github/workflows/*.{yml,yaml}',
          ['http://json.schemastore.org/github-action'] = '.github/action.{yml,yaml}',
          ['http://json.schemastore.org/circleciconfig'] = '.circleci/**/*.{yml,yaml}',
        },
        format = { enable = true },
        validate = true,
        hover = true,
        completion = true,
      },
    },
  },
  sourcekit = {},
  zk = {},
}

-- [ lsp-status ] --------------------------------------------------------------

local function setup_servers()
  local status = require('lsp-status')
  status.config({
    status_symbol = ' ',
    indicator_errors = '⨉',
    indicator_warnings = '',
    indicator_info = 'ℹ︎',
    indicator_hint = '○',
  })
  status.register_progress()

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
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

  require('rust-tools').setup({
    tools = {
      autoSetHints = false,
    },
    server = with_defaults({
      settings = {
        ['rust-analyzer.cargo.allFeatures'] = true,
      },
    }),
  })
end

setup_servers()

-- [ lspfuzzy ] ----------------------------------------------------------------

require('lspfuzzy').setup({})
