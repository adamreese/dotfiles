local has_bqf, bqf = pcall(require, 'bqf')

if not has_bqf then
  vim.notify('bqf not found/installed/loaded..', vim.log.levels.WARN)
  return
end

bqf.setup({
  auto_resize_height = true,
  preview = {
    border_chars = { '┃', '┃', '━', '━', '┏', '┓', '┗', '┛', '█' },

    should_preview_cb = function(bufnr)
      -- file size greater than 100kb can't be previewed automatically
      local filename = vim.api.nvim_buf_get_name(bufnr)
      local fsize = vim.fn.getfsize(filename)
      if fsize > 100 * 1024 then
        return false
      end
      return true
    end,

  }
})
