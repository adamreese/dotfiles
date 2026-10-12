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

    local client = vim.lsp.get_client_by_id(ctx.client_id)
    local offset_encoding = client and client.offset_encoding or 'utf-16'

    -- result may be a single Location/LocationLink or a list of them
    local location = result
    if vim.islist(result) or (result[1] ~= nil) then
      location = result[1]
    end

    vim.lsp.util.show_document(location, offset_encoding, { focus = true })
  end
end

---
--- Jumps to the definition of the symbol under the cursor.
---
function M.definition(split_cmd)
  local params = vim.lsp.util.make_position_params(0, 'utf-16')
  return vim.lsp.buf_request(0, 'textDocument/definition', params, goto_definition(split_cmd))
end

function M.hover()
  vim.lsp.buf.hover({ border = border })
end

function M.signature_help()
  vim.lsp.buf.signature_help({ border = border })
end

return M
