-- Escape commands
vim.keymap.set('i', 'jk', '<ESC>', { noremap = true })
vim.keymap.set('i', 'JK', '<ESC>', { noremap = true })

-- Moving chars
vim.keymap.set('n', 'L', 'xp', { noremap = true })
vim.keymap.set('n', 'H', 'Xph', { noremap = true })

-- Keep visual selection after indent
vim.keymap.set('v', '<', '<gv', { noremap = true })
vim.keymap.set('v', '>', '>gv', { noremap = true })

-- Copy to end of line
vim.keymap.set('', 'Y', 'y$', { noremap = true })

-- nohlsearch
vim.keymap.set('n', '<Esc>', ':noh<CR>', { noremap = true, silent = true })
