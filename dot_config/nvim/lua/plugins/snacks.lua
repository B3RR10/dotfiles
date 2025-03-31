require('snacks').setup({
  input = require('plugins.snacks.input').config,
  lazygit = { enabled = true },
  notifier = require('plugins.snacks.notifier').config,
  statuscolumn = { enabled = true },
  styles = {
    input = require('plugins.snacks.input').style,
  },
  zen = require('plugins.snacks.zen').config,
})

require('plugins.snacks.notifier').lsp_notifications()

vim.keymap.set('n', '<Leader>gg', Snacks.lazygit.open, { desc = 'Lazygit' })
vim.keymap.set('n', '<leader>z', function() Snacks.zen() end, { desc = 'Toggle Zen Mode' })
vim.keymap.set('n', '<Leader>ns', Snacks.notifier.show_history, { desc = 'Notification history' })

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
