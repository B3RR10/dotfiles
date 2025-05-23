require('snacks').setup({
  input = { enabled = true },
  lazygit = { enabled = true },
  statuscolumn = { enabled = true },
  styles = {
    input = {
      relative = 'cursor',
      row = -3,
      col = 0,
    },
  },
  zen = {
    enabled = true,
    toggles = {
      dim = false,
      git_signs = false,
      mini_diff_signs = false,
    },
    show = {
      statusline = false,
      tabline = false,
    },
    win = { backdrop = { transparent = false } },
  },
})

vim.keymap.set('n', '<Leader>gg', Snacks.lazygit.open, { desc = 'Lazygit' })
vim.keymap.set('n', '<leader>z', function() Snacks.zen() end, { desc = 'Toggle Zen Mode' })

vim.keymap.set(
  'n',
  '<leader>N',
  function()
    Snacks.win({
      file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
      width = 0.6,
      height = 0.6,
      wo = {
        spell = false,
        wrap = false,
        signcolumn = 'yes',
        statuscolumn = ' ',
        conceallevel = 3,
      },
    })
  end,
  { desc = 'Neovim News' }
)
