local lspconfig = require('lspconfig')

local M = {
  format_on_save = true
}

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

vim.fn.sign_define('DiagnosticSignError', { text = '❯', texthl = 'DiagnosticSignError', numhl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignHint', { text = '❯', texthl = 'DiagnosticSignHint', numhl = 'DiagnosticSignHint' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '❯', texthl = 'DiagnosticSignInfo', numhl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '❯', texthl = 'DiagnosticSignWarn', numhl = 'DiagnosticSignWarn' })

vim.diagnostic.config {
  underline = true,
  virtual_text = false,
  signs = true,
  update_in_insert = false,
  severity_sort = true,
}

-- [ format on save ] ----------------------------------------------------------

function M.format_toggle()
  M.format_on_save = not M.format_on_save
end

function M.format()
  if M.format_on_save then
    vim.lsp.buf.formatting_sync(nil, 10000)
  end
end

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
  map('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
  map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>')
  map('n', 'gs', [[<Cmd>lua require('ar.lsp.handlers').definition('split')<CR>]])
  map('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  map('n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  map('n', '<leader>gd', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  map('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>')
  map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')

  map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
  map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')

  map('n', '<leader>ls', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
  map('n', '<leader>lS', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')

  map('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  map('v', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<CR>')

  if vim.o.filetype ~= 'vim' then
    map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
  end

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    map('n', '<leader>l=', '<cmd>lua vim.lsp.buf.formatting()<CR>')
    map('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')

    vim.api.nvim_create_user_command('FormatC', function()
      vim.lsp.buf.formatting_sync(nil, 1000)
    end, {})

    map('n', '<leader>tf', [[<cmd>lua require('ar.lsp').format_toggle()<CR>]])

    local augid = vim.api.nvim_create_augroup('lsp_fmt_on_save', { clear = true })
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      callback = function()
        M.format()
      end,
      group = augid,
    })
  elseif client.resolved_capabilities.document_range_formatting then
    map('x', '<leader>l=', '<cmd>lua vim.lsp.buf.range_formatting()<CR>')
    map('x', '<leader>f', '<cmd>lua vim.lsp.buf.range_formatting()<CR>')
  end

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
    server = with_defaults({
      cmd = { vim.env.HOME .. '/.rustup/toolchains/nightly-aarch64-apple-darwin/bin/rust-analyzer' },
      settings = {
        ['rust-analyzer.cargo.allFeatures'] = true,
      },
    }),
  })
end

setup_servers()

return M
