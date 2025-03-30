require('snacks').setup({
  input = require('plugins.snacks.input').config,
  lazygit = { enabled = true },
  notifier = require('plugins.snacks.notifier').config,
  picker = require('plugins.snacks.picker').config,
  statuscolumn = { enabled = true },
  styles = {
    input = require('plugins.snacks.input').style,
  },
  zen = require('plugins.snacks.zen').config,
})

require('plugins.snacks.notifier').lsp_notifications()

vim.keymap.set('n', '<Leader>gg', function() Snacks.lazygit.open() end, { desc = 'Lazygit' })
vim.keymap.set(
  'n',
  '<leader><leader>',
  function() Snacks.picker.pickers() end,
  { desc = 'Snacks pickers' }
)
vim.keymap.set(
  'n',
  '<leader><space>',
  function() Snacks.picker.buffers() end,
  { desc = 'Find Buffers' }
)
vim.keymap.set(
  'n',
  '<leader>ff',
  require('plugins.snacks.picker').find_files_from_project_git_root,
  { desc = 'Find files' }
)
vim.keymap.set(
  'n',
  '<leader>fF',
  function() Snacks.picker.files({ cwd = '~/' }) end,
  { desc = 'Find files in ~' }
)
vim.keymap.set(
  'n',
  '<leader>fr',
  require('plugins.snacks.picker').live_grep_from_project_git_root,
  { desc = 'Grep' }
)
vim.keymap.set('n', '<leader>z', function() Snacks.zen() end, { desc = 'Toggle Zen Mode' })
vim.keymap.set('n', '<leader>Z', function() Snacks.zen.zoom() end, { desc = 'Toggle Zoom Mode' })
vim.keymap.set(
  'n',
  '<Leader>ns',
  function() Snacks.notifier.show_history() end,
  { desc = 'Notification history' }
)

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
