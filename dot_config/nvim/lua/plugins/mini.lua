return {
  'echasnovski/mini.nvim',
  lazy = false,
  config = function()
    require('mini.ai').setup()
    require('mini.align').setup()
    require('mini.icons').setup()
    require('mini.indentscope').setup()
    require('mini.jump2d').setup()
    require('mini.surround').setup()
    require('mini.tabline').setup()

    require('plugins.mini.bufremove').setup()
    require('plugins.mini.clue').setup()
    require('plugins.mini.diff').setup()
    require('plugins.mini.files').setup()
    require('plugins.mini.pairs').setup()
    require('plugins.mini.statusline').setup()
  end,
  keys = {
    {
      '<C-p>',
      function()
        if not MiniFiles.close() then MiniFiles.open() end
      end,
      desc = 'Toggle file explorer',
    },
    { '<Leader>gp', function() MiniDiff.toggle_overlay(0) end, desc = 'Toggle diff overlay' },
  },
}
