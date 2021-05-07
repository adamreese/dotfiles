local has_gitsigns, gitsigns = pcall(require, "gitsigns")

if not has_gitsigns then
  print("[WARN] gitsigns not found/installed/loaded..")
  return
end

gitsigns.setup {
  debug_mode = true,
  signs = {
    add = {hl = "GitGutterAdd", text = "│"},
    change = {hl = "GitGutterChange", text = "│"},
    delete = {hl = "GitGutterDelete", text = "_"},
    topdelete = {hl = "GitGutterDelete", text = "‾"},
    changedelete = {hl = "GitGutterChangeDelete", text = "~"}
  }
}
