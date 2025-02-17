return {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewFileHistory', 'DiffviewOpen' },
  opts = true,
  -- stylua: ignore
  keys = {
    { '<Leader>gd', '<cmd>DiffviewOpen<CR>', desc = 'Open Diffview' },
  },
}
