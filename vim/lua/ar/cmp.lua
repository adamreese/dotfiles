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
  },
  preselect = 'None',
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
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
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'path' },
    { name = 'luasnip' },
    {
      name = 'buffer',
      keyword_length = 3,
      max_item_count = 5,
      options = {
        get_bufnrs = function()
          local bufs = {}
          for _, win in ipairs(vim.api.nvim_list_wins()) do
            bufs[vim.api.nvim_win_get_buf(win)] = true
          end
          return vim.tbl_keys(bufs)
        end,
      },
    },
    { name = 'git' },
    { name = 'spell' },
  },
  formatting = {
    format = function(entry, item)
      item.kind = kind_icons[item.kind]
      item.menu = ({
        nvim_lsp = '[lsp]',
        nvim_lua = '[lua]',
        path = '[path]',
        spell = '[spell]',
        luasnip = '[snip]',
        buffer = '[buf]',
        cmp_git = '[git]',
      })[entry.source.name]
      return item
    end,
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
