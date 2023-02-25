local has_gitsigns, gitsigns = pcall(require, 'gitsigns')

if not has_gitsigns then
  vim.notify('gitsigns not found/installed/loaded..', vim.log.levels.WARN)
  return
end

gitsigns.setup(
  {
    debug_mode = true,
    keymaps = {
      noremap = true,
      buffer = true,
      ['o ih'] = ':<C-U>Gitsigns select_hunk()<CR>',
      ['x ih'] = ':<C-U>Gitsigns select_hunk()<CR>',
    },
    on_attach = function()
      vim.keymap.set('n', ']c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gitsigns.next_hunk() end)
        return '<Ignore>'
      end, { expr = true, desc = 'jump to next hunk' })

      vim.keymap.set('n', '[c', function()
        if vim.wo.diff then return ']c' end
        vim.schedule(function() gitsigns.prev_hunk() end)
        return '<Ignore>'
      end, { expr = true, desc = 'jump to prev hunk ' })
    end,
  }
)
