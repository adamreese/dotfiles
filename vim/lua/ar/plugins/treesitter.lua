return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  event = { 'BufReadPost', 'BufNewFile' },
  build = ':TSUpdate',
  dependencies = {
    { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'main' },
  },
  config = function()
    local ensure_installed = {
      'bash',
      'c',
      'c_sharp',
      'cmake',
      'comment',
      'cpp',
      'css',
      'diff',
      'dockerfile',
      'git_rebase',
      'gitcommit',
      'go',
      'godot_resource',
      'gomod',
      'gosum',
      'gotmpl',
      'gowork',
      'graphql',
      'hcl',
      'html',
      'javascript',
      'jsdoc',
      'json',
      'json5',
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
      'sql',
      'toml',
      'tsx',
      'terraform',
      'typescript',
      'vim',
      'vue',
      'wit',
      'yaml',
    }

    require('nvim-treesitter').setup({})

    -- Install any parsers that are not yet installed.
    local installed = require('nvim-treesitter.config').get_installed('parsers')
    local to_install = {}
    for _, lang in ipairs(ensure_installed) do
      if not vim.tbl_contains(installed, lang) then
        table.insert(to_install, lang)
      end
    end
    if #to_install > 0 then
      require('nvim-treesitter').install(to_install)
    end

    -- Enable highlighting, folding and indentation for installed filetypes.
    vim.api.nvim_create_autocmd('FileType', {
      callback = function(args)
        local buf = args.buf
        local ft = vim.bo[buf].filetype
        local lang = vim.treesitter.language.get_lang(ft)
        if not lang or not vim.tbl_contains(
              require('nvim-treesitter.config').get_installed('parsers'), lang) then
          return
        end
        pcall(vim.treesitter.start, buf)
        vim.wo[0][0].foldmethod = 'expr'
        vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })

    require('nvim-treesitter-textobjects').setup({
      select = {
        lookahead = true,
      },
    })

    local select = require('nvim-treesitter-textobjects.select')
    local map = function(key, obj)
      vim.keymap.set({ 'x', 'o' }, key, function()
        select.select_textobject(obj, 'textobjects')
      end, { desc = 'Select ' .. obj })
    end
    map('af', '@function.outer')
    map('if', '@function.inner')
    map('ac', '@class.outer')
    map('ic', '@class.inner')
  end,
}
