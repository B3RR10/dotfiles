local M = {}

function M.setup()
  require('mini.diff').setup({
    view = {
      style = 'sign',
      signs = { add = '▍', change = '▍', delete = '▍' },
    },
    mappings = {
      apply = '<Leader>gs',
      reset = '<Leader>gr',
    },
    options = {
      wrap_goto = true,
    },
  })

  vim.keymap.set(
    'n',
    '<Leader>gp',
    function() MiniDiff.toggle_overlay(0) end,
    { desc = 'Toggle diff overlay' }
  )
end

return M
