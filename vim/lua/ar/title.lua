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
  local name = ''
  if exceptions[ft] ~= nil then
    name = exceptions[ft]
  else
    name = vim.fs.basename(vim.api.nvim_buf_get_name(0))
  end
  return string.format(' %s (%s)', name, path)
end
