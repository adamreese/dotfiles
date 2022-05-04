local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
local compile_path = vim.fn.stdpath('cache') .. '/packer/packer_compiled.lua'

if not vim.fn.isdirectory(install_path) then
  vim.cmd('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.cmd [[packadd packer.nvim]]

local packer = require('packer')

packer.init({
  compile_path = compile_path
})

packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'lewis6991/impatient.nvim'
  use 'nvim-lua/plenary.nvim'

  -- Plug 'Shougo/context_filetype.vim'

  -- let g:echodoc_enable_at_startup  = 1
  -- let g:echodoc#type = 'virtual'
  -- Plug 'Shougo/echodoc.vim'

  use 'norcalli/nvim-colorizer.lua'
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use 'windwp/nvim-autopairs'
  use 'tpope/vim-abolish'
  use 'tpope/vim-commentary'
  use 'tpope/vim-eunuch'
  use 'tpope/vim-repeat'
  use 'tpope/vim-scriptease'
  use 'tpope/vim-surround'
  use 'dstein64/vim-startuptime'
  use 'osyo-manga/vim-anzu'
  use 'preservim/nerdtree'
  use 'mileszs/ack.vim'
  use 'ludovicchabant/vim-gutentags'

  use { 'andymass/vim-matchup',
    config = function()
      vim.g.matchup_matchparen_deferred = 1
      vim.g.matchup_matchparen_status_offscreen = 0
      vim.g.matchup_matchparen_deferred_show_delay = 100
    end
  }
  use { 'benekastah/neomake',
    -- cmd = { 'Neomake' },
  }
  use { 'chrisbra/unicode.vim',
    -- cmd = { 'UnicodeName', 'UnicodeTable' },
  }

  use 'christoomey/vim-tmux-navigator' -- PlugIf(exists('$TMUX'))
  use {'editorconfig/editorconfig-vim',
    config = function()
      vim.g.EditorConfig_exclude_patterns = {'fugitive://.*'}
    end,
  }
  use 'filipekiss/cursed.vim'
  use 'haya14busa/incsearch.vim'
  use 'itchyny/lightline.vim'
  use 'junegunn/vim-easy-align' -- { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
  use { 'sbdchd/neoformat',
    -- cmd = 'Neoformat',
  }

  use { 'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  }
  use { 'nvim-treesitter/nvim-treesitter-textobjects' }

  use {
    'iamcco/markdown-preview.nvim',
    run = 'cd app && yarn install',
    ft = { 'markdown' },
    config = function()
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
    end,
  }

  use 'lvht/tagbar-markdown'
  use { 'majutsushi/tagbar',
    -- cmd = { 'TagbarToggle' },
  }

  use { 'AndrewRadev/bufferize.vim',
    -- cmd = { 'Bufferize' },
    config = function()
      vim.g.bufferize_command = 'tabnew'
    end,
  }

  -- Version Control ---------------------------------------------------
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
  }
  use {
    'rhysd/committia.vim',
    config = function()
      vim.g.committia_open_only_vim_starting = false
    end,
  }
  use 'tpope/vim-fugitive'
  use 'tpope/vim-git'
  use 'tpope/vim-rhubarb'

  -- Quickfix ----------------------------------------------------------
  use 'kevinhwang91/nvim-bqf'
  use 'romainl/vim-qf'
  use 'blueyed/vim-qf_resize'


  -- Languages ----------------------------------------------------------
  use 'PotatoesMaster/i3-vim-syntax'
  use 'adamclerk/vim-razor'
  use 'cespare/vim-toml'
  use 'chrisbra/vim-sh-indent'
  use 'chrisbra/vim-zsh'
  use 'elzr/vim-json'
  use 'fatih/vim-go'
  use 'hashivim/vim-terraform'
  use 'jparise/vim-graphql'
  use 'keith/swift.vim'
  use 'leafgarland/typescript-vim'
  use 'mityu/vim-applescript'
  use 'neoclide/jsonc.vim'
  use 'othree/es.next.syntax.vim'
  use 'othree/yajs.vim'
  use 'plasticboy/vim-markdown'
  use 'rhysd/vim-wasm'
  use 'rust-lang/rust.vim'
  use 'teal-language/vim-teal'
  use 'tmux-plugins/vim-tmux'
  use 'towolf/vim-helm'
  use 'uarun/vim-protobuf'
  use 'vim-ruby/vim-ruby'

  -- LSP ----------------------------------------------------------------
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/lsp-status.nvim'
  use 'ojroques/nvim-lspfuzzy'
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'
  use 'simrat39/rust-tools.nvim'
  use 'folke/lua-dev.nvim'
  use 'b0o/SchemaStore.nvim'
  use 'mickael-menu/zk-nvim'
  use 'saecki/crates.nvim'

  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'f3fora/cmp-spell'
  use 'hrsh7th/cmp-nvim-lua'
  use 'saadparwaiz1/cmp_luasnip'
  use 'hrsh7th/cmp-cmdline'
  use 'petertriho/cmp-git'

  -- Testing -----------------------------------------------------------
  use 'jbyuki/venn.nvim'
  use 'simrat39/symbols-outline.nvim'
  use 'stevearc/aerial.nvim'

end)

vim.api.nvim_create_augroup('ar_plugins', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = 'plugins.lua',
  command = 'source <afile> | PackerSync',
  group = 'ar_plugins',
})
vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = 'plugins.lua',
  command = 'source <afile> | PackerCompile',
  group = 'ar_plugins',
})
