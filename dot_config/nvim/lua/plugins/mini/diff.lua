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
end

return M
