vim.filetype.add({
  filename = {
    ['.envrc'] = 'sh',
    ['.luacheckrc'] = 'lua',
    ['Brewfile'] = 'ruby',
    ['HIPPOFACTS'] = 'toml',
    ['tsconfig.json'] = 'jsonc',
  },
  extension = {
    cake = 'cs',
    conf = 'conf',
    csx = 'cs',
    nomad = 'hcl',
    sln = 'sln',
  },
  pattern = {
    ['[Dd]ockerfile.*[^.vim]'] = 'dockerfile',
  },
})
