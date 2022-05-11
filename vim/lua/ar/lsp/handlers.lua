local M = {}

local function goto_definition(split_cmd)
  local log = require('vim.lsp.log')

  local handler = function(_, result, ctx)
    if result == nil or vim.tbl_isempty(result) then
      local _ = log.info() and log.info(ctx.method, 'No location found')
      return nil
    end

    if split_cmd then
      vim.cmd(split_cmd)
    end

    return vim.lsp.handlers['textDocument/definition'](_, result, ctx)
  end

  return handler
end

---
--- Jumps to the definition of the symbol under the cursor.
---
function M.definition(split_cmd)
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textDocument/definition', params, goto_definition(split_cmd))
end

return M
