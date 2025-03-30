local harpoon = require('harpoon')
harpoon:setup({ settings = { save_on_toggle = true } })

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

vim.keymap.set(
  'n',
  '<leader>a',
  function() require('harpoon'):list():add() end,
  { desc = 'Add to Harpoon' }
)
vim.keymap.set(
  'n',
  '<leader>l',
  function() require('harpoon').ui:toggle_quick_menu(require('harpoon'):list()) end,
  { desc = 'Harpoon list' }
)
