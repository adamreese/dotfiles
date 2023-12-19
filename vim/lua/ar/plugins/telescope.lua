local M = {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  keys = { '<space>f', '<space>F', '<space>b', '<space>h', '<space>m', '<space>d', '<space>S', '<space>s' },
  dependencies = {
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      config = function() require('telescope').load_extension('fzf') end,
    },
    {
      'benfowler/telescope-luasnip.nvim',
      config = function() require('telescope').load_extension('luasnip') end,
    },
    {
      'nvim-telescope/telescope-file-browser.nvim',
      config = function() require('telescope').load_extension('file_browser') end,
    },
    {
      'debugloop/telescope-undo.nvim',
      config = function() require('telescope').load_extension('undo') end,
    }
  },
}

function M.config()
  local telescope = require('telescope')
  local actions = require('telescope.actions')
  local layout_actions = require('telescope.actions.layout')

  local opts = {
    defaults = {
      set_env = { ['TERM'] = vim.env.TERM },
      results_title = false,
      layout_strategy = 'flex',
      cycle_layout_list = { 'horizontal', 'vertical', 'bottom_pane', 'center', 'flex' },
      layout_config = {
        horizontal = {
          preview_width = 0.45,
        },
        width = 0.9,
        height = 0.8,
        vertical = {
          height = 0.95,
          width  = 0.95,
        }
      },
      mappings = {
        i = {
          -- ['<esc>'] = actions.close,
          ['<c-s>'] = actions.select_horizontal,
          ['<c-b>'] = actions.preview_scrolling_up,
          ['<c-f>'] = actions.preview_scrolling_down,
          ['<c-e>'] = layout_actions.toggle_preview,
          ['<c-l>'] = layout_actions.cycle_layout_next,
          ['<c-j>'] = actions.cycle_history_next,
          ['<c-k>'] = actions.cycle_history_prev,
          ['<c-q>'] = actions.send_selected_to_qflist,
        },
        n = {
          ['<c-q>'] = actions.send_selected_to_qflist,
          ['<c-l>'] = actions.send_to_qflist,
        },
      },
      history = {
        path = vim.fn.stdpath('data') .. '/telescope_history.sqlite3',
      },
    },
    pickers = {
      find_files = {
        hidden = true,
        find_command = { 'fd', '--type', 'f', '--strip-cwd-prefix' },
      },
      buffers = {
        sort_mru = true,
        sort_lastused = true,
        show_all_buffers = true,
        ignore_current_buffer = true,
      },
    },
  }
  telescope.setup(opts)

  local function mapopts(desc)
    return { desc = desc, noremap = true, silent = true }
  end

  vim.keymap.set('n', '<space>f', '<cmd>Telescope find_files<cr>', mapopts('telescope: find files'))
  vim.keymap.set('n', '<space>F', '<cmd>Telescope file_browser<cr>', mapopts('telescope: file_browser'))
  vim.keymap.set('n', '<space>g', '<cmd>Telescope live_grep<cr>', mapopts('telescope: live grep'))
  vim.keymap.set('n', '<space>b', '<cmd>Telescope buffers<cr>', mapopts('telescope: buffers'))
  vim.keymap.set('n', '<space>h', '<cmd>Telescope help_tags<cr>', mapopts('telescope: help tags'))
  vim.keymap.set('n', '<space>m', '<cmd>Telescope git_status<cr>', mapopts('telescope: git status'))
  vim.keymap.set('n', '<space>s', '<cmd>Telescope lsp_document_symbols<cr>', mapopts('telescope: lsp document symbols'))
  vim.keymap.set('n', '<space>S', '<cmd>Telescope lsp_workspace_symbols<cr>', mapopts('telescope: lsp workspace symbols'))
  vim.keymap.set('n', '<space>d', '<cmd>Telescope diagnostics<cr>', mapopts('telescope: diagnostics'))
  vim.keymap.set('n', '<space>t', '<cmd>Telescope current_buffer_tags<cr>', mapopts('telescope: current buffer tags'))
  vim.keymap.set('n', '<space>T', '<cmd>Telescope tags<cr>', mapopts('telescope: tags'))
end

return M
