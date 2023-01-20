vim.g.mapleader = ','
vim.g.maplocalleader = ','

vim.keymap.set('n', 'ZA', '<cmd>quitall!<cr>')
vim.keymap.set('n', '<leader>Q', '<cmd>quitall!<cr>')
vim.keymap.set('n', '<leader>q', '<cmd>quit!<cr>')
vim.keymap.set('n', '<leader>w', '<cmd>write!<cr>')

-- remove search highlight
vim.keymap.set('n', '<leader><cr>', '<cmd>nohlsearch<cr>')

-- toggle spell checking
vim.keymap.set('n', '<leader>ss', '<cmd>setlocal spell!<cr>')

-- format buffer
vim.keymap.set('n', '<leader>=', 'ggVG=<cr>')

-- copy to system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"*y')
vim.keymap.set({ 'n', 'v' }, '<leader>Y', '"*Y')

-- paste from system clipboard
vim.keymap.set('n', '<leader>p', '"*p')

-- disable ex mode
vim.keymap.set('n', 'gQ', '<Nop>')

-- disable sleep mapping
vim.keymap.set('n', 'gs', '<Nop>')

-- disable q window
vim.keymap.set('n', 'q:', ':q')

-- map Q for formatting rather than Ex mode
vim.keymap.set('n', 'Q', 'm`gqap``')
vim.keymap.set('v', 'Q', 'gq')

-- Visual shifting (does not exit Visual mode)
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Make dot work in visual mode
vim.keymap.set('v', '.', '<cmd>norm.<cr>')

-- wrapped lines goes down/up to next row, rather than next line in file.
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- remap H and L (top, bottom of screen to left and right end of line).
vim.keymap.set('n', 'H', 'g^')
vim.keymap.set('v', 'H', 'g^')
vim.keymap.set('n', 'L', 'g$')
vim.keymap.set('v', 'L', 'g$')

-- better split switching
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- split sizing
vim.keymap.set('n', '<C-=>', '<C-w>=')

-- keep focused in center of screen when searching
vim.keymap.set('n', 'n', [[(v:searchforward ? 'nzzzv' : 'Nzzzv')]], { expr = true })
vim.keymap.set('n', 'N', [[(v:searchforward ? 'Nzzzv' : 'nzzzv')]], { expr = true })
vim.keymap.set('v', 'n', [[(v:searchforward ? 'nzzzv' : 'Nzzzv')]], { expr = true })
vim.keymap.set('v', 'N', [[(v:searchforward ? 'Nzzzv' : 'nzzzv')]], { expr = true })

-- center screen
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- spelling fix
vim.keymap.set('n', '<C-S>', '[s1z=<C-o>')
vim.keymap.set('i', '<C-S>', '<C-g>u<Esc>[s1z=`]A<C-g>u')

-- get more information from ctrl-g
vim.keymap.set('n', '<C-g>', '2<C-g>')

-- reselect last-pasted text
vim.keymap.set('n', 'gp', '`[v`]')

-- command mode emacs style bindings
vim.keymap.set('c', '<C-a>', '<Home>')
vim.keymap.set('c', '<C-b>', '<Left>')
vim.keymap.set('c', '<C-d>', '<Del>')
vim.keymap.set('c', '<C-f>', '<Right>')
vim.keymap.set('c', '<C-n>', '<Down>')
vim.keymap.set('c', '<C-p>', '<Up>')
