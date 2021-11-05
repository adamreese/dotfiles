local cmp = require('cmp')

local kind_icons = {
  Text = " text", -- Text
  Method = " method", -- Method
  Function = "ƒ function", -- Function
  Constructor = " constructor", -- Constructor
  Field = "識field", -- Field
  Variable = " variable", -- Variable
  Class = " class", -- Class
  Interface = "ﰮ interface", -- Interface
  Module = " module", -- Module
  Property = " property", -- Property
  Unit = " unit", -- Unit
  Value = " value", -- Value
  Enum = "了enum", -- Enum 
  Keyword = " keyword", -- Keyword
  Snippet = " snippet", -- Snippet
  Color = " color", -- Color
  File = " file", -- File
  Reference = "渚ref", -- Reference
  Folder = " folder", -- Folder
  EnumMember = " enum member", -- EnumMember
  Constant = " const", -- Constant
  Struct = " struct", -- Struct
  Event = "鬒event", -- Event
  Operator = "\u{03a8} operator", -- Operator
  TypeParameter = " type param", -- TypeParameter
}

local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
    end,
  },

  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
    }),
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn['vsnip#available']() then
        vim.fn.feedkeys(t('<Plug>(vsnip-expand-or-jump)'), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn['vsnip#available']() then
        vim.fn.feedkeys(t('<Plug>(vsnip-jump-prev)'), '')
      else
        fallback()
      end
    end,
  },

  sources = {
    { name = "path" },
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'vsnip' },
    { name = 'spell' },
    { name = 'buffer' },
  },

  formatting = {
    format = function(entry, item)
      item.kind = kind_icons[item.kind]
      item.menu = ({
        nvim_lsp = '[lsp]',
        nvim_lua = '[lua]',
        path = '[path]',
        spell = '[spell]',
        vsnip = '[vsnip]',
        buffer = '[buf]',
        cmdline = '[cmd]',
      })[entry.source.name]
      return item
    end,
  },
})

cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- [ nvim-autopairs ] ----------------------------------------------------------

require('nvim-autopairs').setup({
  check_ts = true
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
