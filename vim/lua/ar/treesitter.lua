require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'bash',
    'c',
    'c_sharp',
    'cmake',
    'comment',
    'cpp',
    'css',
    'dockerfile',
    'go',
    'godot_resource',
    'gomod',
    'gowork',
    'graphql',
    'hcl',
    'help',
    'html',
    'javascript',
    'jsdoc',
    'json',
    'json5',
    'jsonc',
    'lua',
    'make',
    'markdown',
    'ninja',
    'python',
    'query',
    'regex',
    'ruby',
    'rust',
    'scss',
    'swift',
    'teal',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'yaml',
  },
  highlight = {
    enable = false,
    -- disable = { 'bash', 'go', 'rust', 'vim' },
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
  },
  autopairs = { enable = true },
  matchup = { enable = true },
})

function _G.Type()
  print(require('nvim-treesitter.ts_utils').get_node_at_cursor():type())
end

-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
