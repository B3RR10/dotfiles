-- Escape commands
vim.keymap.set('i', 'jk', '<ESC>', { noremap = true })
vim.keymap.set('i', 'JK', '<ESC>', { noremap = true })

-- Moving chars
vim.keymap.set('n', 'L', 'xp', { noremap = true })
vim.keymap.set('n', 'H', 'Xph', { noremap = true })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Keep visual selection after indent
vim.keymap.set('v', '<', '<gv', { noremap = true })
vim.keymap.set('v', '>', '>gv', { noremap = true })

-- nohlsearch
vim.keymap.set('n', '<Esc>', ':noh<CR>', { noremap = true, silent = true })
