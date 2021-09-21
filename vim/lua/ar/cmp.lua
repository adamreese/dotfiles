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

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

cmp.setup({
  snippet = {
    expand = function(args)
      -- You must install `vim-vsnip` if you use the following as-is.
      vim.fn['vsnip#anonymous'](args.body)
    end,
  },

  -- You can set mapping if you want.
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
    ['<Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(t('<C-n>'), 'n')
      elseif vim.fn['vsnip#available']() == 1 then
        vim.fn.feedkeys(t('<Plug>(vsnip-expand-or-jump)'), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if vim.fn.pumvisible() == 1 then
        vim.fn.feedkeys(t('<C-p>'), 'n')
      elseif vim.fn['vsnip#available']() == 1 then
        vim.fn.feedkeys(t('<Plug>(vsnip-jump-prev)'), '')
      else
        fallback()
      end
    end,

  },

  -- You should specify your *installed* sources.
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
      })[entry.source.name]
      return item
    end,
  },
})

require('nvim-autopairs').setup({
    check_ts = true
  })

require('nvim-autopairs.completion.cmp').setup({
    map_cr = true,
    map_complete = true,
    auto_select = false,
  })
