local exceptions = {
  fugitiveblame = 'Blame',
  fzf           = 'FZF',
  gitcommit     = 'Commit Message',
  godoc         = 'GoDoc',
  help          = 'Help',
  nerdtree      = 'NERDTree',
  qf            = 'Quickfix',
  tagbar        = 'Tagbar',
  list          = 'List',
  Outline       = 'Outline',
  packer        = 'Packer',
  ['neo-tree']  = 'Neotree'
}

return function()
  local path = vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
  local ft = vim.api.nvim_buf_get_option(0, 'filetype')
  local name = exceptions[ft] or vim.fs.basename(vim.api.nvim_buf_get_name(0))
  return string.format(' %s (%s)', name, path)
end
