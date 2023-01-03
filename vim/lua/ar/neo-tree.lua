vim.g.neo_tree_remove_legacy_commands = 1

require('neo-tree').setup({
  sources = {
    'filesystem',
    'buffers',
    'git_status',
    'diagnostics',
  },
  source_selector = {
    winbar = true,
    content_layout = 'center',
  },
  close_if_last_window = true,
  filesystem = {
    filtered_items = {
      visible = true,
      hide_dotfiles = false,
      hide_gitignored = false,
      never_show = { '.DS_Store', '.git' },
    },
  },
  window = {
    width = 35,
    mappings = {
      ['<space>'] = false, -- borks fzf mappings
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
    },
    name = { trailing_slash = true },
    indent = { padding = 0 },
    git_status = {
      symbols = {
        -- Change type
        added     = '✚', -- NOTE: you can set any of these to an empty string to not show them
        deleted   = '✖',
        modified  = '',
        renamed   = '',
        -- Status type
        untracked = '★',
        ignored   = '',
        unstaged  = '✗', -- '',
        staged    = '✓',
        conflict  = '',
      },
      align = 'right',
    },
  },
})

vim.keymap.set('n', '<leader>n', [[<cmd>Neotree toggle<cr]])
vim.keymap.set('n', '<leader>e', [[<cmd>Neotree reveal<cr>]])
