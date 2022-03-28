local has_gitsigns, gitsigns = pcall(require, "gitsigns")

if not has_gitsigns then
  vim.notify("gitsigns not found/installed/loaded..", vim.log.levels.WARN)
  return
end

gitsigns.setup(
  {
    debug_mode = true,
    signs = {
      add = {hl = "GitGutterAdd", text = "│"},
      change = {hl = "GitGutterChange", text = "│"},
      delete = {hl = "GitGutterDelete", text = "_"},
      topdelete = {hl = "GitGutterDelete", text = "‾"},
      changedelete = {hl = "GitGutterChangeDelete", text = "~"}
    },
    keymaps = {
      noremap = true,
      buffer = true,
      ["n ]c"] = {expr = true, [[&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>']]},
      ["n [c"] = {expr = true, [[&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>']]},
      -- Text objects
      ['o ih'] = ':<C-U>Gitsigns select_hunk()<CR>',
      ['x ih'] = ':<C-U>Gitsigns select_hunk()<CR>',
    }
  }
)
