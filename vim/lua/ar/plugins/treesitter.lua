return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPost', 'BufNewFile' },
  build = ':TSUpdate',
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    {
      'nvim-treesitter/playground',
      keys = { { '<leader>H', '<cmd>TSHighlightCapturesUnderCursor<cr>' } },
    },
  },
  config = function()
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
        enable = true,
        -- disable = { 'bash', 'go', 'rust', 'vim', 'help', 'markdown' },
        disable = { 'help', 'rust' },
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

    vim.opt.foldmethod = 'expr'
    vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
  end,
}
