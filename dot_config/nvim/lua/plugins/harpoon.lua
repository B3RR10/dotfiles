return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {
    settings = { save_on_toggle = true },
  },
  config = function(_, opts)
    local harpoon = require('harpoon')
    harpoon:setup(opts)

    harpoon:extend({
      UI_CREATE = function(cx)
        vim.keymap.set(
          'n',
          '<C-v>',
          function() harpoon.ui:select_menu_item({ vsplit = true }) end,
          { buffer = cx.bufnr }
        )

        vim.keymap.set(
          'n',
          '<C-s>',
          function() harpoon.ui:select_menu_item({ split = true }) end,
          { buffer = cx.bufnr }
        )

        vim.keymap.set(
          'n',
          '<C-t>',
          function() harpoon.ui:select_menu_item({ tabedit = true }) end,
          { buffer = cx.bufnr }
        )
      end,
    })

    local harpoon_extensions = require('harpoon.extensions')
    harpoon:extend(harpoon_extensions.builtins.highlight_current_file())
  end,
  keys = {
    {
      '<leader>a',
      function() require('harpoon'):list():add() end,
      desc = 'Add to Harpoon',
    },
    {
      '<leader>l',
      function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end,
      desc = 'Harpoon list',
    },
  },
}
