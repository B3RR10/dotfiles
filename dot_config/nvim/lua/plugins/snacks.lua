---@type LazyPluginSpec
return {
  'folke/snacks.nvim',
  lazy = false,
  priority = 1000,
  opts = {
    input = require('plugins.snacks.input').config,
    notifier = require('plugins.snacks.notifier').config,
    picker = require('plugins.snacks.picker').config,
    statuscolumn = { enabled = true },
    styles = {
      input = require('plugins.snacks.input').style,
    },
    zen = require('plugins.snacks.zen').config,
  },
  keys = {
    { '<leader><leader>', function() Snacks.picker.pickers() end, desc = 'Snacks pickers' },
    { '<leader><space>', function() Snacks.picker.buffers() end, desc = 'Find Buffers' },

    {
      '<leader>ff',
      require('plugins.snacks.picker').find_files_from_project_git_root,
      desc = 'Find files',
    },
    {
      '<leader>fF',
      function() Snacks.picker.files({ cwd = '~/' }) end,
      desc = 'Find files in ~',
    },
    {
      '<leader>fr',
      require('plugins.snacks.picker').live_grep_from_project_git_root,
      desc = 'Grep',
    },

    { '<leader>z', function() Snacks.zen() end, desc = 'Toggle Zen Mode' },
    { '<leader>Z', function() Snacks.zen.zoom() end, desc = 'Toggle Zoom Mode' },

    { '<Leader>ns', function() Snacks.notifier.show_history() end, desc = 'Notification history' },

    {
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
      desc = 'Neovim News',
    },
  },
  init = function() require('plugins.snacks.notifier').lsp_notifications() end,
}
