" =======================================================================
" ftplugin/toml.vim
" =======================================================================

lua require('crates').setup()
lua require('cmp').setup.buffer { sources = { { name = 'crates' } } }

command! CrateMenu      lua require('crates').show_popup()
command! CrateToggle    lua require('crates').toggle()
command! CrateReload    lua require('crates').reload()
command! CrateUpdate    lua require('crates').update_crate()
command! CrateUpdateAll lua require('crates').update_all_crate()
