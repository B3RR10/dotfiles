return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    preset = 'helix',
    delay = 1000,
    notify = false,
    spec = {
      { '<leader>f', group = 'File' },
      { '<leader>g', group = 'Git' },
      { 'gr', group = 'LSP', mode = { 'n', 'v' } },
      { '<leader>n', group = 'Notification' },
    },
  },
}
