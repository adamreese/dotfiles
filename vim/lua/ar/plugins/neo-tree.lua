vim.g.neo_tree_remove_legacy_commands = 1

vim.keymap.set('n', '<leader>n', [[<cmd>Neotree toggle<cr>]])
vim.keymap.set('n', '<leader>e', [[<cmd>Neotree reveal<cr>]])

return {
  'nvim-neo-tree/neo-tree.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
  },
  opts = {
    sources = {
      'filesystem',
      'git_status',
    },
    enable_diagnostics = false,
    source_selector = {
      winbar = true,
      content_layout = 'center',
    },
    open_files_do_not_replace_types = { 'terminal', 'trouble', 'qf', 'tagbar' },
    close_if_last_window = true,
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
        never_show = { '.DS_Store', '.git' },
      },
    },
    window = {
      width = 35,
      mappings = {
        ['<space>'] = false, -- borks fzf mappings
        ['/'] = false,
        ['i'] = 'open_split',
        ['v'] = 'open_vsplit',
        ['x'] = 'close_node',
      },
    },
    default_component_configs = {
      icon = {
        folder_closed = '▸',
        folder_open = '▾',
        folder_empty = 'ﰊ',
        default = '',
      },
      name = {
        trailing_slash = true,
        use_git_status_colors = false,
      },
      indent = { padding = 0 },
      git_status = {
        symbols = {
          -- Change type
          added     = '',
          deleted   = '✖',
          modified  = '',
          renamed   = '',
          -- Status type
          untracked = '',
          ignored   = '',
          unstaged  = '', -- 'ϟ',
          staged    = '✓',
          conflict  = '',
        },
        align = 'right',
      },
    },
  }
}
