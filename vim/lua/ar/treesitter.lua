require('nvim-treesitter.configs').setup({
  ensure_installed = 'maintained',
  highlight = {
    enable = true,
    disable = { 'bash', 'go', 'rust' },
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
})

function _G.Type()
  print(require('nvim-treesitter.ts_utils').get_node_at_cursor():type())
end
