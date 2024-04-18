-- sort quickfix list by filename
local function sort_list()
  local items = vim.fn.getqflist()
  table.sort(items, function(a, b)
    if a.bufnr ~= b.bufnr then
      return vim.fn.bufname(a.bufnr) < vim.fn.bufname(b.bufnr)
    end
    if a.lnum == b.lnum then
      return a.col < b.col
    end
    return a.lnum < b.lnum
  end)
  vim.fn.setqflist(items, 'r')
end

vim.api.nvim_buf_create_user_command(0, 'Sort', sort_list, {})

vim.keymap.set('n', '<leader>k', ':Keep ', { buffer = true })
vim.keymap.set('n', '<leader>r', ':Reject ', { buffer = true })

vim.keymap.set('n', '<Left>', '<Plug>(qf_older)', { buffer = true })
vim.keymap.set('n', '<Right>', '<Plug>(qf_newer)', { buffer = true })

vim.keymap.set('n', '{', '<Plug>(qf_previous_file)', { buffer = true })
vim.keymap.set('n', '}', '<Plug>(qf_next_file)', { buffer = true })
