local lspconfig = require('lspconfig')
local handlers = require('ar.lsp.handlers')

local M = {
  format_on_save = true
}

vim.diagnostic.config({
  underline = true,
  virtual_text = false,
  signs = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'single',
    source = true,
    header = '',
  },
})

vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '󰔷', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

vim.lsp.handlers['textDocument/hover'] = handlers.hover()
vim.lsp.handlers['textDocument/signatureHelp'] = handlers.signature_help()

-- [ format on save ] ----------------------------------------------------------

function M.format_toggle()
  M.format_on_save = not M.format_on_save
  vim.g.whitespace_enable = M.format_on_save
  vim.notify('auto format set to ' .. tostring(M.format_on_save))
end

function M.format()
  if M.format_on_save then
    vim.lsp.buf.format()
  end
end

vim.api.nvim_create_user_command('FormatToggle', function()
  M.format_toggle()
end, {})

vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump({ count = -1 })
end, { desc = 'diagnostic: previous', silent = true })

vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump({ count = 1 })
end, { desc = 'diagnostic: previous', silent = true })

-- [ onattach ] ----------------------------------------------------------------

local function setup_mappings(client, bufnr)
  vim.api.nvim_buf_create_user_command(bufnr, 'LspDefinition', vim.lsp.buf.definition, {})
  vim.api.nvim_buf_create_user_command(bufnr, 'LspDeclaration', vim.lsp.buf.definition, {})
  vim.api.nvim_buf_create_user_command(bufnr, 'LspHover', vim.lsp.buf.hover, {})
  vim.api.nvim_buf_create_user_command(bufnr, 'LspRename', vim.lsp.buf.rename, {})
  vim.api.nvim_buf_create_user_command(bufnr, 'LspReferences', vim.lsp.buf.references, {})
  vim.api.nvim_buf_create_user_command(bufnr, 'LspTypeDefinition', vim.lsp.buf.type_definition, {})
  vim.api.nvim_buf_create_user_command(bufnr, 'LspImplementation', vim.lsp.buf.implementation, {})
  vim.api.nvim_buf_create_user_command(bufnr, 'LspSignatureHelp', vim.lsp.buf.signature_help, {})
  vim.api.nvim_buf_create_user_command(bufnr, 'LspDocumentSymbol', vim.lsp.buf.document_symbol, {})
  vim.api.nvim_buf_create_user_command(bufnr, 'LspWorkspaceSymbol', vim.lsp.buf.workspace_symbol, {})

  vim.api.nvim_buf_create_user_command(bufnr, 'LspToggleInlayHints', function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    vim.notify('Inlay hints set to ' .. tostring(vim.lsp.inlay_hint.is_enabled()))
  end, {})

  -- Mappings.
  local function opts(desc)
    return { desc = desc, silent = true, buffer = bufnr }
  end

  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts('lsp: declaration'))
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts('lsp: definition'))
  vim.keymap.set('n', 'gs', function() require('ar.lsp.handlers').definition('split') end, opts('lsp: definition split'))
  vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, opts('lsp: implementation'))
  vim.keymap.set('n', '<leader>k', vim.lsp.buf.signature_help, opts('lsp: signature help'))
  vim.keymap.set('n', '<leader>gd', vim.lsp.buf.type_definition, opts('lsp: type declaration'))
  vim.keymap.set('n', '<leader>gr', vim.lsp.buf.references, opts('lsp: references'))
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts('lsp: rename'))

  vim.keymap.set('n', '<leader>ls', vim.lsp.buf.document_symbol, opts('lsp: document symbol'))
  vim.keymap.set('n', '<leader>lS', vim.lsp.buf.workspace_symbol, opts('lsp: workspace symbol'))

  -- Set some keybinds conditional on server capabilities
  if client.server_capabilities.documentFormattingProvider and client.name ~= 'gopls' then
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, opts('lsp: format'))

    vim.keymap.set('n', '<leader>tf', function() require('ar.lsp').format_toggle() end, opts('lsp: auto format toggle'))

    local augid = vim.api.nvim_create_augroup('LspFormatting', { clear = true })
    vim.api.nvim_create_autocmd('BufWritePre', {
      desc = 'LSP: Format on save',
      buffer = bufnr,
      callback = function() M.format() end,
      group = augid,
    })
  elseif client.server_capabilities.documentRangeFormatting then
    vim.keymap.set('x', '<leader>f', vim.lsp.buf.format, opts('lsp: format'))
  end

  if client.server_capabilities.documentHighlightProvider then
    local augid = vim.api.nvim_create_augroup('LspReferences', { clear = true })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      desc = 'LSP: References',
      buffer = bufnr,
      group = augid,
      callback = function() vim.lsp.buf.document_highlight() end,
    })
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'WinLeave' }, {
      callback = function() vim.lsp.buf.clear_references() end,
      desc = 'LSP: References Clear',
      buffer = bufnr,
      group = augid,
    })
  end
end

local function on_attach(client, bufnr)
  vim.schedule(function()
    setup_mappings(client, bufnr)
  end)
end

-- Disable yamlls for helm templates
require('ar.lsp.utils').on_attach(function(_, bufnr)
  if vim.bo[bufnr].filetype == 'helm' then
    vim.schedule(function()
      vim.cmd('LspStop ++force yamlls')
    end)
  end
end, 'yamlls')

function M.setup()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  local function with_defaults(opts)
    opts = opts or {}
    return vim.tbl_deep_extend('keep', opts, {
      flags = { debounce_text_changes = 500 },
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end

  for server, config in pairs(require('ar.lsp.servers')) do
    lspconfig[server].setup(with_defaults(config))
  end

  require('rust-tools').setup({
    server = with_defaults({
      standalone = false,
      settings = {
        ['rust-analyzer'] = {
          cargo = { allFeatures = true },
        },
      },
    }),
  })
end

return M
