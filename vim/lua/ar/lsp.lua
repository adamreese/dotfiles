local lspconfig = require('lspconfig')

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
  { name = 'LspDiagnosticsSignError', text = '❯', texthl = 'LspDiagnosticsSignError' },
  { name = 'LspDiagnosticsSignHint', text = '❯', texthl = 'LspDiagnosticsSignHint' },
  { name = 'LspDiagnosticsSignWarning', text = '❯', texthl = 'LspDiagnosticsSignWarning' },
  { name = 'LspDiagnosticsSignInformation', text = '❯', texthl = 'LspDiagnosticsSignInformation' },
})

-- [ handlers ] ----------------------------------------------------------------

-- vim.lsp.handlers["textDocument/formatting"] = function(err, result, ctx)
--   if err ~= nil or result == nil then
--     return
--   end
--   if not vim.api.nvim_buf_get_option(ctx.bufnr, 'modified') then
--     local view = vim.fn.winsaveview()
--     vim.lsp.util.apply_text_edits(result, ctx.bufnr)
--     vim.fn.winrestview(view)
--     if ctx.bufnr == vim.api.nvim_get_current_buf() then
--       vim.cmd([[noautocmd :update]])
--     end
--   end
-- end

vim.lsp.handlers['textDocument/publishDiagnostics'] = function(...)
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = false,
    signs = true,
    update_in_insert = false,
  })(...)
  pcall(vim.lsp.diagnostic.set_loclist, { open_loclist = false })
end

-- [ onattach ] ----------------------------------------------------------------

local on_attach = function(client, bufnr)
  local function map(mode, key, result)
    vim.api.nvim_buf_set_keymap(bufnr, mode, key, result, { noremap = true, silent = true })
  end

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  vim.cmd [[command! LspDefinition lua vim.lsp.buf.definition()]]
  vim.cmd [[command! LspDeclaration lua vim.lsp.buf.definition()]]
  vim.cmd [[command! LspCodeAction lua vim.lsp.buf.code_action()]]
  vim.cmd [[command! LspHover lua vim.lsp.buf.hover()]]
  vim.cmd [[command! LspRename lua vim.lsp.buf.rename()]]
  vim.cmd [[command! LspReferences lua vim.lsp.buf.references()]]
  vim.cmd [[command! LspTypeDefinition lua vim.lsp.buf.type_definition()]]
  vim.cmd [[command! LspImplementation lua vim.lsp.buf.implementation()]]
  vim.cmd [[command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev()]]
  vim.cmd [[command! LspDiagNext lua vim.lsp.diagnostic.goto_next()]]
  vim.cmd [[command! LspDiagLine lua vim.lsp.diagnostic.show_line_diagnostics()]]
  vim.cmd [[command! LspSignatureHelp lua vim.lsp.buf.signature_help()]]
  vim.cmd [[command! LspDocumentSymbol lua vim.lsp.buf.document_symbol()]]
  vim.cmd [[command! LspWorkspaceSymbol lua vim.lsp.buf.workspace_symbol()]]

  -- Mappings.
  map('n', 'gD',         '<Cmd>lua vim.lsp.buf.declaration()<CR>')
  map('n', 'gd',         '<Cmd>lua vim.lsp.buf.definition()<CR>')
  map('n', 'gs',         '<Cmd>split | lua vim.lsp.buf.definition()<CR>')
  map('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
  map('n', '<leader>k',  '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  map('n', '<leader>gd', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
  map('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>')
  map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')

  map('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
  map('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')

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

local system_name
if vim.fn.has('mac') then
  system_name = 'macOS'
elseif vim.fn.has('unix') then
  system_name = 'Linux'
else
  print('Unsupported system for sumneko')
end

local function get_lua_runtime()
  local result = {}
  for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
    local lua_path = path .. '/lua/'
    if vim.fn.isdirectory(lua_path) then
      result[lua_path] = true
    end
  end

  result[vim.fn.expand('$VIMRUNTIME/lua')] = true
  result[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
  result[vim.fn.expand('/Applications/Hammerspoon.app/Contents/Resources/extensions/hs')] = true

  return result
end

local function install_path(lang)
  return vim.fn.expand('$XDG_DATA_HOME/lsp/' .. lang)
end

local servers = {
  bashls = {
    filetypes = { 'bash', 'sh', 'zsh' },
  },
  dockerls = {},
  gopls = {},
  jsonls = {
    settings = {
      json = {
        format = { enable = true },
      },
    },
  },
  rust_analyzer = {
    settings = {
      ['rust-analyzer.cargo.allFeatures'] = true,
    },
  },
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
  sumneko_lua = {
    cmd = {
      install_path('sumneko_lua/bin/' .. system_name .. '/lua-language-server'),
      '-E',
      install_path('sumneko_lua/main.lua'),
    },
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          path = vim.split(package.path, ';'),
        },
        completion = {
          keywordSnippet = 'Disable',
        },
        diagnostics = {
          globals = { 'hs', 'vim' },
        },
        workspace = {
          maxPreload = 2000,
          preloadFileSize = 1000,
          library = get_lua_runtime(),
        },
      },
    },
  },
  clangd = {},
  sourcekit = {},
  omnisharp = {
    cmd = { install_path('omnisharp/run'),  "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
    on_new_config = function(config, root_dir)
      if root_dir then
        for _, p in ipairs(vim.fn.glob(util.path.join(root_dir, '*.sln'), true, true)) do
          if lspconfig.util.path.exists(p) then
            root_dir = p
          end
        end
        config.cmd = { install_path('omnisharp/run'),  "--languageserver", "--hostPID", tostring(vim.fn.getpid()), "-s", root_dir }
      end
    end,
  },
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

  for server, config in pairs(servers) do
    lspconfig[server].setup(vim.tbl_deep_extend('force', {
          flags = { debounce_text_changes = 500 },
          on_attach = on_attach,
          capabilities = capabilities,
      }, config))
  end
end

setup_servers()

-- [ lspfuzzy ] ----------------------------------------------------------------

require('lspfuzzy').setup({})

vim.cmd [[command! -nargs=? ZkNew :lua require'lspconfig'.zk.new(<args>)]]
vim.cmd([[command! LspLog :lua vim.cmd('tabe ' .. vim.lsp.get_log_path())]])
