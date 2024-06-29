return {
  'PotatoesMaster/i3-vim-syntax',
  'adamclerk/vim-razor',
  'cespare/vim-toml',
  'chrisbra/vim-sh-indent',
  'chrisbra/vim-zsh',
  'elzr/vim-json',
  'fladson/vim-kitty',
  'hashivim/vim-terraform',
  'jparise/vim-graphql',
  'keith/swift.vim',
  'leafgarland/typescript-vim',
  'mityu/vim-applescript',
  'neoclide/jsonc.vim',
  'othree/es.next.syntax.vim',
  'othree/yajs.vim',
  'plasticboy/vim-markdown',
  'rhysd/vim-wasm',
  'rust-lang/rust.vim',
  'teal-language/vim-teal',
  'tmux-plugins/vim-tmux',
  'towolf/vim-helm',
  'uarun/vim-protobuf',
  'vim-ruby/vim-ruby',
  {
    'ray-x/go.nvim',
    dependencies = {
      'ray-x/guihua.lua',
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('go').setup({
        diagnostic = false,
        luasnip = true,
        lsp_codelens = false,
      })
      local auid = vim.api.nvim_create_augroup('GoImport', {})
      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*.go',
        callback = function()
          require('go.format').goimport()
        end,
        group = auid,
      })
      vim.api.nvim_create_user_command('GoLintFull',
        [[setl makeprg=golangci-lint\ run\ --config=$HOME/.dotfiles/go/golangci.yml\ --print-issued-lines=false\ --exclude-use-default=false | :GoMake]],
        {})

      vim.keymap.set('n', '<leader>tc', '<cmd>GoCoverage -t <cr>',
        { desc = 'Toggle GoCoverage', noremap = true, silent = true })
    end,
    event = { 'CmdlineEnter' },
    ft = { 'go', 'gomod' },
  }
}
