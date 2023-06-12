return {
  { 'nvim-lua/plenary.nvim' },
  {
    'williamboman/mason.nvim',
    opts = {
      ui = {
        border = 'single',
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    },
  },
  {
    'williamboman/mason-lspconfig.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = true,
  },
  {
    'rrethy/vim-hexokinase',
    cmd = 'HexokinaseToggle',
    build = 'make hexokinase',
    config = function()
      vim.g.Hexokinase_optInPatterns = {
        'full_hex',
        'triple_hex',
        'rgb',
        'rgba',
        'hsl',
        'hsla',
      }
    end,
  },
  'junegunn/fzf',
  'junegunn/fzf.vim',
  'windwp/nvim-autopairs',
  'tpope/vim-abolish',
  'tpope/vim-commentary',
  'tpope/vim-eunuch',
  'tpope/vim-repeat',
  'tpope/vim-scriptease',
  {
    'kylechui/nvim-surround',
    event = 'BufReadPost',
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = true,
  },
  { 'dstein64/vim-startuptime', cmd = 'StartupTime' },
  { 'mileszs/ack.vim',          cmd = 'Ack' },
  'ludovicchabant/vim-gutentags',
  {
    'andymass/vim-matchup',
    event = 'BufReadPost',
    config = function()
      vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchparen_deferred_show_delay = 100
      vim.g.matchup_matchparen_offscreen = { method = 'status_manual' }
    end,
  },
  { 'benekastah/neomake' },
  {
    'chrisbra/unicode.vim',
    cmd = { 'UnicodeName', 'UnicodeTable' },
  },
  {
    'christoomey/vim-tmux-navigator',
    cond = function()
      return vim.env.TMUX ~= nil
    end,
  },
  {
    'editorconfig/editorconfig-vim',
    config = function()
      vim.g.EditorConfig_exclude_patterns = { 'fugitive://.*' }
    end,
  },
  { 'junegunn/vim-easy-align' },
  {
    'sbdchd/neoformat',
    cmd = 'Neoformat',
  },
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && yarn install',
    ft = { 'markdown' },
    config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
    end,
  },
  {
    'majutsushi/tagbar',
    cmd = { 'TagbarToggle' },
  },
  {
    'AndrewRadev/bufferize.vim',
    cmd = 'Bufferize',
    config = function()
      vim.g.bufferize_command = 'tabnew'
    end,
  },
  {
    'rcarriga/nvim-notify',
    config = function()
      local notify = require('notify')
      notify.setup({
        background_colour = '#2d2c2b',
        top_down = false,
        timeout = 3000,
        max_width = function()
          return math.floor(vim.o.columns * 0.4)
        end,
        max_height = function()
          return math.floor(vim.o.lines * 0.8)
        end,
        render = function(...)
          local notif = select(2, ...)
          local style = notif.title[1] == '' and 'minimal' or 'default'
          require('notify.render')[style](...)
        end,
      })
      vim.notify = notify
    end,
  },
  {
    'rebelot/heirline.nvim',
    config = function()
      require('ar.heirline')
    end,
  },
  {
    'j-hui/fidget.nvim',
    tag = 'legacy',
    config = true,
  },
  'nanotee/luv-vimdocs',
  'milisims/nvim-luaref',
  {
    'lukas-reineke/headlines.nvim',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    config = function()
      require('headlines').setup({
        markdown = {
          headline_highlights = { 'Headline1', 'Headline2', 'Headline3', 'Headline4', 'Headline5', 'Headline6' },
        },
      })
    end,
  },

  -- Quickfix ----------------------------------------------------------
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    opts = {
      auto_resize_height = true,
      preview = {
        border_chars = { '┃', '┃', '━', '━', '┏', '┓', '┗', '┛', '█' },
        should_preview_cb = function(bufnr)
          -- file size greater than 100kb can't be previewed automatically
          local filename = vim.api.nvim_buf_get_name(bufnr)
          local fsize = vim.fn.getfsize(filename)
          return fsize < 100 * 1024
        end,
      }
    },
  },
  'romainl/vim-qf',

  {
    'folke/trouble.nvim',
    cmd = { 'TroubleToggle', 'Trouble' },
    opts = {
      icons = false,
      indent_lines = false,
      padding = false,
    },
    keys = {
      { '<leader>xx', '<cmd>TroubleToggle document_diagnostics<cr>',  desc = 'Document Diagnostics (Trouble)' },
      { '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<cr>', desc = 'Workspace Diagnostics (Trouble)' },
      { '<leader>xl', '<cmd>TroubleToggle loclist<cr>',               desc = 'Location List (Trouble)' },
      { '<leader>xq', '<cmd>TroubleToggle quickfix<cr>',              desc = 'Quickfix List (Trouble)' },
    },
  },

  -- LSP ----------------------------------------------------------------
  { 'L3MON4D3/LuaSnip' },
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('ar.lsp')
    end,
  },
  { 'rafamadriz/friendly-snippets' },
  { 'simrat39/rust-tools.nvim' },
  { 'folke/neodev.nvim' },
  { 'b0o/SchemaStore.nvim' },
  { 'saecki/crates.nvim' },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    config = function()
      require('ar.cmp')
    end,
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'f3fora/cmp-spell',
      'hrsh7th/cmp-nvim-lua',
      'saadparwaiz1/cmp_luasnip',
      {
        'petertriho/cmp-git',
        dependencies = { 'nvim-lua/plenary.nvim' },
      },
    }
  },
  {
    'SmiteshP/nvim-navic',
    lazy = true,
    dependencies = { 'neovim/nvim-lspconfig' },
  },

  -- Colorscheme --------------------------------------------------------
  { 'sainnhe/gruvbox-material' },
  {
    'mcchrish/zenbones.nvim',
    dependencies = 'rktjmp/lush.nvim',
  },
}
