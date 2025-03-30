require('illuminate').configure({
  large_file_cutoff = 2000,
  large_file_overrides = {
    providers = { 'lsp', 'treesitter' },
  },
})

vim.keymap.set(
  'n',
  '[[',
  function() require('illuminate').goto_prev_reference() end,
  { desc = 'Prev Reference' }
)
vim.keymap.set(
  'n',
  ']]',
  function() require('illuminate').goto_next_reference() end,
  { desc = 'Next Reference' }
)
