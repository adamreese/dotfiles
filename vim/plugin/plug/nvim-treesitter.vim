" =======================================================================
" plugin/plug/nvim-treesitter.vim
" =======================================================================
if !ar#plug#IsLoaded('nvim-treesitter') | finish | endif

lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = 'maintained',
  highlight = {
    enable = true,
    disable = {'bash', 'go', 'rust'},
  },
  indent = {
    enable = true,
    disable = {'rust'},
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
}
EOF
