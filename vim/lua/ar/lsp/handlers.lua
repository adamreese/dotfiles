local M = {}

local border = {
  { '┏', 'Blue' },
  { '━', 'Blue' },
  { '┓', 'Blue' },
  { '┃', 'Blue' },
  { '┛', 'Blue' },
  { '━', 'Blue' },
  { '┗', 'Blue' },
  { '┃', 'Blue' },
}

local function goto_definition(split_cmd)
  local log = require('vim.lsp.log')

  return function(_, result, ctx)
    if result == nil or vim.tbl_isempty(result) then
      local _ = log.info() and log.info(ctx.method, 'No location found')
      return nil
    end

    if split_cmd then
      vim.cmd(split_cmd)
    end

    return vim.lsp.handlers['textDocument/definition'](_, result, ctx, _)
  end
end

---
--- Jumps to the definition of the symbol under the cursor.
---
function M.definition(split_cmd)
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textDocument/definition', params, goto_definition(split_cmd))
end

function M.hover()
  return vim.lsp.with(vim.lsp.handlers.hover, { border = border })
end

function M.signature_help()
  return vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })
end

-- https://github.com/neovim/nvim-lspconfig/wiki/User-contributed-tips#use-nvim-notify-to-display-lsp-messages
function M.show_message()
  return function(_, result, ctx)
    local client = vim.lsp.get_client_by_id(ctx.client_id)
    local lvl = ({ 'ERROR', 'WARN', 'INFO', 'DEBUG' })[result.type]
    vim.notify(result.message, lvl, {
      title = 'LSP | ' .. client.name,
      timeout = 10000,
      keep = function()
        return lvl == 'ERROR' or lvl == 'WARN'
      end,
    })
  end
end

return M
