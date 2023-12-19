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
        'diff',
        'dockerfile',
        'gitcommit',
        'git_rebase',
        'go',
        'godot_resource',
        'gomod',
        'gowork',
        'graphql',
        'hcl',
        'html',
        'javascript',
        'jsdoc',
        'json',
        'json5',
        'jsonc',
        'lua',
        'make',
        'markdown',
        'markdown_inline',
        'ninja',
        'proto',
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
