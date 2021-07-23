require('compe').setup({
  documentation = false,
  source = {
    path = { menu = '[path]', priority = 10000 },
    nvim_lsp = { menu = '[lsp]', priority = 1000, sort = false },
    nvim_lua = { menu = '[lua]', priority = 100 },
    -- treesitter = {menu = '[treesitter]', priority = 100},
    vsnip = { menu = '[vsnip]', priority = 90 },
    spell = { menu = '[spell]', priority = 20 },
    buffer = { menu = '[buffer]', priority = 10 },
  },
})

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col('.') - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
    return true
  else
    return false
  end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t('<C-n>')
  elseif vim.fn.call('vsnip#available', { 1 }) == 1 then
    return t('<Plug>(vsnip-expand-or-jump)')
  elseif check_back_space() then
    return t('<Tab>')
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t('<C-p>')
  elseif vim.fn.call('vsnip#jumpable', { -1 }) == 1 then
    return t('<Plug>(vsnip-jump-prev)')
  else
    return t('<S-Tab>')
  end
end

local function map(mode, lhs, rhs, opts)
  opts = vim.tbl_extend('keep', opts or {}, { expr = true })
  vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

map('i', '<Tab>', 'v:lua.tab_complete()')
map('s', '<Tab>', 'v:lua.tab_complete()')
map('i', '<S-Tab>', 'v:lua.s_tab_complete()')
map('s', '<S-Tab>', 'v:lua.s_tab_complete()')

map('i', '<C-Space>', 'compe#complete()', { noremap = true })
map('i', '<C-e>', 'compe#close("<C-e>")', { noremap = true })
map('i', '<CR>', 'compe#confirm("<CR>")', { noremap = true })
map('i', '<C-f>', 'compe#scroll({ "delta": +4 })', { noremap = true })
map('i', '<C-d>', 'compe#scroll({ "delta": -4 })', { noremap = true })
