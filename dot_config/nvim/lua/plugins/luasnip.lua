require('luasnip').setup({
  history = true,
  delete_check_events = 'TextChanged',
})

require('luasnip.loaders.from_snipmate').lazy_load()
require('luasnip.loaders.from_snipmate').lazy_load({ paths = { './snippets' } })
require('luasnip.loaders.from_vscode').lazy_load()

vim.keymap.set(
  'i',
  '<C-j>',
  function() return require('luasnip').jumpable(1) and '<Plug>luasnip-jump-next' or '<C-j>' end,
  { expr = true, remap = true, silent = true }
)
vim.keymap.set('s', '<C-j>', function() require('luasnip').jump(1) end)
vim.keymap.set({ 'i', 's' }, '<C-k>', function() require('luasnip').jump(-1) end)
