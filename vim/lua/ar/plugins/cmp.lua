return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-buffer',
    'f3fora/cmp-spell',
    'hrsh7th/cmp-nvim-lua',
    'saadparwaiz1/cmp_luasnip',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    {
      'petertriho/cmp-git',
      dependencies = { 'nvim-lua/plenary.nvim' },
    },
  },
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')

    local kind_icons = {
      Text = ' text',
      Method = ' method',
      Function = 'ƒ function',
      Constructor = ' constructor',
      Field = '識field',
      Variable = ' variable',
      Class = ' class',
      Interface = 'ﰮ interface',
      Module = ' module',
      Property = ' property',
      Unit = ' unit',
      Value = ' value',
      Enum = '了enum',
      Keyword = ' keyword',
      Snippet = ' snippet',
      Color = ' color',
      File = ' file',
      Reference = '渚ref',
      Folder = ' folder',
      EnumMember = ' enum member',
      Constant = ' const',
      Struct = ' struct',
      Event = '鬒event',
      Operator = '\u{03a8} operator',
      TypeParameter = ' type param',
    }

    local function has_words_before()
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
    end

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      window = {
        completion = {
          border = 'single',
          winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
          col_offset = -3,
        },
        documentation = {
          border = 'single',
          winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
          col_offset = -3,
        },
      },
      preselect = 'None',
      mapping = {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = false,
        }),
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      },
      sources = {
        { name = 'lazydev', group_index = 0 },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'path' },
        { name = 'luasnip' },
        {
          name = 'buffer',
          keyword_length = 3,
          max_item_count = 5,
          option = {
            get_bufnrs = function()
              -- only return listed buffers under a megabyte
              return vim.tbl_filter(
                function(bufnr)
                  local byte_size = vim.api.nvim_buf_get_offset(bufnr, vim.api.nvim_buf_line_count(bufnr))
                  return byte_size < 1024 * 1024 and vim.bo[bufnr].buflisted
                end,
                vim.tbl_map(vim.api.nvim_win_get_buf, vim.api.nvim_list_wins())
              )
            end,
          },
        },
        { name = 'git' },
        { name = 'spell' },
        { name = 'nvim_lsp_signature_help' },
      },
      formatting = {
        format = function(entry, item)
          if entry.source.name == 'nvim_lsp_signature_help' then
            local parts = vim.split(item.abbr, ' ', {})
            item.abbr = parts[1]:gsub(':$', '')

            local type = table.concat(parts, ' ', 2)
            if type ~= nil and type ~= '' then item.kind = type end
            item.kind_hl_group = 'Type'
          end

          item.kind = kind_icons[item.kind] or item.kind
          item.menu = ({
            nvim_lua = '[lua]',
            path = '[path]',
            spell = '[spell]',
            luasnip = '[snip]',
            buffer = '[buf]',
            cmp_git = '[git]',
            nvim_lsp_signature_help = '[sig]',
          })[entry.source.name] or entry.source.name

          -- use lsp client name
          if entry.source.name == 'nvim_lsp' then
            item.menu = string.format('[%s]', entry.source.source.client.name)
          end

          return item
        end,
      },
      experimental = {
        ghost_text = {
          hl_group = 'Comment',
        },
      },
    })

    -- [ nvim-autopairs ] ----------------------------------------------------------

    require('nvim-autopairs').setup({
      check_ts = true
    })

    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

    require('cmp_git').setup()

    -- [ LuaSnip ] -----------------------------------------------------------------

    vim.keymap.set({ 's', 'i' }, '<c-l>', function()
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { silent = true, desc = 'luasnip expand or jump' })

    -- require('luasnip.loaders.from_vscode').lazy_load()
    require('luasnip.loaders.from_vscode').lazy_load({
      paths = {
        './snippet',
      },
    })
  end,
}
