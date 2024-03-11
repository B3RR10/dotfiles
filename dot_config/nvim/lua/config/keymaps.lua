local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = true
  vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

-- Escape commands
map('i', 'jk', '<ESC>')
map('i', 'JK', '<ESC>')

-- Moving chars
map('n', 'L', 'xp')
map('n', 'H', 'Xph')

-- Keep visual selection after indent
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Copy to end of line
map('', 'Y', 'y$')

-- Close preview window
map('', '<Leader>p', ':pclose<CR>', { silent = true })
