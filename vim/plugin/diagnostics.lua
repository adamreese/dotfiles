vim.diagnostic.config({
  underline = true,
  virtual_text = false,
  update_in_insert = false,
  severity_sort = true,
  jump = { float = true },
  float = {
    focusable = false,
    style = 'minimal',
    border = 'single',
    source = true,
    header = '',
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '󰔷',
      [vim.diagnostic.severity.HINT] = '',
      [vim.diagnostic.severity.INFO] = '',
    },
  },
})

-- vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
-- vim.fn.sign_define('DiagnosticSignWarn', { text = '󰔷', texthl = 'DiagnosticSignWarn' })
-- vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
-- vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })
