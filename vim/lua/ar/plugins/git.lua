return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      debug_mode = true,
      on_attach = function()
        vim.keymap.set('n', ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() require('gitsigns').next_hunk() end)
          return '<Ignore>'
        end, { expr = true, desc = 'jump to next hunk' })

        vim.keymap.set('n', '[c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() require('gitsigns').prev_hunk() end)
          return '<Ignore>'
        end, { expr = true, desc = 'jump to prev hunk ' })

        vim.keymap.set({ 'o', 'x' }, 'ih', function()
          require('gitsigns.actions').select_hunk()
        end, { desc = 'in hunk' })

        vim.keymap.set({ 'o', 'x' }, 'ah', function()
          require('gitsigns.actions').select_hunk()
        end, { desc = 'around hunk' })
      end,
    }
  },
  {
    'rhysd/committia.vim',
    init = function()
      vim.g.committia_open_only_vim_starting = false
    end,
  },
  'tpope/vim-fugitive',
  'tpope/vim-git',
  'tpope/vim-rhubarb',
  {
    'sindrets/diffview.nvim',
    cmd = 'DiffviewOpen',
    config = true,
  },
}
